import 'package:churchms/config/features.dart';
import 'package:churchms/db/database.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/db/seeder.dart';
import 'package:churchms/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';

/// Editable role permissions, and the switched-off modules.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
  });

  tearDown(() => db.close());

  test('an untouched install gets the built-in matrix', () async {
    final matrix = await repo.watchPermissionMatrix().first;

    expect(matrix, isNotEmpty);
    expect(
      matrix.firstWhere((m) => m.module == 'Attendance').levelFor(UserRole.volunteer),
      PermissionLevel.read,
      reason: 'the default should come through untouched',
    );
  });

  test('an edited role overrides only that module and role', () async {
    await repo.setPermission(
      module: 'Attendance',
      role: UserRole.volunteer,
      level: PermissionLevel.full,
    );

    final matrix = await repo.watchPermissionMatrix().first;
    final attendance = matrix.firstWhere((m) => m.module == 'Attendance');

    expect(attendance.levelFor(UserRole.volunteer), PermissionLevel.full);
    // Everything else keeps its default.
    expect(attendance.levelFor(UserRole.member), PermissionLevel.none);
    // A different module for the same role is untouched.
    expect(
      matrix.firstWhere((m) => m.module == 'Members').levelFor(UserRole.volunteer),
      PermissionLevel.none,
    );
    // And the same module for a different role.
    expect(
      attendance.levelFor(UserRole.branchPastor),
      PermissionLevel.full,
    );
  });

  test('super admin cannot be demoted', () async {
    await repo.setPermission(
      module: 'Roles & Access',
      role: UserRole.superAdmin,
      level: PermissionLevel.none,
    );

    final matrix = await repo.watchPermissionMatrix().first;
    expect(
      matrix
          .firstWhere((m) => m.module == 'Roles & Access')
          .levelFor(UserRole.superAdmin),
      PermissionLevel.full,
      reason: 'locking out the account that fixes permissions is unrecoverable',
    );
  });

  test('resetting drops every customisation', () async {
    await repo.setPermission(
      module: 'Attendance',
      role: UserRole.member,
      level: PermissionLevel.full,
    );
    await repo.resetPermissions();

    final matrix = await repo.watchPermissionMatrix().first;
    expect(
      matrix.firstWhere((m) => m.module == 'Attendance').levelFor(UserRole.member),
      PermissionLevel.none,
    );
  });

  test('the switched-off modules are the three the church asked for', () {
    expect(Features.hiddenModules, {
      'Giving & Finance',
      'Communication',
      'Volunteers',
    });
    expect(Features.isHidden('Attendance'), isFalse);
    expect(Features.isHidden('Volunteers'), isTrue);
  });

  test('a username clash is refused rather than silently applied', () async {
    await Seeder(db).seedFirstRun();
    final fx = Fixtures(db);
    final branchId = (await repo.watchBranches().first).single.id;

    final second = await fx.user(
      branchId: branchId,
      username: 'kwame',
      role: UserRole.branchAdmin,
    );

    // 'admin' is the seeded account, so this must be rejected.
    final ok = await repo.updateUserIdentity(second, username: 'admin');
    expect(ok, isFalse);

    final users = await repo.watchUsers().first;
    expect(users.firstWhere((u) => u.id == second).username, 'kwame',
        reason: 'a refused rename must not partially apply');
  });

  test('renaming an account lower-cases the username', () async {
    await Seeder(db).seedFirstRun();
    final fx = Fixtures(db);
    final branchId = (await repo.watchBranches().first).single.id;
    final id = await fx.user(
        branchId: branchId, username: 'kofi', role: UserRole.branchAdmin);

    final ok = await repo.updateUserIdentity(id,
        name: '  Kofi Mensah  ', username: '  KOFI.MENSAH  ');
    expect(ok, isTrue);

    final user = (await repo.watchUsers().first).firstWhere((u) => u.id == id);
    expect(user.username, 'kofi.mensah');
    expect(user.name, 'Kofi Mensah');
  });
}
