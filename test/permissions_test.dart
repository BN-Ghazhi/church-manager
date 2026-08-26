import 'package:churchms/config/permissions.dart' show permissionMatrix;
import 'package:churchms/config/features.dart';
import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/models/models.dart';
import 'package:churchms/providers/auth.dart';
import 'package:churchms/providers/permissions.dart';
import 'package:churchms/providers/repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';

/// Verifies the two-dimensional access model actually restricts data, rather
/// than merely hiding buttons.
void main() {
  setUpAll(Password.useFastHashingForTests);

  late AppDatabase db;
  late List<StaffUser> users;
  late List<Branch> branches;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await TestSetup.run(db);

    final repo = ChurchRepository(db);
    final fixtures = Fixtures(db);

    // A fresh database holds one branch and one admin, so this builds the
    // multi-branch, multi-role situation these tests are about. Each account is
    // attached to the branch it should be confined to.
    final hq = (await repo.watchBranches().first).single.id;
    final tema = await fixtures.branch(name: 'Tema', code: 'TEM');
    final kumasi = await fixtures.branch(name: 'Kumasi', code: 'KUM');

    for (final b in [hq, tema, kumasi]) {
      await fixtures.members(branchId: b, count: 4);
    }

    final head = await fixtures.member(branchId: hq, firstName: 'Head');
    final dept = await fixtures.department(branchId: hq, headId: head);

    await fixtures.user(role: UserRole.seniorPastor, branchId: hq);
    await fixtures.user(role: UserRole.hqFinance, branchId: hq);
    await fixtures.user(role: UserRole.branchPastor, branchId: tema);
    await fixtures.user(role: UserRole.assistantPastor, branchId: tema);
    await fixtures.user(role: UserRole.branchAdmin, branchId: kumasi);
    await fixtures.user(role: UserRole.branchFinance, branchId: kumasi);
    await fixtures.user(
      role: UserRole.departmentHead, branchId: hq, departmentId: dept);
    await fixtures.user(
      role: UserRole.volunteer, branchId: hq, departmentId: dept);

    users = await repo.watchUsers().first;
    branches = await repo.watchBranches().first;
  });

  tearDown(() => db.close());

  StaffUser userWithRole(UserRole role) =>
      users.firstWhere((u) => u.role == role);

  /// A container backed by the seeded database, signed in as [user].
  ///
  /// Providers are read once up-front so the underlying streams have emitted
  /// before any assertion runs.
  Future<ProviderContainer> containerFor(StaffUser user) async {
    final c = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(db)],
    );
    addTearDown(c.dispose);
    c.read(sessionProvider.notifier).refresh(user);

    // Wait for the branch and member streams to deliver their first value.
    await c.read(branchesStreamProvider.future);
    await c.read(membersStreamProvider.future);
    return c;
  }

  group('branch scoping', () {
    test('a super admin sees every branch', () async {
      final c = await containerFor(userWithRole(UserRole.superAdmin));
      expect(c.read(visibleBranchIdsProvider).length, branches.length);
      // Switching also requires multi-branch to be switched on, so this tracks
      // the flag rather than hard-coding today's value.
      expect(c.read(canSwitchBranchProvider),
          equals(Features.multiBranchEnabled));
      expect(c.read(selectedBranchProvider), isNull); // consolidated
    });

    test('a branch pastor sees only their own branch', () async {
      final pastor = userWithRole(UserRole.branchPastor);
      final c = await containerFor(pastor);

      expect(c.read(visibleBranchIdsProvider), [pastor.branchId]);
      expect(c.read(canSwitchBranchProvider), isFalse);
      expect(c.read(selectedBranchProvider), pastor.branchId);
      expect(c.read(isConsolidatedViewProvider), isFalse);
    });

    test('scoped data never leaks another branch', () async {
      final pastor = userWithRole(UserRole.branchPastor);
      final c = await containerFor(pastor);

      for (final m in c.read(membersProvider)) {
        expect(m.branchId, pastor.branchId);
      }
      for (final d in c.read(departmentsProvider)) {
        expect(d.branchId, pastor.branchId);
      }
      for (final d in c.read(donationsProvider)) {
        expect(d.branchId, pastor.branchId);
      }
      for (final r in c.read(careRequestsProvider)) {
        expect(r.branchId, pastor.branchId);
      }
      for (final a in c.read(assetsProvider)) {
        expect(a.branchId, pastor.branchId);
      }
    });

    test('a branch pastor sees strictly fewer members than a super admin', () async {
      final admin = await containerFor(userWithRole(UserRole.superAdmin));
      final pastor = await containerFor(userWithRole(UserRole.branchPastor));

      expect(
        pastor.read(membersProvider).length,
        lessThan(admin.read(membersProvider).length),
      );
    });

    test('a branch pastor cannot switch to another branch', () async {
      final pastor = userWithRole(UserRole.branchPastor);
      final c = await containerFor(pastor);
      final other =
          branches.firstWhere((b) => b.id != pastor.branchId).id;

      c.read(selectedBranchProvider.notifier).select(other);
      expect(c.read(selectedBranchProvider), pastor.branchId,
          reason: 'selection outside scope must be rejected');

      c.read(selectedBranchProvider.notifier).select(null);
      expect(c.read(selectedBranchProvider), pastor.branchId,
          reason: 'consolidated view is not available to single-branch roles');
    });

    test('a super admin can focus one branch and go back', () async {
      final c = await containerFor(userWithRole(UserRole.superAdmin));
      final target = branches[2].id;

      c.read(selectedBranchProvider.notifier).select(target);
      expect(c.read(activeBranchIdsProvider), {target});
      for (final m in c.read(membersProvider)) {
        expect(m.branchId, target);
      }

      c.read(selectedBranchProvider.notifier).select(null);
      expect(c.read(activeBranchIdsProvider).length, branches.length);
    });
  });

  group('module permissions', () {
    test('a switched-off module is closed to everyone, super admin included',
        () async {
      // Giving, Communication and Volunteers are hidden for now. The check sits
      // in permissionForProvider, so one rule covers the sidebar, every screen
      // and every action button — there is no route left that shows them.
      final admin = await containerFor(userWithRole(UserRole.superAdmin));
      final finance = await containerFor(userWithRole(UserRole.branchFinance));

      for (final module in Features.hiddenModules) {
        expect(admin.read(canViewProvider(module)), isFalse,
            reason: '$module is switched off');
        expect(admin.read(canEditProvider(module)), isFalse);
        expect(finance.read(canViewProvider(module)), isFalse);
      }
    });

    test('a module that is not switched off still follows the role matrix',
        () async {
      final admin = await containerFor(userWithRole(UserRole.branchAdmin));
      final volunteer = await containerFor(userWithRole(UserRole.volunteer));

      expect(admin.read(canViewProvider('Attendance')), isTrue);
      expect(admin.read(canEditProvider('Attendance')), isTrue);
      expect(volunteer.read(canViewProvider('Attendance')), isTrue);
      expect(volunteer.read(canEditProvider('Attendance')), isFalse);
    });

    test('only a super admin may edit roles', () async {
      // Not every role has a seeded account; check the ones that do.
      final seeded = users.map((u) => u.role).toSet();
      for (final role in seeded) {
        final c = await containerFor(userWithRole(role));
        expect(
          c.read(canEditProvider('Roles & Access')),
          role == UserRole.superAdmin,
          reason: '${role.label} edit access to Roles & Access',
        );
      }
    });

    test('the matrix grants role edit to super admin alone', () async {
      final module =
          permissionMatrix.firstWhere((m) => m.module == 'Roles & Access');
      for (final role in UserRole.values) {
        expect(
          module.levelFor(role).canWrite,
          role == UserRole.superAdmin,
          reason: '${role.label} must not edit Roles & Access',
        );
      }
    });

    test('a volunteer can read but not edit departments', () async {
      final c = await containerFor(userWithRole(UserRole.volunteer));
      expect(c.read(canViewProvider('Departments')), isTrue);
      expect(c.read(canEditProvider('Departments')), isFalse);
    });

    test('every role has an entry in every module', () async {
      for (final module in permissionMatrix) {
        for (final role in UserRole.values) {
          expect(module.roles.containsKey(role), isTrue,
              reason: '${module.module} is missing ${role.label}');
        }
      }
    });
  });

  /// Cross-branch visibility is a permission held by the account, not a
  /// property of the role. Without it a user must see only their own branch.
  group('cross-branch permission', () {
    test('only Super Admin sees every branch by default', () async {
      for (final role in users.map((u) => u.role).toSet()) {
        final c = await containerFor(userWithRole(role));
        final visible = c.read(visibleBranchIdsProvider);

        if (role == UserRole.superAdmin) {
          expect(visible.length, branches.length,
              reason: 'Super Admin must see every branch');
        } else {
          expect(visible.length, 1,
              reason: '${role.label} must see only their own branch');
        }
      }
    });

    test('a senior pastor is confined to one branch unless granted', () async {
      final pastor = userWithRole(UserRole.seniorPastor);
      final c = await containerFor(pastor);

      expect(c.read(canSeeAllBranchesProvider), isFalse);
      expect(c.read(visibleBranchIdsProvider), [pastor.branchId]);
      expect(c.read(isConsolidatedViewProvider), isFalse);

      for (final m in c.read(membersProvider)) {
        expect(m.branchId, pastor.branchId);
      }
    });

    test('HQ finance sees only its own branch giving unless granted', () async {
      final finance = userWithRole(UserRole.hqFinance);
      final c = await containerFor(finance);

      expect(c.read(canSeeAllBranchesProvider), isFalse);
      for (final d in c.read(donationsProvider)) {
        expect(d.branchId, finance.branchId);
      }
    });

    test('granting the permission opens every branch', () async {
      final repo = ChurchRepository(db);
      final pastor = userWithRole(UserRole.seniorPastor);

      await repo.setBranchVisibility(pastor.id, true);
      final updated =
          (await repo.watchUsers().first).firstWhere((u) => u.id == pastor.id);

      expect(updated.canSeeAllBranches, isTrue);
      expect(updated.hasExplicitBranchGrant, isTrue);

      final c = await containerFor(updated);
      expect(c.read(visibleBranchIdsProvider).length, branches.length);
      expect(
        c.read(membersProvider).map((m) => m.branchId).toSet().length,
        greaterThan(1),
      );
    });

    test('revoking the permission closes it again', () async {
      final repo = ChurchRepository(db);
      final pastor = userWithRole(UserRole.seniorPastor);

      await repo.setBranchVisibility(pastor.id, true);
      await repo.setBranchVisibility(pastor.id, false);
      final updated =
          (await repo.watchUsers().first).firstWhere((u) => u.id == pastor.id);

      expect(updated.canSeeAllBranches, isFalse);

      final c = await containerFor(updated);
      expect(c.read(visibleBranchIdsProvider), [pastor.branchId]);
    });

    test('a department-level role cannot be granted church-wide sight',
        () async {
      final repo = ChurchRepository(db);
      final head = userWithRole(UserRole.departmentHead);

      await repo.setBranchVisibility(head.id, true);
      final updated =
          (await repo.watchUsers().first).firstWhere((u) => u.id == head.id);

      expect(updated.canSeeAllBranches, isFalse,
          reason: 'a department head must never see the whole church');
    });

    test('a restricted user cannot switch to another branch', () async {
      final pastor = userWithRole(UserRole.seniorPastor);
      final c = await containerFor(pastor);
      final other = branches.firstWhere((b) => b.id != pastor.branchId).id;

      c.read(selectedBranchProvider.notifier).select(other);
      expect(c.read(selectedBranchProvider), pastor.branchId);

      c.read(selectedBranchProvider.notifier).select(null);
      expect(c.read(selectedBranchProvider), pastor.branchId,
          reason: 'the consolidated view must stay out of reach');
    });

    test('no branch-scoped user can reach another branch\'s data', () async {
      for (final role in users.map((u) => u.role).toSet()) {
        if (role == UserRole.superAdmin) continue;

        final user = userWithRole(role);
        final c = await containerFor(user);
        final allowed = c.read(activeBranchIdsProvider);

        expect(allowed.length, 1, reason: '${role.label} scope');

        for (final list in [
          c.read(membersProvider).map((e) => e.branchId),
          c.read(departmentsProvider).map((e) => e.branchId),
          c.read(donationsProvider).map((e) => e.branchId),
          c.read(expensesProvider).map((e) => e.branchId),
          c.read(careRequestsProvider).map((e) => e.branchId),
          c.read(assetsProvider).map((e) => e.branchId),
          c.read(attendanceRecordsProvider).map((e) => e.branchId),
        ]) {
          for (final branchId in list) {
            expect(allowed.contains(branchId), isTrue,
                reason: '${role.label} saw data from another branch');
          }
        }
      }
    });
  });
}
