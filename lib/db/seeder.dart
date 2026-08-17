import 'package:drift/drift.dart';

import '../data/departments_data.dart' as seed_dept;
import '../data/events_data.dart' as seed_ev;
import '../data/finance_data.dart' as seed_fin;
import '../data/members_data.dart' as seed_mem;
import '../data/ministries_data.dart' as seed_min;
import '../data/operations_data.dart' as seed_ops;
import '../models/models.dart';
import 'database.dart';
import 'password.dart';

/// Populates a brand-new database from the bundled demo dataset.
///
/// Runs once, the first time the app opens a database that does not yet exist.
/// After this the `lib/data/*` files are no longer read — they exist only as
/// the seed, and every subsequent read and write goes through SQL.
///
/// The whole thing runs in a single transaction: either the database ends up
/// fully populated or completely empty, never half-built.
class Seeder {
  Seeder(this.db);

  final AppDatabase db;

  /// Accounts created on first run. Passwords are hashed before storage.
  ///
  /// These are demo credentials and are deliberately shown on the sign-in
  /// screen, because there is no other way in on a fresh install. Change them
  /// (or delete the accounts) before this is used with real congregation data.
  static const demoPassword = 'church2026';

  Future<void> seedFirstRun() async {
    await db.transaction(() async {
      await _seedBranches();
      await _seedMembers();
      await _seedDepartmentTypes();
      await _seedDepartments();
      await _seedAccounts();
      await _seedAttendance();
      await _seedFinance();
      await _seedOperations();
      await _seedSettings();
    });
  }

  Future<void> _seedBranches() async {
    await db.batch((b) {
      b.insertAll(db.branches, [
        for (final branch in seed_dept.branches)
          BranchesCompanion.insert(
            id: branch.id,
            name: branch.name,
            code: branch.code,
            addressLine: branch.address.line1,
            city: branch.address.city,
            state: branch.address.state,
            country: Value(branch.address.country),
            status: branch.status.name,
            establishedAt: branch.establishedAt,
            // Pastors are members, so they are attached after members exist.
            pastorId: const Value(null),
            assistantPastorId: const Value(null),
            accent: branch.accent.name,
            isHeadquarters: Value(branch.isHeadquarters),
          ),
      ]);
    });
  }

  Future<void> _seedMembers() async {
    await db.batch((b) {
      b.insertAll(db.members, [
        for (final m in seed_mem.members)
          MembersCompanion.insert(
            id: m.id,
            firstName: m.firstName,
            lastName: m.lastName,
            email: Value(m.email),
            phone: Value(m.phone),
            gender: m.gender.name,
            dateOfBirth: m.dateOfBirth,
            maritalStatus: m.maritalStatus.name,
            status: m.status.name,
            joinedAt: m.joinedAt,
            addressLine: Value(m.address.line1),
            city: Value(m.address.city),
            state: Value(m.address.state),
            country: Value(m.address.country),
            isBaptized: Value(m.isBaptized),
            branchId: m.branchId,
            groupId: Value(m.groupId),
            familyId: Value(m.familyId),
            notes: Value(m.notes),
            tags: Value(m.tags.join('|')),
          ),
      ]);
    });

    // Now that members exist, attach each branch's pastor and assistant.
    for (final branch in seed_dept.branches) {
      await (db.update(db.branches)..where((t) => t.id.equals(branch.id)))
          .write(BranchesCompanion(
        pastorId: Value(branch.pastorId),
        assistantPastorId: Value(branch.assistantPastorId),
      ));
    }
  }

  Future<void> _seedDepartmentTypes() async {
    await db.batch((b) {
      b.insertAll(db.departmentTypes, [
        for (final t in seed_dept.departmentTypes)
          DepartmentTypesCompanion.insert(
            id: t.id,
            name: t.name,
            description: Value(t.description),
            icon: Value(t.icon),
            accent: t.accent.name,
            isCore: Value(t.isCore),
            minAge: Value(t.ageRange?.min),
            maxAge: Value(t.ageRange?.max),
          ),
      ]);
    });
  }

  Future<void> _seedDepartments() async {
    await db.batch((b) {
      b.insertAll(db.departments, [
        for (final d in seed_dept.departments)
          DepartmentsCompanion.insert(
            id: d.id,
            typeId: d.typeId,
            branchId: d.branchId,
            headId: Value(d.headId),
            assistantHeadId: Value(d.assistantHeadId),
            meetingDay: d.meetingDay.name,
            meetingTime: d.meetingTime,
          ),
      ]);

      b.insertAll(db.departmentMembers, [
        for (final d in seed_dept.departments)
          for (final memberId in d.memberIds)
            DepartmentMembersCompanion.insert(
              departmentId: d.id,
              memberId: memberId,
            ),
      ]);
    });
  }

  /// Creates one sign-in account per seeded staff role, including a department
  /// head at each core department so the per-department login can be tried.
  Future<void> _seedAccounts() async {
    final rows = <UserAccountsCompanion>[];

    void add({
      required String id,
      required String name,
      required String email,
      required UserRole role,
      String? branchId,
      String? departmentId,
      String? memberId,
      AccountStatus status = AccountStatus.active,
      bool? canSeeAllBranches,
    }) {
      final salt = Password.generateSalt();
      rows.add(UserAccountsCompanion.insert(
        id: id,
        name: name,
        email: email.toLowerCase(),
        passwordHash: Password.hash(demoPassword, salt),
        passwordSalt: salt,
        role: role.name,
        status: status.name,
        branchId: Value(branchId),
        departmentId: Value(departmentId),
        memberId: Value(memberId),
        canSeeAllBranches: Value(canSeeAllBranches),
        lastActiveAt: Value(DateTime.now().toUtc()),
      ));
    }

    // Church-wide and branch staff, from the existing seed list.
    //
    // Nobody is granted cross-branch sight here: Super Admin gets it from the
    // role default, and everyone else starts confined to their own branch. The
    // demo therefore shows the restriction working rather than assuming it away.
    for (final user in seed_ops.staffUsers) {
      add(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        branchId: user.branchId ?? seed_dept.branches.first.id,
        departmentId: user.departmentId,
        status: user.status,
      );
    }

    // A department head account for every department, so each one has a real
    // login that lands on its own department.
    var index = 0;
    for (final department in seed_dept.departments) {
      final head = seed_mem.memberById(department.headId);
      if (head == null) continue;

      final type = seed_dept.departmentTypeById(department.typeId);
      final branch = seed_dept.branchById(department.branchId);
      final slug = (type?.name ?? 'dept')
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9]+'), '');
      final email = '$slug.${branch?.code.toLowerCase() ?? 'br'}@gracechapel.org';

      // Skip if this member already has an account from the staff list.
      if (rows.any((r) => r.email.value == email)) continue;

      add(
        id: 'usr-dept-${index.toString().padLeft(4, '0')}',
        name: head.fullName,
        email: email,
        role: UserRole.departmentHead,
        branchId: department.branchId,
        departmentId: department.id,
        memberId: head.id,
      );
      index++;
    }

    await db.batch((b) => b.insertAll(db.userAccounts, rows));
  }

  Future<void> _seedAttendance() async {
    await db.batch((b) {
      b.insertAll(db.attendanceRecords, [
        for (final r in seed_ev.attendanceRecords)
          AttendanceRecordsCompanion.insert(
            id: r.id,
            branchId: r.branchId,
            date: r.date,
            serviceName: r.serviceName,
            adults: Value(r.adults),
            children: Value(r.children),
            visitors: Value(r.visitors),
            online: Value(r.online),
          ),
      ]);

      b.insertAll(db.events, [
        for (final e in seed_ev.events)
          EventsCompanion.insert(
            id: e.id,
            branchId: e.branchId,
            title: e.title,
            description: Value(e.description),
            category: e.category.name,
            startsAt: e.startsAt,
            endsAt: e.endsAt,
            location: Value(e.location),
            organizerId: Value(e.organizerId),
            expectedAttendance: Value(e.expectedAttendance),
            registeredCount: Value(e.registeredCount),
            isRecurring: Value(e.isRecurring),
          ),
      ]);

      b.insertAll(db.announcements, [
        for (final a in seed_ev.announcements)
          AnnouncementsCompanion.insert(
            id: a.id,
            branchId: a.branchId,
            title: a.title,
            body: a.body,
            authorId: Value(a.authorId),
            postedAt: a.postedAt,
            pinned: Value(a.pinned),
          ),
      ]);
    });
  }

  Future<void> _seedFinance() async {
    await db.batch((b) {
      b.insertAll(db.donations, [
        for (final d in seed_fin.donations)
          DonationsCompanion.insert(
            id: d.id,
            branchId: d.branchId,
            memberId: Value(d.memberId),
            donorName: d.donorName,
            amount: d.amount,
            fund: d.fund.name,
            method: d.method.name,
            date: d.date,
            reference: d.reference,
            isRecurring: Value(d.isRecurring),
          ),
      ]);

      b.insertAll(db.expenses, [
        for (final e in seed_fin.expenses)
          ExpensesCompanion.insert(
            id: e.id,
            branchId: e.branchId,
            category: e.category,
            vendor: e.vendor,
            amount: e.amount,
            date: e.date,
            approvedBy: Value(e.approvedBy),
            status: e.status.name,
          ),
      ]);

      b.insertAll(db.pledges, [
        for (final p in seed_fin.pledges)
          PledgesCompanion.insert(
            id: p.id,
            // Pledges follow the member's branch.
            branchId: seed_mem.memberById(p.memberId)?.branchId ??
                seed_dept.branches.first.id,
            memberId: p.memberId,
            campaign: p.campaign,
            pledged: p.pledged,
            fulfilled: Value(p.fulfilled),
            dueDate: p.dueDate,
          ),
      ]);
    });
  }

  Future<void> _seedOperations() async {
    await db.batch((b) {
      b.insertAll(db.careRequests, [
        for (final c in seed_ops.careRequests)
          CareRequestsCompanion.insert(
            id: c.id,
            branchId: c.branchId,
            memberId: c.memberId,
            type: c.type.name,
            summary: c.summary,
            status: c.status.name,
            priority: c.priority.name,
            assignedToId: Value(c.assignedToId),
            createdAt: Value(c.createdAt),
          ),
      ]);

      b.insertAll(db.assets, [
        for (final a in seed_ops.assets)
          AssetsCompanion.insert(
            id: a.id,
            branchId: a.branchId,
            name: a.name,
            category: a.category,
            serial: Value(a.serial),
            condition: a.condition.name,
            location: Value(a.location),
            purchasedAt: a.purchasedAt,
            value: Value(a.value),
          ),
      ]);

      b.insertAll(db.campaigns, [
        for (final c in seed_ops.campaigns)
          CampaignsCompanion.insert(
            id: c.id,
            branchId: c.branchId,
            subject: c.subject,
            channel: c.channel.name,
            status: c.status.name,
            audience: c.audience,
            recipients: Value(c.recipients),
            openRate: Value(c.openRate),
            sentAt: Value(c.sentAt),
            scheduledFor: Value(c.scheduledFor),
          ),
      ]);

      b.insertAll(db.volunteerSlots, [
        for (final s in seed_min.volunteerSlots)
          VolunteerSlotsCompanion.insert(
            id: s.id,
            branchId: s.branchId,
            date: s.date,
            serviceName: s.serviceName,
            role: s.role.name,
            memberId: Value(s.memberId),
            status: s.status.name,
          ),
      ]);

      b.insertAll(db.courses, [
        for (final c in seed_min.courses)
          CoursesCompanion.insert(
            id: c.id,
            branchId: c.branchId,
            name: c.name,
            description: Value(c.description),
            lessons: Value(c.lessons),
            enrolled: Value(c.enrolled),
            completed: Value(c.completed),
            facilitatorId: Value(c.facilitatorId),
          ),
      ]);

      b.insertAll(db.smallGroups, [
        for (final g in seed_min.smallGroups)
          SmallGroupsCompanion.insert(
            id: g.id,
            branchId: g.branchId,
            name: g.name,
            leaderId: Value(g.leaderId),
            location: Value(g.location),
            meetingDay: g.meetingDay.name,
            meetingTime: g.meetingTime,
            capacity: Value(g.capacity),
          ),
      ]);
    });
  }

  Future<void> _seedSettings() async {
    const defaults = <String, String>{
      'church.name': 'Grace Chapel',
      'church.legalName': 'Grace Chapel International Ministries',
      'church.email': 'office@gracechapel.org',
      'church.phone': '+233 24 123 4567',
      'church.website': 'gracechapel.org',
      'church.pastor': 'Pastor Samuel Mensah',
      'church.founded': '2004',
      'church.currency': 'GHS',
      'church.timezone': 'Africa/Accra',
      'pref.first-timer': 'true',
      'pref.birthday': 'true',
      'pref.inactive': 'true',
      'pref.receipts': 'true',
      'pref.rota': 'true',
      'pref.hide-giving': 'true',
      'pref.directory': 'false',
      'pref.digest': 'false',
      'seed.version': '1',
    };

    await db.batch((b) {
      b.insertAll(db.settings, [
        for (final entry in defaults.entries)
          SettingsCompanion.insert(key: entry.key, value: entry.value),
      ]);
    });
  }
}
