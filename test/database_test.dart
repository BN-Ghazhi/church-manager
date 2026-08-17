import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/db/seeder.dart';
import 'package:churchms/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Verifies the app's own storage: that it seeds, persists writes, enforces
/// referential integrity, and authenticates without ever storing a password.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    await Seeder(db).seedFirstRun();
  });

  tearDown(() => db.close());

  group('seeding', () {
    test('a fresh database is populated', () async {
      final branches = await repo.watchBranches().first;
      final members = await repo.watchMembers().first;
      final departments = await repo.watchDepartments().first;
      final users = await repo.watchUsers().first;

      expect(branches.length, 6);
      expect(members.length, 240);
      expect(departments, isNotEmpty);
      expect(users, isNotEmpty);
    });

    test('every branch has its pastor attached after seeding', () async {
      final branches = await repo.watchBranches().first;
      for (final b in branches) {
        expect(b.pastorId, isNotEmpty, reason: '${b.name} has no pastor');
      }
    });

    test('department members are linked through the join table', () async {
      final departments = await repo.watchDepartments().first;
      final withMembers = departments.where((d) => d.memberIds.isNotEmpty);
      expect(withMembers, isNotEmpty);
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
      final members = await repo.watchMembers().first;
      final target = members.first;

      await repo.updateMember(target.id, phone: '+233 24 900 0000');
      final reloaded = await repo.findMember(target.id);

      expect(reloaded!.phone, '+233 24 900 0000');
    });

    test('a soft-deleted member disappears from queries', () async {
      final members = await repo.watchMembers().first;
      final target = members.first;

      await repo.deleteMember(target.id);

      final after = await repo.watchMembers().first;
      expect(after.any((m) => m.id == target.id), isFalse);
      expect(after.length, members.length - 1);
    });

    test('department membership can be replaced', () async {
      final departments = await repo.watchDepartments().first;
      final types = await repo.watchDepartmentTypes().first;

      // Use a department with no age restriction, so every same-branch member
      // is eligible. Age-gated departments filter ineligible members out by
      // design — that behaviour is covered in writes_test.dart.
      final unrestricted = types
          .where((t) => t.ageRange == null)
          .map((t) => t.id)
          .toSet();
      final dept = departments.firstWhere(
        (d) => d.memberIds.isNotEmpty && unrestricted.contains(d.typeId),
      );

      final members = await repo.watchMembers().first;
      final fresh = members
          .where((m) => m.branchId == dept.branchId)
          .take(3)
          .map((m) => m.id)
          .toSet();

      await repo.setDepartmentMembers(dept.id, fresh);

      final after = await repo.watchDepartments().first;
      final updated = after.firstWhere((d) => d.id == dept.id);
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
        'ansah@gracechapel.org',
        Seeder.demoPassword,
      );
      expect(user, isNotNull);
      expect(user!.role, UserRole.superAdmin);
    });

    test('a wrong password is rejected', () async {
      final user =
          await repo.signIn('ansah@gracechapel.org', 'not-the-password');
      expect(user, isNull);
    });

    test('an unknown email is rejected', () async {
      final user = await repo.signIn('nobody@example.com', 'anything');
      expect(user, isNull);
    });

    test('email is case-insensitive', () async {
      final user = await repo.signIn(
        'ANSAH@GraceChapel.org',
        Seeder.demoPassword,
      );
      expect(user, isNotNull);
    });

    test('a suspended account cannot sign in', () async {
      final users = await repo.watchUsers().first;
      final target = users.first;
      await repo.updateUserRole(target.id, status: AccountStatus.suspended);

      final user = await repo.signIn(target.email, Seeder.demoPassword);
      expect(user, isNull);
    });

    test('a department head signs in scoped to their department', () async {
      final users = await repo.watchUsers().first;
      final head = users.firstWhere(
        (u) => u.role == UserRole.departmentHead && u.departmentId != null,
      );

      final signedIn = await repo.signIn(head.email, Seeder.demoPassword);
      expect(signedIn, isNotNull);
      expect(signedIn!.departmentId, isNotNull);
      expect(signedIn.branchId, isNotNull);
      expect(signedIn.role.scope, RoleScope.ownDepartment);
    });

    test('a changed password replaces the old one', () async {
      final users = await repo.watchUsers().first;
      final target = users.first;

      await repo.changePassword(target.id, 'brand-new-pass9');

      expect(await repo.signIn(target.email, Seeder.demoPassword), isNull);
      expect(await repo.signIn(target.email, 'brand-new-pass9'), isNotNull);
    });

    test('a new user account can sign in immediately', () async {
      final branches = await repo.watchBranches().first;
      await repo.createUser(
        name: 'New Leader',
        email: 'newleader@gracechapel.org',
        password: 'strongpass1',
        role: UserRole.branchAdmin,
        branchId: branches.first.id,
      );

      final user =
          await repo.signIn('newleader@gracechapel.org', 'strongpass1');
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
        expect(row.passwordHash, isNot(contains(Seeder.demoPassword)));
        expect(row.passwordHash, isNot(equals(Seeder.demoPassword)));
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
