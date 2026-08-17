import 'package:drift/drift.dart';

import '../models/models.dart' as domain;
import 'database.dart';
import 'password.dart';

/// All reads and writes against the database.
///
/// Every method returns domain types, never `*Row` types, so screens keep
/// working against the same model classes they always used. Soft-deleted rows
/// are filtered out here rather than in each caller, so a deleted record cannot
/// reappear by accident.
class ChurchRepository {
  ChurchRepository(this.db);

  final AppDatabase db;

  /// Generates the next id for a table, continuing the seeded `pre-0001` style.
  Future<String> _nextId(String prefix, TableInfo table) async {
    final rows = await db.customSelect(
      'SELECT id FROM ${table.actualTableName} '
      "WHERE id LIKE '$prefix-%' ORDER BY id DESC LIMIT 1",
    ).get();

    var next = 1;
    if (rows.isNotEmpty) {
      final last = rows.first.data['id'] as String;
      next = (int.tryParse(last.split('-').last) ?? 0) + 1;
    }
    return '$prefix-${next.toString().padLeft(4, '0')}';
  }

  DateTime get _now => DateTime.now().toUtc();

  /* ------------------------------------------------------------ branches */

  Stream<List<domain.Branch>> watchBranches() {
    final query = db.select(db.branches)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.isHeadquarters, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.establishedAt),
      ]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Future<String> createBranch({
    required String name,
    required String code,
    required String addressLine,
    required String city,
    required String state,
    required domain.BranchStatus status,
    required DateTime establishedAt,
    required domain.AccentToken accent,
    String? pastorId,
    String? assistantPastorId,
  }) async {
    final id = await _nextId('brn', db.branches);
    await db.into(db.branches).insert(BranchesCompanion.insert(
          id: id,
          name: name,
          code: code.toUpperCase(),
          addressLine: addressLine,
          city: city,
          state: state,
          status: status.name,
          establishedAt: establishedAt,
          accent: accent.name,
          pastorId: Value(pastorId),
          assistantPastorId: Value(assistantPastorId),
        ));
    return id;
  }

  Future<void> updateBranch(
    String id, {
    String? name,
    String? code,
    String? addressLine,
    String? city,
    String? state,
    domain.BranchStatus? status,
    String? pastorId,
    String? assistantPastorId,
  }) =>
      (db.update(db.branches)..where((t) => t.id.equals(id))).write(
        BranchesCompanion(
          name: name == null ? const Value.absent() : Value(name),
          code: code == null ? const Value.absent() : Value(code.toUpperCase()),
          addressLine:
              addressLine == null ? const Value.absent() : Value(addressLine),
          city: city == null ? const Value.absent() : Value(city),
          state: state == null ? const Value.absent() : Value(state),
          status: status == null ? const Value.absent() : Value(status.name),
          pastorId: pastorId == null ? const Value.absent() : Value(pastorId),
          assistantPastorId: assistantPastorId == null
              ? const Value.absent()
              : Value(assistantPastorId),
          updatedAt: Value(_now),
        ),
      );

  /// Sets the branch pastor and assistant — "add branch head".
  /// Sets a branch's pastor and assistant.
  ///
  /// Both must be members of that branch — a campus is led by someone who
  /// belongs to it. Ids from another branch are rejected rather than silently
  /// written, so this holds no matter which screen calls in.
  Future<void> setBranchLeadership(
    String branchId, {
    String? pastorId,
    String? assistantPastorId,
  }) async {
    Future<String?> validated(String? memberId) async {
      if (memberId == null) return null;
      final member = await findMember(memberId);
      return member?.branchId == branchId ? memberId : null;
    }

    await (db.update(db.branches)..where((t) => t.id.equals(branchId))).write(
      BranchesCompanion(
        pastorId: Value(await validated(pastorId)),
        assistantPastorId: Value(await validated(assistantPastorId)),
        updatedAt: Value(_now),
      ),
    );
  }

  /* ------------------------------------------------------------- members */

  Stream<List<domain.Member>> watchMembers() {
    // Members and their department memberships are joined in one query so the
    // UI gets a complete Member without an N+1 lookup per row.
    final query = db.select(db.members)..where((t) => t.deletedAt.isNull());

    return query.watch().asyncMap((rows) async {
      final links = await db.select(db.departmentMembers).get();
      final byMember = <String, List<String>>{};
      for (final link in links) {
        byMember.putIfAbsent(link.memberId, () => []).add(link.departmentId);
      }
      return rows
          .map((r) => r.toDomain(departmentIds: byMember[r.id] ?? const []))
          .toList()
        ..sort((a, b) => a.lastName.compareTo(b.lastName));
    });
  }

  Future<domain.Member?> findMember(String id) async {
    final row = await (db.select(db.members)
          ..where((t) => t.id.equals(id) & t.deletedAt.isNull()))
        .getSingleOrNull();
    if (row == null) return null;

    final links = await (db.select(db.departmentMembers)
          ..where((t) => t.memberId.equals(id)))
        .get();
    return row.toDomain(
      departmentIds: links.map((l) => l.departmentId).toList(),
    );
  }

  Future<String> createMember({
    required String firstName,
    required String lastName,
    required String branchId,
    required domain.Gender gender,
    required DateTime dateOfBirth,
    required domain.MaritalStatus maritalStatus,
    required domain.MemberStatus status,
    required bool isBaptized,
    String email = '',
    String phone = '',
    String addressLine = '',
    String city = '',
    String state = '',
    String? notes,
    List<String> tags = const [],
    DateTime? joinedAt,
  }) async {
    final id = await _nextId('mem', db.members);
    await db.into(db.members).insert(MembersCompanion.insert(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: Value(email),
          phone: Value(phone),
          gender: gender.name,
          dateOfBirth: dateOfBirth,
          maritalStatus: maritalStatus.name,
          status: status.name,
          joinedAt: joinedAt ?? _now,
          addressLine: Value(addressLine),
          city: Value(city),
          state: Value(state),
          isBaptized: Value(isBaptized),
          branchId: branchId,
          notes: Value(notes),
          tags: Value(tags.join('|')),
        ));
    return id;
  }

  Future<void> updateMember(
    String id, {
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? branchId,
    domain.Gender? gender,
    DateTime? dateOfBirth,
    domain.MaritalStatus? maritalStatus,
    domain.MemberStatus? status,
    bool? isBaptized,
    String? addressLine,
    String? city,
    String? state,
    String? notes,
  }) =>
      (db.update(db.members)..where((t) => t.id.equals(id))).write(
        MembersCompanion(
          firstName:
              firstName == null ? const Value.absent() : Value(firstName),
          lastName: lastName == null ? const Value.absent() : Value(lastName),
          email: email == null ? const Value.absent() : Value(email),
          phone: phone == null ? const Value.absent() : Value(phone),
          branchId: branchId == null ? const Value.absent() : Value(branchId),
          gender: gender == null ? const Value.absent() : Value(gender.name),
          dateOfBirth:
              dateOfBirth == null ? const Value.absent() : Value(dateOfBirth),
          maritalStatus: maritalStatus == null
              ? const Value.absent()
              : Value(maritalStatus.name),
          status: status == null ? const Value.absent() : Value(status.name),
          isBaptized:
              isBaptized == null ? const Value.absent() : Value(isBaptized),
          addressLine:
              addressLine == null ? const Value.absent() : Value(addressLine),
          city: city == null ? const Value.absent() : Value(city),
          state: state == null ? const Value.absent() : Value(state),
          notes: notes == null ? const Value.absent() : Value(notes),
          updatedAt: Value(_now),
        ),
      );

  /// Soft delete — the row stays for audit, but disappears from every query.
  Future<void> deleteMember(String id) =>
      (db.update(db.members)..where((t) => t.id.equals(id)))
          .write(MembersCompanion(deletedAt: Value(_now)));

  /* --------------------------------------------------------- departments */

  Stream<List<domain.DepartmentType>> watchDepartmentTypes() {
    final query = db.select(db.departmentTypes)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.isCore, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.name),
      ]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Stream<List<domain.Department>> watchDepartments() {
    // Newest first; the screen groups by catalogue type for display, so this
    // decides the order within a type.
    final query = db.select(db.departments)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);

    return query.watch().asyncMap((rows) async {
      final links = await db.select(db.departmentMembers).get();
      final byDepartment = <String, List<String>>{};
      for (final link in links) {
        byDepartment.putIfAbsent(link.departmentId, () => []).add(link.memberId);
      }
      return rows
          .map((r) => r.toDomain(byDepartment[r.id] ?? const []))
          .toList();
    });
  }

  Future<String> createDepartmentType({
    required String name,
    required String description,
    required domain.AccentToken accent,
    String icon = 'groups',
    bool isCore = false,
    int? minAge,
    int? maxAge,
  }) async {
    final id = await _nextId('dpt', db.departmentTypes);
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
    return id;
  }

  Future<String> createDepartment({
    required String typeId,
    required String branchId,
    required String headId,
    required domain.Weekday meetingDay,
    required String meetingTime,
    String? assistantHeadId,
  }) async {
    final id = await _nextId('dep', db.departments);
    await db.into(db.departments).insert(DepartmentsCompanion.insert(
          id: id,
          typeId: typeId,
          branchId: branchId,
          headId: Value(headId),
          assistantHeadId: Value(assistantHeadId),
          meetingDay: meetingDay.name,
          meetingTime: meetingTime,
        ));
    return id;
  }

  /// Sets the department head and assistant — "add department leader".
  /// Sets a department's head and assistant.
  ///
  /// Both must be members of the department's own branch, for the same reason
  /// branch leadership is validated: a team is led by someone who attends it.
  Future<void> setDepartmentLeadership(
    String departmentId, {
    String? headId,
    String? assistantHeadId,
  }) async {
    final department = await (db.select(db.departments)
          ..where((t) => t.id.equals(departmentId)))
        .getSingleOrNull();
    if (department == null) return;

    Future<String?> validated(String? memberId) async {
      if (memberId == null) return null;
      final member = await findMember(memberId);
      return member?.branchId == department.branchId ? memberId : null;
    }

    await (db.update(db.departments)..where((t) => t.id.equals(departmentId)))
        .write(DepartmentsCompanion(
      headId: Value(await validated(headId)),
      assistantHeadId: Value(await validated(assistantHeadId)),
      updatedAt: Value(_now),
    ));
  }

  /// Replaces a department's membership in one transaction.
  /// Replaces a department's membership.
  ///
  /// Only members of the department's own branch are accepted, and any age
  /// restriction on the type is enforced — so the Children's department can
  /// never end up containing adults, whatever the caller passes.
  Future<void> setDepartmentMembers(
    String departmentId,
    Set<String> memberIds,
  ) async {
    final department = await (db.select(db.departments)
          ..where((t) => t.id.equals(departmentId)))
        .getSingleOrNull();
    if (department == null) return;

    final type = await (db.select(db.departmentTypes)
          ..where((t) => t.id.equals(department.typeId)))
        .getSingleOrNull();

    final now = DateTime.now().toUtc();
    final accepted = <String>[];

    for (final memberId in memberIds) {
      final member = await findMember(memberId);
      if (member == null) continue;
      if (member.branchId != department.branchId) continue;

      final min = type?.minAge;
      final max = type?.maxAge;
      if (min != null || max != null) {
        final age = member.ageAt(now);
        if (min != null && age < min) continue;
        if (max != null && age > max) continue;
      }
      accepted.add(memberId);
    }

    await db.transaction(() async {
      await (db.delete(db.departmentMembers)
            ..where((t) => t.departmentId.equals(departmentId)))
          .go();
      await db.batch((b) {
        b.insertAll(db.departmentMembers, [
          for (final memberId in accepted)
            DepartmentMembersCompanion.insert(
              departmentId: departmentId,
              memberId: memberId,
            ),
        ]);
      });
    });
  }

  Future<void> deleteDepartment(String id) async {
    await db.transaction(() async {
      await (db.delete(db.departmentMembers)
            ..where((t) => t.departmentId.equals(id)))
          .go();
      await (db.update(db.departments)..where((t) => t.id.equals(id)))
          .write(DepartmentsCompanion(deletedAt: Value(_now)));
    });
  }

  /* -------------------------------------------------------------- access */

  Stream<List<domain.StaffUser>> watchUsers() {
    final query = db.select(db.userAccounts)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm(expression: t.role)]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  /// Verifies credentials. Returns null when the email is unknown, the password
  /// is wrong, or the account is suspended — deliberately the same result in
  /// every case, so the response cannot be used to discover valid emails.
  Future<domain.StaffUser?> signIn(String email, String password) async {
    final row = await (db.select(db.userAccounts)
          ..where((t) =>
              t.email.equals(email.trim().toLowerCase()) & t.deletedAt.isNull()))
        .getSingleOrNull();

    if (row == null) return null;
    if (row.status == domain.AccountStatus.suspended.name) return null;
    if (!Password.verify(password, row.passwordSalt, row.passwordHash)) {
      return null;
    }

    await (db.update(db.userAccounts)..where((t) => t.id.equals(row.id))).write(
      UserAccountsCompanion(
        lastActiveAt: Value(_now),
        // An invited account becomes active on first successful sign-in.
        status: row.status == domain.AccountStatus.invited.name
            ? Value(domain.AccountStatus.active.name)
            : const Value.absent(),
      ),
    );

    return row.toDomain();
  }

  Future<bool> emailExists(String email) async {
    final row = await (db.select(db.userAccounts)
          ..where((t) => t.email.equals(email.trim().toLowerCase())))
        .getSingleOrNull();
    return row != null;
  }

  Future<String> createUser({
    required String name,
    required String email,
    required String password,
    required domain.UserRole role,
    String? branchId,
    String? departmentId,
    String? memberId,
    domain.AccountStatus status = domain.AccountStatus.invited,
    bool? canSeeAllBranches,
  }) async {
    final id = await _nextId('usr', db.userAccounts);
    final salt = Password.generateSalt();

    await db.into(db.userAccounts).insert(UserAccountsCompanion.insert(
          id: id,
          name: name,
          email: email.trim().toLowerCase(),
          passwordHash: Password.hash(password, salt),
          passwordSalt: salt,
          role: role.name,
          status: status.name,
          branchId: Value(branchId),
          departmentId: Value(departmentId),
          memberId: Value(memberId),
          canSeeAllBranches: Value(canSeeAllBranches),
        ));
    return id;
  }

  /// Grants or revokes cross-branch visibility for one account.
  ///
  /// Passing null restores the role's default. Roles below branch level cannot
  /// be granted it at all — the check lives here so it holds no matter which
  /// screen calls in.
  Future<void> setBranchVisibility(String userId, bool? canSeeAll) async {
    final row = await (db.select(db.userAccounts)
          ..where((t) => t.id.equals(userId)))
        .getSingleOrNull();
    if (row == null) return;

    final role = domain.UserRole.values.byName(row.role);
    if (canSeeAll == true && !role.mayBeGrantedAllBranches) return;

    await (db.update(db.userAccounts)..where((t) => t.id.equals(userId)))
        .write(UserAccountsCompanion(
      canSeeAllBranches: Value(canSeeAll),
      updatedAt: Value(_now),
    ));
  }

  Future<void> updateUserRole(
    String id, {
    domain.UserRole? role,
    String? branchId,
    String? departmentId,
    domain.AccountStatus? status,
  }) =>
      (db.update(db.userAccounts)..where((t) => t.id.equals(id))).write(
        UserAccountsCompanion(
          role: role == null ? const Value.absent() : Value(role.name),
          branchId: Value(branchId),
          departmentId: Value(departmentId),
          status: status == null ? const Value.absent() : Value(status.name),
          updatedAt: Value(_now),
        ),
      );

  Future<void> changePassword(String userId, String newPassword) async {
    final salt = Password.generateSalt();
    await (db.update(db.userAccounts)..where((t) => t.id.equals(userId))).write(
      UserAccountsCompanion(
        passwordHash: Value(Password.hash(newPassword, salt)),
        passwordSalt: Value(salt),
        mustChangePassword: const Value(false),
        updatedAt: Value(_now),
      ),
    );
  }

  Future<void> deleteUser(String id) =>
      (db.update(db.userAccounts)..where((t) => t.id.equals(id)))
          .write(UserAccountsCompanion(deletedAt: Value(_now)));

  /* ---------------------------------------------------------- attendance */

  Stream<List<domain.AttendanceRecord>> watchAttendance() {
    final query = db.select(db.attendanceRecords)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
        // Tie-break on entry time so a record just saved appears above others
        // sharing its date, rather than in an arbitrary position.
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Future<String> recordAttendance({
    required String branchId,
    required DateTime date,
    required String serviceName,
    int adults = 0,
    int children = 0,
    int visitors = 0,
    int online = 0,
  }) async {
    final id = await _nextId('att', db.attendanceRecords);
    await db.into(db.attendanceRecords).insert(
          AttendanceRecordsCompanion.insert(
            id: id,
            branchId: branchId,
            date: date,
            serviceName: serviceName,
            adults: Value(adults),
            children: Value(children),
            visitors: Value(visitors),
            online: Value(online),
          ),
        );
    return id;
  }

  /// Saves a member check-in list against a service, and updates the headcount
  /// to match so the two can never disagree.
  Future<void> saveCheckIns({
    required String branchId,
    required DateTime date,
    required String serviceName,
    required Set<String> memberIds,
  }) async {
    await db.transaction(() async {
      // Reuse today's record for this service if one already exists.
      final existing = await (db.select(db.attendanceRecords)
            ..where((t) =>
                t.branchId.equals(branchId) &
                t.date.equals(date) &
                t.serviceName.equals(serviceName) &
                t.deletedAt.isNull()))
          .getSingleOrNull();

      final id = existing?.id ??
          await recordAttendance(
            branchId: branchId,
            date: date,
            serviceName: serviceName,
          );

      await (db.delete(db.checkIns)..where((t) => t.attendanceId.equals(id)))
          .go();
      await db.batch((b) {
        b.insertAll(db.checkIns, [
          for (final memberId in memberIds)
            CheckInsCompanion.insert(attendanceId: id, memberId: memberId),
        ]);
      });

      await (db.update(db.attendanceRecords)..where((t) => t.id.equals(id)))
          .write(AttendanceRecordsCompanion(
        adults: Value(memberIds.length),
        updatedAt: Value(_now),
      ));
    });
  }

  Future<Set<String>> checkedInMembers(String attendanceId) async {
    final rows = await (db.select(db.checkIns)
          ..where((t) => t.attendanceId.equals(attendanceId)))
        .get();
    return rows.map((r) => r.memberId).toSet();
  }

  /* -------------------------------------------------------------- giving */

  Stream<List<domain.Donation>> watchDonations() {
    final query = db.select(db.donations)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
        // Tie-break on entry time so a record just saved appears above others
        // sharing its date, rather than in an arbitrary position.
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Future<String> recordDonation({
    required String branchId,
    required String donorName,
    required double amount,
    required domain.GivingFund fund,
    required domain.PaymentMethod method,
    required DateTime date,
    String? memberId,
    String? reference,
    bool isRecurring = false,
  }) async {
    final id = await _nextId('don', db.donations);
    await db.into(db.donations).insert(DonationsCompanion.insert(
          id: id,
          branchId: branchId,
          memberId: Value(memberId),
          donorName: donorName,
          amount: amount,
          fund: fund.name,
          method: method.name,
          date: date,
          reference: reference ?? 'TXN-${id.split('-').last}',
          isRecurring: Value(isRecurring),
        ));
    return id;
  }

  Stream<List<domain.ExpenseRecord>> watchExpenses() {
    final query = db.select(db.expenses)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
        // Tie-break on entry time so a record just saved appears above others
        // sharing its date, rather than in an arbitrary position.
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Future<String> recordExpense({
    required String branchId,
    required String category,
    required String vendor,
    required double amount,
    required DateTime date,
    required domain.ExpenseStatus status,
    String? approvedBy,
  }) async {
    final id = await _nextId('exp', db.expenses);
    await db.into(db.expenses).insert(ExpensesCompanion.insert(
          id: id,
          branchId: branchId,
          category: category,
          vendor: vendor,
          amount: amount,
          date: date,
          approvedBy: Value(approvedBy),
          status: status.name,
        ));
    return id;
  }

  Stream<List<domain.Pledge>> watchPledges() {
    final query = db.select(db.pledges)..where((t) => t.deletedAt.isNull());
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  /* ----------------------------------------------------------- pastoral */

  Stream<List<domain.CareRequest>> watchCareRequests() {
    final query = db.select(db.careRequests)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Future<String> createCareRequest({
    required String branchId,
    required String memberId,
    required domain.CareType type,
    required String summary,
    required domain.CarePriority priority,
    String? assignedToId,
  }) async {
    final id = await _nextId('care', db.careRequests);
    await db.into(db.careRequests).insert(CareRequestsCompanion.insert(
          id: id,
          branchId: branchId,
          memberId: memberId,
          type: type.name,
          summary: summary,
          status: domain.CareStatus.open.name,
          priority: priority.name,
          assignedToId: Value(assignedToId),
        ));
    return id;
  }

  Future<void> updateCareRequest(
    String id, {
    domain.CareStatus? status,
    domain.CarePriority? priority,
    String? assignedToId,
  }) =>
      (db.update(db.careRequests)..where((t) => t.id.equals(id))).write(
        CareRequestsCompanion(
          status: status == null ? const Value.absent() : Value(status.name),
          priority:
              priority == null ? const Value.absent() : Value(priority.name),
          assignedToId: Value(assignedToId),
          updatedAt: Value(_now),
        ),
      );

  /* ------------------------------------------------------------- others */

  Stream<List<domain.ChurchEvent>> watchEvents() {
    final query = db.select(db.events)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.startsAt),
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Future<String> createEvent({
    required String branchId,
    required String title,
    required domain.EventCategory category,
    required DateTime startsAt,
    required DateTime endsAt,
    String description = '',
    String location = '',
    String? organizerId,
    int expectedAttendance = 0,
    bool isRecurring = false,
  }) async {
    final id = await _nextId('evt', db.events);
    await db.into(db.events).insert(EventsCompanion.insert(
          id: id,
          branchId: branchId,
          title: title,
          description: Value(description),
          category: category.name,
          startsAt: startsAt,
          endsAt: endsAt,
          location: Value(location),
          organizerId: Value(organizerId),
          expectedAttendance: Value(expectedAttendance),
          isRecurring: Value(isRecurring),
        ));
    return id;
  }

  Stream<List<domain.VolunteerSlot>> watchVolunteerSlots() {
    final query = db.select(db.volunteerSlots)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm(expression: t.date)]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  /// Creates an empty serving slot on the rota.
  Future<String> createVolunteerSlot({
    required String branchId,
    required DateTime date,
    required String serviceName,
    required domain.ServingRole role,
  }) async {
    final id = await _nextId('slot', db.volunteerSlots);
    await db.into(db.volunteerSlots).insert(VolunteerSlotsCompanion.insert(
          id: id,
          branchId: branchId,
          date: date,
          serviceName: serviceName,
          role: role.name,
          status: domain.SlotStatus.open.name,
        ));
    return id;
  }

  /// Assigns a member to a serving slot, or clears it.
  ///
  /// [status] is derived from whether a member was given, unless passed
  /// explicitly — "declined" is a real outcome that cannot be inferred from
  /// the member alone.
  Future<void> assignVolunteer(
    String slotId,
    String? memberId, {
    domain.SlotStatus? status,
  }) =>
      (db.update(db.volunteerSlots)..where((t) => t.id.equals(slotId))).write(
        VolunteerSlotsCompanion(
          memberId: Value(memberId),
          status: Value((status ??
                  (memberId == null
                      ? domain.SlotStatus.open
                      : domain.SlotStatus.filled))
              .name),
          updatedAt: Value(_now),
        ),
      );

  Stream<List<domain.AssetItem>> watchAssets() {
    // Newest registration first, so a just-added asset is at the top.
    final query = db.select(db.assets)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Future<String> createAsset({
    required String branchId,
    required String name,
    required String category,
    required domain.AssetCondition condition,
    required DateTime purchasedAt,
    required double value,
    String serial = '',
    String location = '',
  }) async {
    final id = await _nextId('ast', db.assets);
    await db.into(db.assets).insert(AssetsCompanion.insert(
          id: id,
          branchId: branchId,
          name: name,
          category: category,
          serial: Value(serial),
          condition: condition.name,
          location: Value(location),
          purchasedAt: purchasedAt,
          value: Value(value),
        ));
    return id;
  }

  Stream<List<domain.Campaign>> watchCampaigns() {
    final query = db.select(db.campaigns)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  /// Queues a campaign. Status is `scheduled` — nothing is transmitted, because
  /// no messaging provider is connected. The record is real; the delivery is not.
  /// Creates a discipleship course at one branch.
  Future<String> createCourse({
    required String branchId,
    required String name,
    required String description,
    required int lessons,
    String? facilitatorId,
  }) async {
    final id = await _nextId('crs', db.courses);
    await db.into(db.courses).insert(CoursesCompanion.insert(
          id: id,
          branchId: branchId,
          name: name,
          description: Value(description),
          lessons: Value(lessons),
          facilitatorId: Value(facilitatorId),
        ));
    return id;
  }

  /// Updates a department's schedule and notes.
  Future<void> updateDepartment(
    String departmentId, {
    domain.Weekday? meetingDay,
    String? meetingTime,
    String? notes,
  }) async {
    await (db.update(db.departments)..where((t) => t.id.equals(departmentId)))
        .write(DepartmentsCompanion(
      meetingDay:
          meetingDay == null ? const Value.absent() : Value(meetingDay.name),
      meetingTime:
          meetingTime == null ? const Value.absent() : Value(meetingTime),
      notes: notes == null ? const Value.absent() : Value(notes),
      updatedAt: Value(_now),
    ));
  }

  Future<String> queueCampaign({
    required String branchId,
    required String subject,
    required String body,
    required domain.CampaignChannel channel,
    required String audience,
    required int recipients,
    DateTime? scheduledFor,
  }) async {
    final id = await _nextId('cmp', db.campaigns);
    await db.into(db.campaigns).insert(CampaignsCompanion.insert(
          id: id,
          branchId: branchId,
          subject: subject,
          body: Value(body),
          channel: channel.name,
          status: domain.CampaignStatus.scheduled.name,
          audience: audience,
          recipients: Value(recipients),
          scheduledFor: Value(scheduledFor ?? _now),
        ));
    return id;
  }

  Stream<List<domain.AnnouncementItem>> watchAnnouncements() {
    final query = db.select(db.announcements)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.pinned, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.postedAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Stream<List<domain.Course>> watchCourses() {
    // Newest course first, so a just-created one is at the top.
    final query = db.select(db.courses)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  Stream<List<domain.SmallGroup>> watchSmallGroups() {
    final query = db.select(db.smallGroups)..where((t) => t.deletedAt.isNull());
    return query.watch().asyncMap((rows) async {
      final members = await (db.select(db.members)
            ..where((t) => t.deletedAt.isNull() & t.groupId.isNotNull()))
          .get();
      final counts = <String, int>{};
      for (final m in members) {
        counts[m.groupId!] = (counts[m.groupId!] ?? 0) + 1;
      }
      return rows.map((r) => r.toDomain(counts[r.id] ?? 0)).toList();
    });
  }

  /* ------------------------------------------------------------ settings */

  Stream<Map<String, String>> watchSettings() =>
      db.select(db.settings).watch().map(
            (rows) => {for (final r in rows) r.key: r.value},
          );

  Future<void> saveSetting(String key, String value) =>
      db.writeSetting(key, value);

  Future<void> saveSettings(Map<String, String> values) async {
    await db.batch((b) {
      for (final entry in values.entries) {
        b.insert(
          db.settings,
          SettingsCompanion.insert(key: entry.key, value: entry.value),
          onConflict: DoUpdate((_) => SettingsCompanion(
                value: Value(entry.value),
              )),
        );
      }
    });
  }
}
