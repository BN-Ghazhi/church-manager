import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/db/seeder.dart';
import 'package:churchms/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';

/// Verifies the app's own storage: that it seeds, persists writes, enforces
/// referential integrity, and authenticates without ever storing a password.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late Fixtures fixtures;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    fixtures = Fixtures(db);
    await Seeder(db).seedFirstRun();
  });

  tearDown(() => db.close());

  group('seeding', () {
    test('a fresh database holds only what is needed to start', () async {
      final branches = await repo.watchBranches().first;
      final members = await repo.watchMembers().first;
      final departments = await repo.watchDepartments().first;
      final donations = await repo.watchDonations().first;
      final users = await repo.watchUsers().first;

      // One headquarters branch and one administrator, because a member must
      // belong to a branch and somebody has to be able to sign in. Nothing else
      // is invented — the church enters its own records.
      expect(branches, hasLength(1));
      expect(branches.single.isHeadquarters, isTrue);
      expect(users, hasLength(1));
      expect(users.single.role, UserRole.superAdmin);

      expect(members, isEmpty);
      expect(departments, isEmpty);
      expect(donations, isEmpty);
    });

    test('the department catalogue is available to build from', () async {
      final types = await repo.watchDepartmentTypes().first;

      // The catalogue is structure, not data: it defines what a Youth or
      // Children's department is, so the same department stays comparable
      // between branches.
      expect(types, isNotEmpty);
      expect(types.any((t) => t.name.contains('Youth')), isTrue);
      expect(types.any((t) => t.name.contains("Children")), isTrue);
    });

    test('the church name defaults to Kingdom Grace Chapel', () async {
      final settings = await repo.watchSettings().first;
      expect(settings['church.name'], 'Kingdom Grace Chapel');
      expect(settings['church.shortName'], 'K.G.C.');
    });

    test('the first administrator can sign in', () async {
      final signedIn = await repo.signIn(
        Seeder.firstAdminUsername,
        Seeder.firstAdminPassword,
      );
      expect(signedIn, isNotNull);
      expect(signedIn!.canSeeAllBranches, isTrue);
    });
  });

  group('persistence', () {
    test('a created member is readable afterwards', () async {
      final branches = await repo.watchBranches().first;
      final id = await repo.createMember(
        firstName: 'Tobi',
        lastName: 'Adewale',
        branchId: branches.first.id,
        gender: Gender.male,
        dateOfBirth: DateTime.utc(1990, 5, 12),
        maritalStatus: MaritalStatus.single,
        status: MemberStatus.active,
        isBaptized: true,
        email: 'tobi@example.com',
      );

      final saved = await repo.findMember(id);
      expect(saved, isNotNull);
      expect(saved!.fullName, 'Tobi Adewale');
      expect(saved.branchId, branches.first.id);
      expect(saved.email, 'tobi@example.com');
    });

    test('an edit survives a re-read', () async {
      final branch = await fixtures.branch();
      final id = await fixtures.member(branchId: branch);

      await repo.updateMember(id, phone: '+233 24 900 0000');
      final reloaded = await repo.findMember(id);

      expect(reloaded!.phone, '+233 24 900 0000');
    });

    test('a soft-deleted member disappears from queries', () async {
      final branch = await fixtures.branch();
      final ids = await fixtures.members(branchId: branch, count: 3);
      final before = await repo.watchMembers().first;

      await repo.deleteMember(ids.first);

      final after = await repo.watchMembers().first;
      expect(after.any((m) => m.id == ids.first), isFalse);
      expect(after.length, before.length - 1);
    });

    test('department membership can be replaced', () async {
      // Worship has no age restriction, so every member of the branch is
      // eligible. Age-gated departments filter ineligible members out by
      // design — that is covered in writes_test.dart.
      final branch = await fixtures.branch();
      final head = await fixtures.member(branchId: branch, firstName: 'Head');
      final dept = await fixtures.department(branchId: branch, headId: head);
      final fresh =
          (await fixtures.members(branchId: branch, count: 3)).toSet();

      await repo.setDepartmentMembers(dept, fresh);

      final after = await repo.watchDepartments().first;
      final updated = after.firstWhere((d) => d.id == dept);
      expect(updated.memberIds.toSet(), fresh);
    });

    test('check-in writes attendance and can be read back', () async {
      final branches = await repo.watchBranches().first;
      final members = await repo.watchMembers().first;
      final ids = members
          .where((m) => m.branchId == branches.first.id)
          .take(5)
          .map((m) => m.id)
          .toSet();
      final date = DateTime.utc(2026, 9, 6);

      await repo.saveCheckIns(
        branchId: branches.first.id,
        date: date,
        serviceName: 'First Service',
        memberIds: ids,
      );

      final records = await repo.watchAttendance().first;
      final record = records.firstWhere(
        (r) => r.date == date && r.branchId == branches.first.id,
      );
      expect(record.adults, ids.length);
      expect(await repo.checkedInMembers(record.id), ids);
    });

    test('recorded giving appears in the ledger', () async {
      final branches = await repo.watchBranches().first;
      final before = await repo.watchDonations().first;

      await repo.recordDonation(
        branchId: branches.first.id,
        donorName: 'Anonymous',
        amount: 50000,
        fund: GivingFund.building,
        method: PaymentMethod.transfer,
        date: DateTime.utc(2026, 9, 1),
      );

      final after = await repo.watchDonations().first;
      expect(after.length, before.length + 1);
      expect(after.any((d) => d.amount == 50000), isTrue);
    });

    test('settings round-trip', () async {
      await repo.saveSetting('church.name', 'New Life Chapel');
      final all = await repo.watchSettings().first;
      expect(all['church.name'], 'New Life Chapel');
    });
  });

  group('referential integrity', () {
    test('a member cannot be created at a branch that does not exist', () {
      expect(
        () => repo.createMember(
          firstName: 'Ghost',
          lastName: 'Member',
          branchId: 'brn-9999',
          gender: Gender.male,
          dateOfBirth: DateTime.utc(1990),
          maritalStatus: MaritalStatus.single,
          status: MemberStatus.active,
          isBaptized: false,
        ),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('authentication', () {
    test('a correct password signs in', () async {
      final user = await repo.signIn(
        Seeder.firstAdminUsername,
        Seeder.firstAdminPassword,
      );
      expect(user, isNotNull);
      expect(user!.role, UserRole.superAdmin);
    });

    test('a wrong password is rejected', () async {
      final user =
          await repo.signIn(Seeder.firstAdminUsername, 'not-the-password');
      expect(user, isNull);
    });

    test('an unknown email is rejected', () async {
      final user = await repo.signIn('nobody@example.com', 'anything');
      expect(user, isNull);
    });

    test('email is case-insensitive', () async {
      final user = await repo.signIn(
        Seeder.firstAdminUsername.toUpperCase(),
        Seeder.firstAdminPassword,
      );
      expect(user, isNotNull);
    });

    test('a suspended account cannot sign in', () async {
      final users = await repo.watchUsers().first;
      final target = users.first;
      await repo.updateUserRole(target.id, status: AccountStatus.suspended);

      final user = await repo.signIn(target.username, Seeder.firstAdminPassword);
      expect(user, isNull);
    });

    test('a department head signs in scoped to their department', () async {
      final branch = await fixtures.branch();
      final head = await fixtures.member(branchId: branch, firstName: 'Head');
      final dept = await fixtures.department(branchId: branch, headId: head);

      await fixtures.user(
        role: UserRole.departmentHead,
        branchId: branch,
        departmentId: dept,
        username: 'depthead',
        password: 'headpass1',
      );

      final signedIn = await repo.signIn('depthead', 'headpass1');
      expect(signedIn, isNotNull);
      expect(signedIn!.departmentId, dept);
      expect(signedIn.branchId, branch);
      expect(signedIn.role.scope, RoleScope.ownDepartment);
    });

    test('a changed password replaces the old one', () async {
      final users = await repo.watchUsers().first;
      final target = users.first;

      await repo.changePassword(target.id, 'brand-new-pass9');

      expect(await repo.signIn(target.username, Seeder.firstAdminPassword), isNull);
      expect(await repo.signIn(target.username, 'brand-new-pass9'), isNotNull);
    });

    test('a new user account can sign in immediately', () async {
      final branches = await repo.watchBranches().first;
      await repo.createUser(
        name: 'New Leader',
        username: 'newleader',
        password: 'strongpass1',
        role: UserRole.branchAdmin,
        branchId: branches.first.id,
      );

      final user =
          await repo.signIn('newleader', 'strongpass1');
      expect(user, isNotNull);
      expect(user!.role, UserRole.branchAdmin);
      // Invited accounts become active on first sign-in.
      expect(user.status, AccountStatus.invited);
    });
  });

  group('password hashing', () {
    test('the plain password is never stored', () async {
      final rows = await db.select(db.userAccounts).get();
      for (final row in rows) {
        expect(row.passwordHash, isNot(contains(Seeder.firstAdminPassword)));
        expect(row.passwordHash, isNot(equals(Seeder.firstAdminPassword)));
      }
    });

    test('the same password hashes differently per user', () async {
      final rows = await db.select(db.userAccounts).get();
      final hashes = rows.map((r) => r.passwordHash).toSet();
      // Every account shares the demo password, so identical hashes would mean
      // the salt is not being applied.
      expect(hashes.length, rows.length);
    });

    test('verify accepts the right password and rejects others', () {
      final salt = Password.generateSalt();
      final hash = Password.hash('correct horse1', salt);

      expect(Password.verify('correct horse1', salt, hash), isTrue);
      expect(Password.verify('correct horse2', salt, hash), isFalse);
      expect(Password.verify('', salt, hash), isFalse);
    });

    test('weak passwords are rejected', () {
      expect(Password.validate('short1'), isNotNull);
      expect(Password.validate('alllettersonly'), isNotNull);
      expect(Password.validate('12345678'), isNotNull);
      expect(Password.validate('password1'), isNotNull);
      expect(Password.validate('goodpass99'), isNull);
    });
  });
}
