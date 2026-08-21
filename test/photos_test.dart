import 'package:churchms/db/database.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';

/// Member photos are stored as a filename, resolved against the app's own photo
/// directory. These cover the column and the rule that decides which files are
/// safe to delete — the one place a bug would destroy something.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late Fixtures fx;
  late String branchId;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    fx = Fixtures(db);
    branchId = await fx.branch();
  });

  tearDown(() => db.close());

  test('a member starts with no photo', () async {
    await fx.member(branchId: branchId);
    final member = (await repo.watchMembers().first).single;

    expect(member.photo, isEmpty);
  });

  test('a photo filename persists and can be replaced or cleared', () async {
    final id = await repo.createMember(
      branchId: branchId,
      firstName: 'Ama',
      lastName: 'Owusu',
      gender: Gender.female,
      dateOfBirth: DateTime.utc(1990, 1, 1),
      maritalStatus: MaritalStatus.single,
      status: MemberStatus.active,
      isBaptized: true,
      photo: 'mem-111.jpg',
    );

    Future<Member> read() async =>
        (await repo.watchMembers().first).firstWhere((m) => m.id == id);

    expect((await read()).photo, 'mem-111.jpg');

    await repo.updateMember(id, photo: 'mem-222.png');
    expect((await read()).photo, 'mem-222.png');

    await repo.updateMember(id, photo: '');
    expect((await read()).photo, isEmpty);
  });

  test('an unrelated edit leaves the photo alone', () async {
    final id = await repo.createMember(
      branchId: branchId,
      firstName: 'Kofi',
      lastName: 'Mensah',
      gender: Gender.male,
      dateOfBirth: DateTime.utc(1985, 1, 1),
      maritalStatus: MaritalStatus.married,
      status: MemberStatus.active,
      isBaptized: true,
      photo: 'mem-333.jpg',
    );

    await repo.updateMember(id, phone: '024 000 1111');
    final member =
        (await repo.watchMembers().first).firstWhere((m) => m.id == id);

    expect(member.photo, 'mem-333.jpg',
        reason: 'an omitted field must not be blanked');
  });

  group('which photo files are in use', () {
    test('lists only names actually referenced', () async {
      await repo.createMember(
        branchId: branchId,
        firstName: 'A',
        lastName: 'One',
        gender: Gender.female,
        dateOfBirth: DateTime.utc(1990, 1, 1),
        maritalStatus: MaritalStatus.single,
        status: MemberStatus.active,
        isBaptized: true,
        photo: 'keep-me.jpg',
      );
      // A member with no photo contributes nothing.
      await fx.member(branchId: branchId, lastName: 'Two');

      expect(await repo.allMemberPhotos(), ['keep-me.jpg']);
    });

    test("a soft-deleted member's photo is still in use", () async {
      final id = await repo.createMember(
        branchId: branchId,
        firstName: 'A',
        lastName: 'One',
        gender: Gender.female,
        dateOfBirth: DateTime.utc(1990, 1, 1),
        maritalStatus: MaritalStatus.single,
        status: MemberStatus.active,
        isBaptized: true,
        photo: 'deleted-member.jpg',
      );

      await repo.deleteMember(id);

      // They are gone from the directory...
      expect(await repo.watchMembers().first, isEmpty);
      // ...but the row can still be restored, so the photo is not litter.
      expect(await repo.allMemberPhotos(), contains('deleted-member.jpg'),
          reason: 'pruning must not delete a recoverable member\'s photo');
    });

    test('photos outside the visible branch scope are still in use', () async {
      // allMemberPhotos deliberately ignores branch scope: pruning while signed
      // in as one branch must not delete another branch's photos.
      final other = await fx.branch(name: 'Tema', code: 'TEM');
      await repo.createMember(
        branchId: other,
        firstName: 'Yaw',
        lastName: 'Away',
        gender: Gender.male,
        dateOfBirth: DateTime.utc(1988, 1, 1),
        maritalStatus: MaritalStatus.single,
        status: MemberStatus.active,
        isBaptized: true,
        photo: 'other-branch.jpg',
      );

      expect(await repo.allMemberPhotos(), contains('other-branch.jpg'));
    });
  });
}
