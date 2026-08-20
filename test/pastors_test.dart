import 'package:churchms/db/database.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/models/models.dart';
import 'package:churchms/providers/auth.dart';
import 'package:churchms/providers/repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';

/// A branch can have several pastors, only one of whom leads it.
///
/// The title is a property of the person: it is not a leadership post and not a
/// system role. These tests pin all three of those apart, because conflating
/// them is exactly what would let a title quietly grant access.
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

  Future<String> pastor(String title, {String lastName = 'Mensah'}) =>
      repo.createMember(
        branchId: branchId,
        firstName: 'Kofi',
        lastName: lastName,
        gender: Gender.male,
        dateOfBirth: DateTime.utc(1980, 1, 1),
        maritalStatus: MaritalStatus.married,
        status: MemberStatus.active,
        isBaptized: true,
        title: title,
      );

  test('a title persists on the member', () async {
    final id = await pastor('Associate Pastor');
    final member = (await repo.watchMembers().first).single;

    expect(member.id, id);
    expect(member.title, 'Associate Pastor');
    expect(member.displayName, 'Associate Pastor Kofi Mensah');
    // The plain name stays plain, so sorting and matching are unaffected.
    expect(member.fullName, 'Kofi Mensah');
  });

  test('one branch can hold several pastors', () async {
    final leader = await pastor('Snr. Pastor', lastName: 'Boateng');
    await pastor('Associate Pastor', lastName: 'Owusu');
    await pastor('Youth Pastor', lastName: 'Danso');
    // Only one of them leads the branch.
    await repo.setBranchLeadership(branchId, pastorId: leader);
    await settle();

    expect(container.read(pastorsProvider), hasLength(3),
        reason: 'a branch is not limited to one pastor');

    final posts = container.read(leadershipPostsProvider);
    expect(posts, hasLength(1));
    expect(posts.single.memberId, leader);
  });

  test('every pastor appears in the list, led or not', () async {
    final leader = await pastor('Snr. Pastor', lastName: 'Boateng');
    await pastor('Youth Pastor', lastName: 'Danso');
    await repo.setBranchLeadership(branchId, pastorId: leader);
    await settle();

    final leaders = container.read(leadersProvider);
    expect(leaders, hasLength(2));
    // The one holding a post sorts first; the titled pastor still has a row.
    expect(leaders.first.member.id, leader);
    expect(leaders.first.posts, hasLength(1));
    expect(leaders.last.posts, isEmpty);
  });

  test('a title grants no access to the system', () async {
    await pastor('Snr. Pastor');
    await settle();

    // The member exists and is a pastor...
    expect(container.read(pastorsProvider), hasLength(1));
    // ...but no sign-in account was created for them.
    expect(await repo.watchUsers().first, isEmpty,
        reason: 'a pastoral title must not imply a login');
  });

  test('titles are recognised however the church words them', () {
    // Matched on the text rather than a fixed list, because the church chooses
    // its own wording and a list would keep needing code changes.
    for (final title in [
      'Pastor',
      'Snr. Pastor',
      'Associate Pastor',
      'Reverend',
      'Rev. Dr.',
      'Bishop',
      'Apostle',
      'Evangelist',
      'Minister',
    ]) {
      expect(titled(title).isPastor, isTrue, reason: title);
    }

    // Other honorifics are real titles but not pastoral ones.
    for (final title in ['', 'Deacon', 'Elder', 'Mr', 'Dr']) {
      expect(titled(title).isPastor, isFalse, reason: '"$title" is not pastoral');
    }
  });

  test('an untitled member is not a pastor and has no honorific', () async {
    await fx.member(branchId: branchId);
    await settle();

    final member = (await repo.watchMembers().first).single;
    expect(member.title, isEmpty);
    expect(member.isPastor, isFalse);
    expect(member.displayName, member.fullName);
    expect(container.read(pastorsProvider), isEmpty);
  });

  test('a title can be added to an existing member and removed again',
      () async {
    final id = await fx.member(branchId: branchId);

    await repo.updateMember(id, title: 'Associate Pastor');
    expect((await repo.watchMembers().first).single.isPastor, isTrue);

    await repo.updateMember(id, title: '');
    expect((await repo.watchMembers().first).single.isPastor, isFalse);
  });
}

/// A member carrying [title], for testing the title rules alone.
Member titled(String title) => Member(
      id: 'mem-x',
      firstName: 'Kofi',
      lastName: 'Mensah',
      email: '',
      phone: '',
      gender: Gender.male,
      dateOfBirth: DateTime.utc(1980, 1, 1),
      maritalStatus: MaritalStatus.single,
      status: MemberStatus.active,
      joinedAt: DateTime.utc(2020, 1, 1),
      address: const Address(line1: '', city: '', state: '', country: 'Ghana'),
      isBaptized: true,
      branchId: 'brn-x',
      title: title,
    );
