import 'package:churchms/db/database.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/models/models.dart';
import 'package:churchms/providers/auth.dart';
import 'package:churchms/providers/repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';

/// The Pastors tab derives its list from the branches, departments and groups
/// themselves. These prove the derivation, and that it cannot drift: change who
/// leads something and the list changes with it.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late Fixtures fx;
  late ProviderContainer container;
  late String branchId;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    fx = Fixtures(db);
    branchId = await fx.branch();
    container =
        ProviderContainer(overrides: [databaseProvider.overrideWithValue(db)]);
    addTearDown(container.dispose);

    // Everything below reads scoped providers, and scope comes from the signed
    // in account: with nobody signed in, activeBranchIds is empty and every
    // member and department is filtered out. A Super Admin sees all branches.
    container.read(sessionProvider.notifier).refresh(StaffUser(
          id: 'usr-test',
          name: 'Test Admin',
          username: 'admin',
          role: UserRole.superAdmin,
          lastActiveAt: DateTime.now().toUtc(),
          status: AccountStatus.active,
          branchAccessGrant: true,
        ));
  });

  tearDown(() => db.close());

  /// Lets every stream the derived providers depend on deliver a frame.
  ///
  /// A StreamProvider serves its latest emission, and the frame it already had
  /// may predate the write under test — so this keeps a live subscription open
  /// (an unlistened provider is disposed between reads) and gives the streams
  /// several microtask turns to catch up.
  Future<void> settle() async {
    for (final provider in [
      branchesStreamProvider,
      departmentsStreamProvider,
      departmentTypesStreamProvider,
      membersStreamProvider,
      smallGroupsStreamProvider,
    ]) {
      container.listen(provider, (_, _) {}, fireImmediately: true);
    }
    for (var i = 0; i < 10; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  test('an unled church has no leaders', () async {
    await settle();
    expect(container.read(leadershipPostsProvider), isEmpty);
    expect(container.read(leadersProvider), isEmpty);
  });

  test('a branch pastor appears as a post', () async {
    final pastor = await fx.member(branchId: branchId, age: 44);
    await repo.setBranchLeadership(branchId, pastorId: pastor);
    await settle();

    final posts = container.read(leadershipPostsProvider);
    expect(posts, hasLength(1));
    expect(posts.single.role, LeadershipRole.branchPastor);
    expect(posts.single.memberId, pastor);
  });

  test('one person holding two posts is a single row', () async {
    final person = await fx.member(branchId: branchId, age: 40);
    final departmentId = await fx.department(branchId: branchId, headId: person);
    await repo.setBranchLeadership(branchId, pastorId: person);
    await settle();

    expect(container.read(leadershipPostsProvider), hasLength(2));

    final leaders = container.read(leadersProvider);
    expect(leaders, hasLength(1), reason: 'one person, one row');
    expect(leaders.single.posts, hasLength(2));
    // Sorted by seniority, so the pastoral post leads.
    expect(leaders.single.posts.first.role, LeadershipRole.branchPastor);
    expect(departmentId, isNotEmpty);
  });

  test('replacing a leader replaces the post, leaving nothing stale', () async {
    final first = await fx.member(branchId: branchId, age: 45);
    final second = await fx.member(branchId: branchId, age: 38);

    await repo.setBranchLeadership(branchId, pastorId: first);
    await settle();
    expect(container.read(leadersProvider).single.member.id, first);

    await repo.setBranchLeadership(branchId, pastorId: second);
    await settle();

    final leaders = container.read(leadersProvider);
    expect(leaders, hasLength(1),
        reason: 'the previous pastor must not linger as a second row');
    expect(leaders.single.member.id, second);
  });

  test('a group leader from another branch is refused', () async {
    final otherBranch = await fx.branch(name: 'Tema', code: 'TEM');
    final outsider = await fx.member(branchId: otherBranch, age: 30);
    final groupId = await repo.createSmallGroup(
      branchId: branchId,
      name: 'Young Adults',
      meetingDay: Weekday.wednesday,
      meetingTime: '18:00',
    );

    await repo.setGroupLeader(groupId, outsider);
    await settle();

    expect(container.read(leadershipPostsProvider), isEmpty,
        reason: 'a group is led by someone who belongs to its branch');
  });

  test('a group leader from the same branch is accepted', () async {
    final member = await fx.member(branchId: branchId, age: 26);
    final groupId = await repo.createSmallGroup(
      branchId: branchId,
      name: 'Young Adults',
      meetingDay: Weekday.wednesday,
      meetingTime: '18:00',
    );

    await repo.setGroupLeader(groupId, member);
    await settle();

    final posts = container.read(leadershipPostsProvider);
    expect(posts, hasLength(1));
    expect(posts.single.role, LeadershipRole.groupLeader);
    expect(posts.single.scopeName, 'Young Adults');
  });
}
