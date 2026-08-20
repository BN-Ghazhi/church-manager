import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../models/models.dart' as domain;
import 'seeder.dart';
import 'tables.dart';

part 'database.g.dart';

/// The application's own database.
///
/// A single SQLite file living in the app's support directory — no server, no
/// installation, nothing to configure. It travels with the app and is the sole
/// source of truth once seeded.
@DriftDatabase(
  tables: [
    Branches,
    Members,
    DepartmentTypes,
    Departments,
    DepartmentMembers,
    UserAccounts,
    AttendanceRecords,
    CheckIns,
    Donations,
    Expenses,
    Pledges,
    Events,
    CareRequests,
    VolunteerSlots,
    Assets,
    Campaigns,
    Announcements,
    Courses,
    SmallGroups,
    PermissionOverrides,
    Settings,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Dates are stored as ISO-8601 UTC text rather than drift's default unix
  /// seconds. The default returns local `DateTime`s on read, so a value written
  /// as UTC comes back with `isUtc == false` and no longer compares equal to
  /// the value that was stored — a subtle source of wrong-day bugs.
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);

  AppDatabase() : super(_open());

  /// For tests: an isolated in-memory database that never touches disk.
  ///
  /// Auto-seeding is off here so a test can seed explicitly and assert on the
  /// result; seeding twice would violate the primary keys.
  AppDatabase.forTesting(super.executor) {
    _autoSeed = false;
  }

  /// Whether opening a freshly created database should populate it.
  bool _autoSeed = true;

  /// 2 — accounts sign in with a username rather than an email address.
  /// 3 — role permissions are editable, so their overrides need somewhere to live.
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // v1 → v2: `user_accounts.email` became `username`. Existing installs
          // hold real accounts, so the column is renamed in place and the local
          // part of each address becomes the username — `grace@kgc.org` signs in
          // as `grace`, with the same password. Dropping and re-seeding would
          // have locked people out of their own data.
          if (from < 2) {
            await customStatement(
                'ALTER TABLE user_accounts RENAME COLUMN email TO username');
            await customStatement(
              "UPDATE user_accounts SET username = "
              "lower(CASE WHEN instr(username, '@') > 0 "
              "THEN substr(username, 1, instr(username, '@') - 1) "
              "ELSE username END)",
            );
          }

          // v2 → v3: a new table only, so existing rows are untouched. An
          // install with no overrides behaves exactly as before — the built-in
          // matrix is still the answer until someone edits a role.
          if (from < 3) {
            await m.createTable(permissionOverrides);
          }
        },
        beforeOpen: (details) async {
          // Foreign keys are off by default in SQLite; without this the
          // references declared in the schema would not actually be enforced.
          await customStatement('PRAGMA foreign_keys = ON');

          if (details.wasCreated && _autoSeed) {
            await Seeder(this).seedFirstRun();
          }
        },
      );

  /// Where the database file lives.
  ///
  /// On desktop and mobile: the platform's application-support directory,
  /// pinned rather than left to the default, which resolves to Documents on
  /// Linux and would drop a stray `.sqlite` file in the user's own folder.
  ///
  /// On web: IndexedDB via a worker, which needs `sqlite3.wasm` and
  /// `drift_worker.js` in `web/` (both are committed) *and* cross-origin
  /// isolation headers (COOP/COEP) from whatever serves the build. A plain
  /// static file server does not send those, and the app will fail to open its
  /// database — see the note in ARCHITECTURE.md. Desktop is the primary target
  /// and is unaffected.
  static QueryExecutor _open() => driftDatabase(
        name: 'church_management',
        native: DriftNativeOptions(
          databaseDirectory: getApplicationSupportDirectory,
        ),
        web: DriftWebOptions(
          sqlite3Wasm: Uri.parse('sqlite3.wasm'),
          driftWorker: Uri.parse('drift_worker.js'),
        ),
      );

  /// Wipes every table and re-seeds. Used by "Reset demo data" in Settings.
  Future<void> resetToSeed() async {
    await transaction(() async {
      // Children before parents, so foreign keys stay satisfied throughout.
      await delete(checkIns).go();
      await delete(departmentMembers).go();
      await delete(userAccounts).go();
      await delete(donations).go();
      await delete(expenses).go();
      await delete(pledges).go();
      await delete(careRequests).go();
      await delete(volunteerSlots).go();
      await delete(assets).go();
      await delete(campaigns).go();
      await delete(announcements).go();
      await delete(courses).go();
      await delete(smallGroups).go();
      await delete(events).go();
      await delete(attendanceRecords).go();
      await delete(departments).go();
      await delete(departmentTypes).go();
      await delete(members).go();
      await delete(branches).go();
      await delete(settings).go();
    });
    await Seeder(this).seedFirstRun();
  }

  /// True when the database holds no branches — i.e. nothing has been seeded.
  Future<bool> get isEmpty async {
    final count = await (selectOnly(branches)
          ..addColumns([branches.id.count()]))
        .getSingle();
    return (count.read(branches.id.count()) ?? 0) == 0;
  }

  /* ------------------------------------------------------------ settings */

  Future<String?> readSetting(String key) async {
    final row = await (select(settings)..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> writeSetting(String key, String value) =>
      into(settings).insertOnConflictUpdate(
        SettingsCompanion.insert(key: key, value: value),
      );

  /// Every setting as a map, for the settings screen.
  Future<Map<String, String>> readAllSettings() async {
    final rows = await select(settings).get();
    return {for (final r in rows) r.key: r.value};
  }
}

/// Helpers converting between database rows and the domain model.
///
/// The UI never sees a `*Row` type — screens keep working against the same
/// domain classes they always used, which is why swapping mock lists for the
/// database did not require rewriting them.
extension BranchMapping on BranchRow {
  domain.Branch toDomain() => domain.Branch(
        id: id,
        name: name,
        code: code,
        address: domain.Address(
          line1: addressLine,
          city: city,
          state: state,
          country: country,
        ),
        status: domain.BranchStatus.values.byName(status),
        establishedAt: establishedAt,
        pastorId: pastorId ?? '',
        assistantPastorId: assistantPastorId,
        accent: domain.AccentToken.values.byName(accent),
        isHeadquarters: isHeadquarters,
      );
}

extension MemberMapping on MemberRow {
  domain.Member toDomain({
    List<String> departmentIds = const [],
  }) =>
      domain.Member(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        gender: domain.Gender.values.byName(gender),
        dateOfBirth: dateOfBirth,
        maritalStatus: domain.MaritalStatus.values.byName(maritalStatus),
        status: domain.MemberStatus.values.byName(status),
        joinedAt: joinedAt,
        address: domain.Address(
          line1: addressLine,
          city: city,
          state: state,
          country: country,
        ),
        isBaptized: isBaptized,
        branchId: branchId,
        departmentIds: departmentIds,
        groupId: groupId,
        familyId: familyId,
        notes: notes,
        tags: tags.isEmpty ? const [] : tags.split('|'),
      );
}

extension DepartmentTypeMapping on DepartmentTypeRow {
  domain.DepartmentType toDomain() => domain.DepartmentType(
        id: id,
        name: name,
        description: description,
        icon: icon,
        accent: domain.AccentToken.values.byName(accent),
        isCore: isCore,
        ageRange: (minAge != null && maxAge != null)
            ? (min: minAge!, max: maxAge!)
            : null,
      );
}

extension DepartmentMapping on DepartmentRow {
  domain.Department toDomain(List<String> memberIds) => domain.Department(
        id: id,
        typeId: typeId,
        branchId: branchId,
        headId: headId ?? '',
        assistantHeadId: assistantHeadId,
        memberIds: memberIds,
        meetingDay: domain.Weekday.values.byName(meetingDay),
        meetingTime: meetingTime,
        notes: notes,
      );
}

extension UserAccountMapping on UserAccountRow {
  domain.StaffUser toDomain() => domain.StaffUser(
        id: id,
        name: name,
        username: username,
        role: domain.UserRole.values.byName(role),
        lastActiveAt: lastActiveAt ?? DateTime.now().toUtc(),
        status: domain.AccountStatus.values.byName(status),
        branchId: branchId,
        departmentId: departmentId,
        branchAccessGrant: canSeeAllBranches,
      );
}

extension AttendanceMapping on AttendanceRow {
  domain.AttendanceRecord toDomain() => domain.AttendanceRecord(
        id: id,
        branchId: branchId,
        date: date,
        serviceName: serviceName,
        adults: adults,
        children: children,
        visitors: visitors,
        online: online,
      );
}

extension DonationMapping on DonationRow {
  domain.Donation toDomain() => domain.Donation(
        id: id,
        branchId: branchId,
        memberId: memberId,
        donorName: donorName,
        amount: amount,
        fund: domain.GivingFund.values.byName(fund),
        method: domain.PaymentMethod.values.byName(method),
        date: date,
        reference: reference,
        isRecurring: isRecurring,
      );
}

extension ExpenseMapping on ExpenseRow {
  domain.ExpenseRecord toDomain() => domain.ExpenseRecord(
        id: id,
        branchId: branchId,
        category: category,
        vendor: vendor,
        amount: amount,
        date: date,
        approvedBy: approvedBy ?? '',
        status: domain.ExpenseStatus.values.byName(status),
      );
}

extension PledgeMapping on PledgeRow {
  domain.Pledge toDomain() => domain.Pledge(
        id: id,
        memberId: memberId,
        campaign: campaign,
        pledged: pledged,
        fulfilled: fulfilled,
        dueDate: dueDate,
      );
}

extension EventMapping on EventRow {
  domain.ChurchEvent toDomain() => domain.ChurchEvent(
        id: id,
        branchId: branchId,
        title: title,
        description: description,
        category: domain.EventCategory.values.byName(category),
        startsAt: startsAt,
        endsAt: endsAt,
        location: location,
        organizerId: organizerId ?? '',
        expectedAttendance: expectedAttendance,
        registeredCount: registeredCount,
        isRecurring: isRecurring,
      );
}

extension CareMapping on CareRequestRow {
  domain.CareRequest toDomain() => domain.CareRequest(
        id: id,
        branchId: branchId,
        memberId: memberId,
        type: domain.CareType.values.byName(type),
        summary: summary,
        status: domain.CareStatus.values.byName(status),
        priority: domain.CarePriority.values.byName(priority),
        createdAt: createdAt,
        assignedToId: assignedToId,
      );
}

extension SlotMapping on VolunteerSlotRow {
  domain.VolunteerSlot toDomain() => domain.VolunteerSlot(
        id: id,
        branchId: branchId,
        date: date,
        serviceName: serviceName,
        role: domain.ServingRole.values.byName(role),
        memberId: memberId,
        status: domain.SlotStatus.values.byName(status),
      );
}

extension AssetMapping on AssetRow {
  domain.AssetItem toDomain() => domain.AssetItem(
        id: id,
        branchId: branchId,
        name: name,
        category: category,
        serial: serial,
        condition: domain.AssetCondition.values.byName(condition),
        location: location,
        purchasedAt: purchasedAt,
        value: value,
      );
}

extension CampaignMapping on CampaignRow {
  domain.Campaign toDomain() => domain.Campaign(
        id: id,
        branchId: branchId,
        subject: subject,
        channel: domain.CampaignChannel.values.byName(channel),
        status: domain.CampaignStatus.values.byName(status),
        audience: audience,
        recipients: recipients,
        openRate: openRate,
        sentAt: sentAt,
        scheduledFor: scheduledFor,
      );
}

extension AnnouncementMapping on AnnouncementRow {
  domain.AnnouncementItem toDomain() => domain.AnnouncementItem(
        id: id,
        branchId: branchId,
        title: title,
        body: body,
        postedAt: postedAt,
        authorId: authorId ?? '',
        pinned: pinned,
      );
}

extension CourseMapping on CourseRow {
  domain.Course toDomain() => domain.Course(
        id: id,
        branchId: branchId,
        name: name,
        description: description,
        lessons: lessons,
        enrolled: enrolled,
        completed: completed,
        facilitatorId: facilitatorId ?? '',
      );
}

extension SmallGroupMapping on SmallGroupRow {
  domain.SmallGroup toDomain(int memberCount) => domain.SmallGroup(
        id: id,
        branchId: branchId,
        name: name,
        leaderId: leaderId ?? '',
        memberCount: memberCount,
        location: location,
        meetingDay: domain.Weekday.values.byName(meetingDay),
        meetingTime: meetingTime,
        capacity: capacity,
      );
}
