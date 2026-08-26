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

/// What `Features.multiBranchEnabled` controls.
///
/// Documents the switch so flipping it is predictable, and pins the invariant
/// that matters either way: a second branch's data must never leak to someone
/// who may not see it.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late ProviderContainer container;

  setUpAll(Password.useFastHashingForTests);

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    await TestSetup.run(db);

    container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      startupNeedsOnboardingProvider.overrideWithValue(false),
    ]);
    addTearDown(container.dispose);
  });

  tearDown(() => db.close());

  Future<void> settle() async {
    for (final p in [branchesStreamProvider, membersStreamProvider]) {
      container.listen(p, (_, _) {}, fireImmediately: true);
    }
    for (var i = 0; i < 10; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  test('the switcher follows the flag, not just the branch count', () async {
    // Even with two branches present and an admin who may see both.
    await repo.createBranch(
      name: 'Kumasi',
      code: 'KSI',
      addressLine: '',
      city: 'Kumasi',
      state: 'Ashanti',
      status: BranchStatus.active,
      establishedAt: DateTime.utc(2026, 1, 1),
      accent: AccentToken.violet,
    );
    final admin = (await repo.signIn(TestSetup.username, TestSetup.password))!;
    container.read(sessionProvider.notifier).refresh(admin);
    await settle();

    expect(container.read(visibleBranchIdsProvider).length, 2,
        reason: 'the admin may see both branches');

    // Two branches and permission to see both is not enough on its own — the
    // flag decides. Written this way so flipping it does not fail the suite.
    expect(container.read(canSwitchBranchProvider),
        equals(Features.multiBranchEnabled),
        reason: 'the switcher is gated on the flag as well as the count');
  });

  test('a second branch is still scoped correctly regardless of the flag',
      () async {
    // The flag is a UI switch. It must not affect who can see whose data.
    final other = await repo.createBranch(
      name: 'Tema',
      code: 'TEM',
      addressLine: '',
      city: 'Tema',
      state: 'Greater Accra',
      status: BranchStatus.active,
      establishedAt: DateTime.utc(2026, 1, 1),
      accent: AccentToken.blue,
    );
    final fx = Fixtures(db);
    await fx.member(branchId: other, lastName: 'Elsewhere');

    final hq = (await repo.watchBranches().first)
        .firstWhere((b) => b.isHeadquarters);

    // A branch admin confined to HQ.
    container.read(sessionProvider.notifier).refresh(StaffUser(
          id: 'usr-branch',
          name: 'HQ Admin',
          username: 'hq',
          role: UserRole.branchAdmin,
          lastActiveAt: DateTime.now().toUtc(),
          status: AccountStatus.active,
          branchId: hq.id,
        ));
    await settle();

    expect(container.read(visibleBranchIdsProvider), [hq.id]);
    expect(
      container.read(membersProvider).where((m) => m.branchId == other),
      isEmpty,
      reason: "another branch's members must never appear",
    );
  });
}
