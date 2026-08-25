import 'package:churchms/config/features.dart';
import 'package:churchms/config/navigation.dart';
import 'package:churchms/config/permissions.dart';
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

/// A switched-off module must be unreachable by every route into it.
///
/// The first version of this feature checked only `permissionForProvider`, and
/// the sidebar read the permission matrix directly — so hidden modules kept
/// appearing in the navigation. These tests assert the outcome ("no way in")
/// rather than the mechanism, so a future bypass fails here too.
void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUpAll(Password.useFastHashingForTests);

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await TestSetup.run(db);

    final repo = ChurchRepository(db);
    final admin = (await repo.signIn(
        TestSetup.username, TestSetup.password))!;

    container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(db)],
    );
    // The most privileged account there is: if it cannot see a hidden module,
    // nobody can.
    container.read(sessionProvider.notifier).refresh(admin);
    addTearDown(container.dispose);
  });

  tearDown(() => db.close());

  test('every hidden module names a real module', () {
    final known = permissionMatrix.map((m) => m.module).toSet();
    for (final module in Features.hiddenModules) {
      expect(known, contains(module),
          reason: '"$module" does not match any module in the matrix, so '
              'hiding it would silently do nothing');
    }
  });

  test('every hidden route belongs to a hidden module', () {
    for (final route in Features.hiddenRoutes) {
      final item = navigation
          .expand((s) => s.items)
          .where((i) => i.route == route)
          .firstOrNull;
      expect(item, isNotNull, reason: '$route is not a real destination');
      expect(Features.hiddenModules, contains(item!.module),
          reason: 'blocking $route while its module is visible would leave a '
              'sidebar entry that goes nowhere');
    }
  });

  test('a hidden module is closed to a super admin', () {
    for (final module in Features.hiddenModules) {
      expect(container.read(canViewProvider(module)), isFalse, reason: module);
      expect(container.read(canEditProvider(module)), isFalse, reason: module);
    }
  });

  test('no sidebar destination belongs to a hidden module', () {
    // What the shell actually renders: every nav item it would keep.
    final shown = navigation
        .expand((s) => s.items)
        .where((i) => container.read(canViewProvider(i.module)))
        .toList();

    for (final item in shown) {
      expect(Features.isHidden(item.module), isFalse,
          reason: '${item.title} (${item.module}) is switched off but the '
              'sidebar would still list it');
    }

    // And each hidden module really does lose its destinations.
    for (final module in Features.hiddenModules) {
      expect(shown.where((i) => i.module == module), isEmpty, reason: module);
    }
  });

  test('the visible destinations are the ones we expect', () {
    final routes = navigation
        .expand((s) => s.items)
        .where((i) => container.read(canViewProvider(i.module)))
        .map((i) => i.route)
        .toSet();

    // Still reachable.
    expect(routes, containsAll(['/dashboard', '/members', '/attendance']));
    // Switched off.
    expect(
      routes.intersection(Features.hiddenRoutes),
      isEmpty,
      reason: 'a hidden route is still listed in the navigation',
    );
  });

  test('editing a role cannot re-enable a hidden module', () async {
    final repo = ChurchRepository(db);
    for (final module in Features.hiddenModules) {
      await repo.setPermission(
        module: module,
        role: UserRole.superAdmin,
        level: PermissionLevel.full,
      );
    }
    // Let the matrix stream deliver.
    await container.read(permissionMatrixStreamProvider.future);

    for (final module in Features.hiddenModules) {
      expect(container.read(canViewProvider(module)), isFalse,
          reason: 'the feature switch must outrank an edited permission');
    }
  });
}
