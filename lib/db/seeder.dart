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

  /// The first administrator's credentials.
  ///
  /// Shown on the sign-in screen, because on a fresh install there is no other
  /// way in. **Change this password before the app holds real records** — it is
  /// public in the source and therefore not a secret.
  static const firstAdminEmail = 'admin@kgc.org';
  static const firstAdminPassword = 'church2026';
  static const firstAdminName = 'Administrator';

  /// The headquarters branch created on first run, so records have somewhere to
  /// go. Rename it in Settings.
  static const headquartersName = 'Kingdom Grace Chapel Headquarters';
  static const headquartersCode = 'HQ';

  Future<void> seedFirstRun() async {
    await db.transaction(() async {
      final branchId = await _seedHeadquarters();
      await _seedFirstAdmin(branchId);
      await _seedDepartmentCatalogue();
      await _seedSettings();
    });
  }

  /// The one branch a fresh install needs.
  Future<String> _seedHeadquarters() async {
    const id = 'brn-0001';
    await db.into(db.branches).insert(BranchesCompanion.insert(
          id: id,
          name: headquartersName,
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

  /// The administrator who sets everything else up.
  ///
  /// Given cross-branch visibility explicitly rather than relying on the role
  /// default, so the grant is visible in the database from the outset.
  Future<void> _seedFirstAdmin(String branchId) async {
    final salt = Password.generateSalt();
    await db.into(db.userAccounts).insert(UserAccountsCompanion.insert(
          id: 'usr-0001',
          name: firstAdminName,
          email: firstAdminEmail.toLowerCase(),
          passwordHash: Password.hash(firstAdminPassword, salt),
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
      await db.into(db.departmentTypes).insert(
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
  Future<void> _seedSettings() async {
    const settings = <String, String>{
      'church.name': 'Kingdom Grace Chapel',
      'church.shortName': 'K.G.C.',
      'church.legalName': 'Kingdom Grace Chapel',
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
