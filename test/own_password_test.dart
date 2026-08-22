import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/db/seeder.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Changing your own password, which requires proving you know the current one.
///
/// This matters more than most: the first-run password is published in the
/// repository, so every install has to be able to change it — and a bug that
/// accepted the wrong current password would let anyone at an unlocked machine
/// lock the real administrator out.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late String userId;

  setUpAll(Password.useFastHashingForTests);

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    await Seeder(db).seedFirstRun();
    userId = (await repo.signIn(
            Seeder.firstAdminUsername, Seeder.firstAdminPassword))!
        .id;
  });

  tearDown(() => db.close());

  test('the right current password lets you change it', () async {
    final changed = await repo.changeOwnPassword(
      userId: userId,
      currentPassword: Seeder.firstAdminPassword,
      newPassword: 'kgcAccra2026',
    );
    expect(changed, isTrue);

    // The new one works...
    expect(await repo.signIn(Seeder.firstAdminUsername, 'kgcAccra2026'),
        isNotNull);
    // ...and the old one no longer does.
    expect(
      await repo.signIn(Seeder.firstAdminUsername, Seeder.firstAdminPassword),
      isNull,
      reason: 'the published default must stop working once changed',
    );
  });

  test('a wrong current password is refused and changes nothing', () async {
    final changed = await repo.changeOwnPassword(
      userId: userId,
      currentPassword: 'not-the-password',
      newPassword: 'attackerChosen1',
    );
    expect(changed, isFalse);

    // The account is untouched: the real password still works...
    expect(
      await repo.signIn(Seeder.firstAdminUsername, Seeder.firstAdminPassword),
      isNotNull,
      reason: 'a failed attempt must not lock the owner out',
    );
    // ...and the attempted one does not.
    expect(await repo.signIn(Seeder.firstAdminUsername, 'attackerChosen1'),
        isNull);
  });

  test('an unknown account is refused', () async {
    expect(
      await repo.changeOwnPassword(
        userId: 'usr-nobody',
        currentPassword: Seeder.firstAdminPassword,
        newPassword: 'whatever2026',
      ),
      isFalse,
    );
  });

  test("an administrator's reset does not need the current password", () async {
    // The other half of the pair: a Super Admin resetting a forgotten password
    // cannot know it, so changePassword deliberately does not ask.
    await repo.changePassword(userId, 'resetByAdmin1');

    expect(await repo.signIn(Seeder.firstAdminUsername, 'resetByAdmin1'),
        isNotNull);
  });

  test('a changed password clears the must-change flag', () async {
    await repo.changeOwnPassword(
      userId: userId,
      currentPassword: Seeder.firstAdminPassword,
      newPassword: 'kgcAccra2026',
    );

    // The flag is not on the domain model, so read the column directly.
    final row = await db
        .customSelect('SELECT must_change_password AS f FROM user_accounts')
        .getSingle();
    expect(row.data['f'], 0);
  });
}
