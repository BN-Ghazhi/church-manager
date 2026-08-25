import 'package:drift/drift.dart';

import '../models/models.dart';
import 'database.dart';
import 'password.dart';

/// Prepares a brand-new database.
///
/// Runs once, the first time the app opens a database that does not yet exist.
///
/// This deliberately creates almost nothing: one administrator account and one
/// headquarters branch. There is no demo congregation, no sample giving and no
/// invented attendance — the church enters its own records, and seeded examples
/// would only have to be found and deleted first.
///
/// Two things cannot be omitted:
///
///   * **An account**, or there is no way to sign in.
///   * **A branch**, because every member, gift and service belongs to one, so
///     the app has nothing to attach a first record to without it.
///
/// Both are editable afterwards — rename the branch in Settings, change the
/// password from the account menu.
///
/// The whole thing runs in a single transaction: either it completes or the
/// database is left untouched, never half-built.
class Seeder {
  Seeder(this.db);

  final AppDatabase db;

  /// The branch created during setup, so records have somewhere to go.
  static const headquartersCode = 'HQ';

  /// Structure only — no church, no branch, no account.
  ///
  /// The app used to ship with a published `admin` / `church2026` login, which
  /// meant every install in the world had the same credentials until someone
  /// remembered to change them. Setup now creates the first account, so no
  /// default password exists to leak.
  Future<void> seedFirstRun() async {
    await db.transaction(() async {
      await _seedDepartmentCatalogue();
    });
  }

  /// True when nobody can sign in yet, so the app must run setup first.
  ///
  /// Keyed on there being no account rather than no branch: a church that
  /// deleted its records still has an administrator and must not be walked
  /// through setup again.
  Future<bool> get needsOnboarding async {
    final count = await (db.selectOnly(db.userAccounts)
          ..addColumns([db.userAccounts.id.count()])
          ..where(db.userAccounts.deletedAt.isNull()))
        .getSingle();
    return (count.read(db.userAccounts.id.count()) ?? 0) == 0;
  }

  /// Creates the church, its first branch and its first administrator.
  ///
  /// One transaction: a half-finished setup would leave an app that cannot be
  /// signed into and cannot be set up again.
  Future<void> completeOnboarding({
    required String churchName,
    required String shortName,
    required String branchName,
    required String adminName,
    required String adminUsername,
    required String adminPassword,
  }) async {
    await db.transaction(() async {
      final branchId = await _seedHeadquarters(branchName);
      await _createAdmin(
        branchId: branchId,
        name: adminName,
        username: adminUsername,
        password: adminPassword,
      );
      await _seedSettings(churchName: churchName, shortName: shortName);
      // Harmless to repeat: first launch seeds the catalogue too.
      await _seedDepartmentCatalogue();
    });
  }

  /// The one branch a fresh install needs.
  Future<String> _seedHeadquarters(String name) async {
    const id = 'brn-0001';
    await db.into(db.branches).insert(BranchesCompanion.insert(
          id: id,
          name: name,
          code: headquartersCode,
          addressLine: '',
          city: '',
          state: '',
          status: BranchStatus.active.name,
          establishedAt: DateTime.now().toUtc(),
          accent: AccentToken.blue.name,
          isHeadquarters: const Value(true),
        ));
    return id;
  }

  /// The administrator created during setup.
  ///
  /// Given cross-branch visibility explicitly rather than relying on the role
  /// default, so the grant is visible in the database from the outset.
  Future<void> _createAdmin({
    required String branchId,
    required String name,
    required String username,
    required String password,
  }) async {
    final salt = Password.generateSalt();
    await db.into(db.userAccounts).insert(UserAccountsCompanion.insert(
          id: 'usr-0001',
          name: name.trim(),
          username: username.trim().toLowerCase(),
          passwordHash: Password.hash(password, salt),
          passwordSalt: salt,
          role: UserRole.superAdmin.name,
          status: AccountStatus.active.name,
          branchId: Value(branchId),
          canSeeAllBranches: const Value(true),
          lastActiveAt: Value(DateTime.now().toUtc()),
        ));
  }

  /// The shared department catalogue.
  ///
  /// Kept because it is structure rather than data: it defines what a Youth or
  /// Children's department *is*, so the same department stays comparable between
  /// branches. No department instances are created — the church starts those
  /// where it wants them. Types can be edited, added to, or ignored.
  Future<void> _seedDepartmentCatalogue() async {
    const catalogue = <(String, String, String, String, AccentToken, bool, int?, int?)>[
      ('dpt-youth', 'Youth Ministry',
        'Teenagers and young adults — fellowship, mentoring and outreach.',
        'youth', AccentToken.violet, true, 13, 30),
      ('dpt-children', "Children's Department",
        'Age-graded Sunday school, holiday clubs and child safeguarding.',
        'children', AccentToken.amber, true, 0, 12),
      ('dpt-worship', 'Worship & Choir',
        'Leads congregational worship and midweek rehearsals.',
        'worship', AccentToken.rose, true, null, null),
      ('dpt-ushering', 'Ushering & Protocol',
        'Welcomes and seats the congregation; manages offering flow.',
        'ushering', AccentToken.blue, true, null, null),
      ('dpt-media', 'Media & Technical',
        'Livestream, sound, lighting, slides and recordings.',
        'media', AccentToken.cyan, false, null, null),
      ('dpt-evangelism', 'Evangelism & Outreach',
        'Community outreach and follow-up of new converts.',
        'evangelism', AccentToken.emerald, false, null, null),
      ('dpt-prayer', 'Prayer & Intercession',
        'Early morning prayer, vigils and intercession.',
        'prayer', AccentToken.violet, false, null, null),
      ('dpt-welfare', 'Welfare & Benevolence',
        'Practical support for members in need.',
        'welfare', AccentToken.amber, false, null, null),
    ];

    for (final (id, name, description, icon, accent, isCore, minAge, maxAge)
        in catalogue) {
      // insertOnConflictUpdate rather than insert: first launch seeds the
      // catalogue and so does setup, so this runs twice on a normal install.
      // A plain insert collided on the second pass and aborted the whole
      // transaction, making setup fail on every fresh app.
      await db.into(db.departmentTypes).insertOnConflictUpdate(
            DepartmentTypesCompanion.insert(
              id: id,
              name: name,
              description: Value(description),
              icon: Value(icon),
              accent: accent.name,
              isCore: Value(isCore),
              minAge: Value(minAge),
              maxAge: Value(maxAge),
            ),
          );
    }
  }

  /// Church profile defaults, all editable in Settings.
  Future<void> _seedSettings({
    required String churchName,
    required String shortName,
  }) async {
    final settings = <String, String>{
      'church.name': churchName.trim(),
      'church.shortName': shortName.trim(),
      'church.legalName': churchName.trim(),
      'church.email': '',
      'church.phone': '',
      'church.website': '',
      'church.address': '',
      'church.city': '',
      'church.state': '',
      'church.country': 'Ghana',
      'church.pastor': '',
      'church.founded': '',
      'church.currency': 'GHS',
      'church.timezone': 'Africa/Accra',
    };

    for (final entry in settings.entries) {
      await db.into(db.settings).insert(SettingsCompanion.insert(
            key: entry.key,
            value: entry.value,
          ));
    }
  }
}
