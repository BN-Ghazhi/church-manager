import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

/// Proves an existing install survives the move from email to username.
///
/// This matters more than most tests here: a failed migration does not lose a
/// feature, it locks someone out of their own church's records.
void main() {
  setUpAll(Password.useFastHashingForTests);

  test('a v1 database upgrades and its accounts can still sign in', () async {
    // A v1 database, built by hand the way the shipped version left it.
    final raw = sqlite3.openInMemory();
    raw.execute('''
      CREATE TABLE user_accounts (
        created_at TEXT NOT NULL DEFAULT (CURRENT_TIMESTAMP),
        updated_at TEXT NOT NULL DEFAULT (CURRENT_TIMESTAMP),
        deleted_at TEXT NULL,
        id TEXT NOT NULL,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL,
        password_salt TEXT NOT NULL,
        role TEXT NOT NULL,
        status TEXT NOT NULL,
        branch_id TEXT NULL,
        department_id TEXT NULL,
        member_id TEXT NULL,
        can_see_all_branches INTEGER NULL,
        last_active_at TEXT NULL,
        must_change_password INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (id)
      )
    ''');

    final salt = Password.generateSalt();
    final hash = Password.hash('church2026', salt);
    raw.execute(
      'INSERT INTO user_accounts (id, name, email, password_hash, '
      'password_salt, role, status, can_see_all_branches) '
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [
        'usr-0001',
        'Grace Ansah',
        'Admin@KGC.org',
        hash,
        salt,
        'superAdmin',
        'active',
        1,
      ],
    );
    raw.execute('PRAGMA user_version = 1');

    // Opening it with the current code must upgrade rather than fail.
    final db = AppDatabase.forTesting(NativeDatabase.opened(raw));
    addTearDown(db.close);
    final repo = ChurchRepository(db);

    final version = await db
        .customSelect('PRAGMA user_version')
        .getSingle()
        .then((r) => r.data.values.first);
    expect(version, db.schemaVersion);

    // The local part of the address became the username, lower-cased.
    final user = await repo.signIn('admin', 'church2026');
    expect(user, isNotNull, reason: 'the existing account must still sign in');
    expect(user!.username, 'admin');
    expect(user.name, 'Grace Ansah');
    expect(user.canSeeAllBranches, isTrue);

    // The old address is not a username.
    expect(await repo.signIn('Admin@KGC.org', 'church2026'), isNull);
  });

  test('a fresh database is created at the current version', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);

    // Touch the database so it is actually opened.
    await db.customSelect('SELECT 1').get();
    final version = await db
        .customSelect('PRAGMA user_version')
        .getSingle()
        .then((r) => r.data.values.first);
    expect(version, db.schemaVersion);
  });
}
