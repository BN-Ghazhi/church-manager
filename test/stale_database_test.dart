import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/db/seeder.dart';
import 'package:churchms/providers/auth.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';

/// Recovering from a database left by an older install.
///
/// Records deliberately survive uninstalling, so someone who ran an earlier
/// build still has its account and is shown sign-in rather than setup. Their
/// credentials may no longer exist anywhere, and nothing in the app could get
/// past that screen — this is the way out.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late ProviderContainer container;

  setUpAll(Password.useFastHashingForTests);

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    // A database from a previous install: it has a church and an account.
    await TestSetup.run(db);

    container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(db),
      // Startup found an account, so it did not ask for setup.
      startupNeedsOnboardingProvider.overrideWithValue(false),
    ]);
    addTearDown(container.dispose);
  });

  tearDown(() => db.close());

  test('a leftover database sends you to sign-in, not setup', () async {
    expect(await Seeder(db).needsOnboarding, isFalse);
    expect(container.read(needsOnboardingProvider), isFalse,
        reason: 'an existing account means sign-in, which is correct');
  });

  test('erasing it clears every record and the account', () async {
    // Add a member so there is real data to lose, as a church would have.
    final branchId = (await repo.watchBranches().first).single.id;
    await Fixtures(db).member(branchId: branchId);
    expect(await repo.watchMembers().first, isNotEmpty);
    expect(await repo.watchUsers().first, hasLength(1));

    await db.resetToSeed();

    expect(await repo.watchUsers().first, isEmpty,
        reason: 'no account means setup can run again');
    expect(await repo.watchBranches().first, isEmpty);
    expect(await Seeder(db).needsOnboarding, isTrue);
    // Structure survives, so setup does not have to rebuild the catalogue.
    expect(await repo.watchDepartmentTypes().first, isNotEmpty);
  });

  test('the router is told to show setup after erasing', () async {
    // Without this the redirect would bounce /setup back to /sign-in, because
    // the startup value is fixed before runApp and cannot be recomputed.
    expect(container.read(needsOnboardingProvider), isFalse);

    await db.resetToSeed();
    container.read(forceOnboardingProvider.notifier).require();

    expect(container.read(needsOnboardingProvider), isTrue,
        reason: 'the escape hatch must survive the synchronous redirect');
  });

  test('the old credentials stop working after erasing', () async {
    expect(await repo.signIn(TestSetup.username, TestSetup.password),
        isNotNull);

    await db.resetToSeed();

    expect(await repo.signIn(TestSetup.username, TestSetup.password), isNull);
  });
}
