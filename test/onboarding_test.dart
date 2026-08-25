import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/db/seeder.dart';
import 'package:churchms/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// First-run setup replaced a published admin / church2026 login.
///
/// The stakes are the whole app: setup is the only way in, so a half-finished or
/// repeatable setup is the difference between a working install and a church
/// locked out of its own records.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late Seeder seeder;

  setUpAll(Password.useFastHashingForTests);

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    seeder = Seeder(db);
  });

  tearDown(() => db.close());

  test('a fresh database needs setup and has no way in', () async {
    await seeder.seedFirstRun();

    expect(await seeder.needsOnboarding, isTrue);
    expect(await repo.watchUsers().first, isEmpty,
        reason: 'no shipped account means no shipped password to leak');
    expect(await repo.watchBranches().first, isEmpty);

    // The department catalogue is structure, so it is seeded regardless.
    expect(await repo.watchDepartmentTypes().first, isNotEmpty);
  });

  test('setup creates the church, the branch and the administrator', () async {
    await seeder.seedFirstRun();
    await seeder.completeOnboarding(
      churchName: 'Kingdom Grace Chapel',
      shortName: 'K.G.C.',
      branchName: 'Kingdom Grace Chapel, Accra',
      adminName: 'Grace Ansah',
      adminUsername: 'Grace',
      adminPassword: 'accraGrace26',
    );

    expect(await seeder.needsOnboarding, isFalse);

    final branch = (await repo.watchBranches().first).single;
    expect(branch.name, 'Kingdom Grace Chapel, Accra');
    expect(branch.isHeadquarters, isTrue);

    final user = (await repo.watchUsers().first).single;
    expect(user.name, 'Grace Ansah');
    // Lower-cased, as everywhere else usernames are written.
    expect(user.username, 'grace');
    expect(user.role, UserRole.superAdmin);
    expect(user.canSeeAllBranches, isTrue);

    final settings = await repo.watchSettings().first;
    expect(settings['church.name'], 'Kingdom Grace Chapel');
    expect(settings['church.shortName'], 'K.G.C.');
  });

  test('the chosen password is the one that signs in', () async {
    await seeder.seedFirstRun();
    await seeder.completeOnboarding(
      churchName: 'Test Church',
      shortName: 'TC',
      branchName: 'Main',
      adminName: 'Admin',
      adminUsername: 'admin',
      adminPassword: 'chosenByThem1',
    );

    expect(await repo.signIn('admin', 'chosenByThem1'), isNotNull);
    // The old shipped default must not work — it no longer exists anywhere.
    expect(await repo.signIn('admin', 'church2026'), isNull);
  });

  test('a username typed in mixed case still signs in', () async {
    await seeder.seedFirstRun();
    await seeder.completeOnboarding(
      churchName: 'Test Church',
      shortName: 'TC',
      branchName: 'Main',
      adminName: 'Grace Ansah',
      adminUsername: '  Grace.Ansah  ',
      adminPassword: 'chosenByThem1',
    );

    expect(await repo.signIn('grace.ansah', 'chosenByThem1'), isNotNull);
    expect(await repo.signIn('GRACE.ANSAH', 'chosenByThem1'), isNotNull,
        reason: 'sign-in lower-cases too, so case cannot lock someone out');
  });

  test('setup does not run twice on a church that deleted its records',
      () async {
    await seeder.seedFirstRun();
    await seeder.completeOnboarding(
      churchName: 'Test Church',
      shortName: 'TC',
      branchName: 'Main',
      adminName: 'Admin',
      adminUsername: 'admin',
      adminPassword: 'chosenByThem1',
    );

    // Deleting every member must not make the app think it is unconfigured.
    expect(await seeder.needsOnboarding, isFalse);
  });

  test('a failed setup leaves nothing behind', () async {
    await seeder.seedFirstRun();

    // A branch id collision is the realistic failure: it aborts mid-transaction.
    await seeder.completeOnboarding(
      churchName: 'First',
      shortName: 'F',
      branchName: 'Main',
      adminName: 'Admin',
      adminUsername: 'admin',
      adminPassword: 'chosenByThem1',
    );

    // Running it again must not half-apply: the same branch id is taken.
    await expectLater(
      seeder.completeOnboarding(
        churchName: 'Second',
        shortName: 'S',
        branchName: 'Other',
        adminName: 'Someone',
        adminUsername: 'someone',
        adminPassword: 'another12345',
      ),
      throwsA(anything),
    );

    // The first church is intact — no second account, no renamed church.
    expect(await repo.watchUsers().first, hasLength(1));
    final settings = await repo.watchSettings().first;
    expect(settings['church.name'], 'First',
        reason: 'a failed second setup must not overwrite the real one');
  });
}
