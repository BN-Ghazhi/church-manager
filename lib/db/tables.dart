import 'package:drift/drift.dart';

/// The database schema.
///
/// One table per domain entity, mirroring `lib/models/models.dart`. Every
/// branch-scoped table carries `branchId` as a real foreign key, so the
/// database itself refuses to hold a member who belongs to no branch or a
/// department at a branch that does not exist.
///
/// Conventions:
///   * ids are text, matching the existing `brn-0001` style, so seeded data and
///     user-created data are indistinguishable
///   * timestamps are stored as UTC `DateTime`
///   * enums are stored by name (`TextColumn`), not index, so reordering an
///     enum in Dart can never silently re-label existing rows
///   * `deletedAt` marks soft deletes — church records should not vanish

/// Common columns every table shares.
mixin _Timestamps on Table {
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Set instead of deleting the row. All queries filter these out.
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

@DataClassName('BranchRow')
class Branches extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get code => text()();
  TextColumn get addressLine => text()();
  TextColumn get city => text()();
  TextColumn get state => text()();
  TextColumn get country => text().withDefault(const Constant('Ghana'))();
  TextColumn get status => text()();
  DateTimeColumn get establishedAt => dateTime()();

  /// Nullable so a branch can be created before its pastor record exists.
  TextColumn get pastorId => text().nullable()();
  TextColumn get assistantPastorId => text().nullable()();
  TextColumn get accent => text()();
  BoolColumn get isHeadquarters =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MemberRow')
class Members extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get email => text().withDefault(const Constant(''))();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get gender => text()();
  DateTimeColumn get dateOfBirth => dateTime()();
  TextColumn get maritalStatus => text()();
  TextColumn get status => text()();
  DateTimeColumn get joinedAt => dateTime()();
  TextColumn get addressLine => text().withDefault(const Constant(''))();
  TextColumn get city => text().withDefault(const Constant(''))();
  TextColumn get state => text().withDefault(const Constant(''))();
  TextColumn get country => text().withDefault(const Constant('Ghana'))();
  BoolColumn get isBaptized => boolean().withDefault(const Constant(false))();

  /// Home branch — every member belongs to exactly one.
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get groupId => text().nullable()();
  TextColumn get familyId => text().nullable()();
  TextColumn get notes => text().nullable()();

  /// Comma-separated; small enough not to warrant a join table.
  TextColumn get tags => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

/// The church-wide catalogue of department types.
@DataClassName('DepartmentTypeRow')
class DepartmentTypes extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get icon => text().withDefault(const Constant('groups'))();
  TextColumn get accent => text()();
  BoolColumn get isCore => boolean().withDefault(const Constant(false))();
  IntColumn get minAge => integer().nullable()();
  IntColumn get maxAge => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// A department as it runs at one branch.
@DataClassName('DepartmentRow')
class Departments extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get typeId => text().references(DepartmentTypes, #id)();
  TextColumn get branchId => text().references(Branches, #id)();
  @ReferenceName('headedDepartments')
  TextColumn get headId => text().nullable().references(Members, #id)();

  @ReferenceName('assistedDepartments')
  TextColumn get assistantHeadId =>
      text().nullable().references(Members, #id)();
  TextColumn get meetingDay => text()();
  TextColumn get meetingTime => text()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Department membership. A join table rather than a list column, because it
/// is queried from both directions and must stay referentially sound.
@DataClassName('DepartmentMemberRow')
class DepartmentMembers extends Table {
  TextColumn get departmentId => text().references(Departments, #id)();
  TextColumn get memberId => text().references(Members, #id)();
  DateTimeColumn get joinedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {departmentId, memberId};
}

/// Sign-in accounts. Separate from [Members]: not every member has a login,
/// and a login may belong to staff who are not on the member roll.
@DataClassName('UserAccountRow')
class UserAccounts extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// The sign-in name. Lower-cased at write time, and unique.
  ///
  /// A username rather than an email address: a church office is not a place
  /// where everyone has a work email, and asking for one to log in excludes the
  /// people most likely to be using this. The consequence is that there is no
  /// address to send a password reset to, so a Super Admin resets passwords
  /// from Roles & Access instead.
  TextColumn get username => text().unique()();

  /// PBKDF2-derived, never the plain password. See `lib/db/password.dart`.
  TextColumn get passwordHash => text()();
  TextColumn get passwordSalt => text()();
  TextColumn get role => text()();
  TextColumn get status => text()();

  /// Null for church-wide roles that span every branch.
  TextColumn get branchId => text().nullable().references(Branches, #id)();

  /// Set for department heads and volunteers.
  TextColumn get departmentId =>
      text().nullable().references(Departments, #id)();

  /// Links the account to a member record where one exists.
  TextColumn get memberId => text().nullable().references(Members, #id)();

  /// Cross-branch visibility, granted per account.
  ///
  /// Null means "inherit the role default", which is church-wide only for
  /// Super Admin. Storing the grant here rather than deriving it from the role
  /// is what lets one Senior Pastor see every branch while another does not.
  BoolColumn get canSeeAllBranches => boolean().nullable()();
  DateTimeColumn get lastActiveAt => dateTime().nullable()();

  /// Forces a password change on next sign-in.
  BoolColumn get mustChangePassword =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AttendanceRow')
class AttendanceRecords extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get serviceName => text()();
  IntColumn get adults => integer().withDefault(const Constant(0))();
  IntColumn get children => integer().withDefault(const Constant(0))();
  IntColumn get visitors => integer().withDefault(const Constant(0))();
  IntColumn get online => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Individual member check-ins against a service record.
@DataClassName('CheckInRow')
class CheckIns extends Table {
  TextColumn get attendanceId => text().references(AttendanceRecords, #id)();
  TextColumn get memberId => text().references(Members, #id)();
  DateTimeColumn get checkedInAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {attendanceId, memberId};
}

@DataClassName('DonationRow')
class Donations extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get memberId => text().nullable().references(Members, #id)();
  TextColumn get donorName => text()();
  RealColumn get amount => real()();
  TextColumn get fund => text()();
  TextColumn get method => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get reference => text()();
  BoolColumn get isRecurring => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ExpenseRow')
class Expenses extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get category => text()();
  TextColumn get vendor => text()();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get approvedBy => text().nullable()();
  TextColumn get status => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PledgeRow')
class Pledges extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get memberId => text().references(Members, #id)();
  TextColumn get campaign => text()();
  RealColumn get pledged => real()();
  RealColumn get fulfilled => real().withDefault(const Constant(0))();
  DateTimeColumn get dueDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('EventRow')
class Events extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get title => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get category => text()();
  DateTimeColumn get startsAt => dateTime()();
  DateTimeColumn get endsAt => dateTime()();
  TextColumn get location => text().withDefault(const Constant(''))();
  TextColumn get organizerId => text().nullable()();
  IntColumn get expectedAttendance => integer().withDefault(const Constant(0))();
  IntColumn get registeredCount => integer().withDefault(const Constant(0))();
  BoolColumn get isRecurring => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CareRequestRow')
class CareRequests extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get memberId => text().references(Members, #id)();
  TextColumn get type => text()();
  TextColumn get summary => text()();
  TextColumn get status => text()();
  TextColumn get priority => text()();
  TextColumn get assignedToId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('VolunteerSlotRow')
class VolunteerSlots extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get serviceName => text()();
  TextColumn get role => text()();
  TextColumn get memberId => text().nullable().references(Members, #id)();
  TextColumn get status => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AssetRow')
class Assets extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get serial => text().withDefault(const Constant(''))();
  TextColumn get condition => text()();
  TextColumn get location => text().withDefault(const Constant(''))();
  DateTimeColumn get purchasedAt => dateTime()();
  RealColumn get value => real().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CampaignRow')
class Campaigns extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get subject => text()();
  TextColumn get body => text().withDefault(const Constant(''))();
  TextColumn get channel => text()();
  TextColumn get status => text()();
  TextColumn get audience => text()();
  IntColumn get recipients => integer().withDefault(const Constant(0))();
  IntColumn get openRate => integer().nullable()();
  DateTimeColumn get sentAt => dateTime().nullable()();
  DateTimeColumn get scheduledFor => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AnnouncementRow')
class Announcements extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get authorId => text().nullable()();
  DateTimeColumn get postedAt => dateTime()();
  BoolColumn get pinned => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CourseRow')
class Courses extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get lessons => integer().withDefault(const Constant(0))();
  IntColumn get enrolled => integer().withDefault(const Constant(0))();
  IntColumn get completed => integer().withDefault(const Constant(0))();
  TextColumn get facilitatorId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SmallGroupRow')
class SmallGroups extends Table with _Timestamps {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get name => text()();
  TextColumn get leaderId => text().nullable()();
  TextColumn get location => text().withDefault(const Constant(''))();
  TextColumn get meetingDay => text()();
  TextColumn get meetingTime => text()();
  IntColumn get capacity => integer().withDefault(const Constant(30))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Key/value store for church profile and preference toggles, so Settings
/// persists without a migration every time a new switch is added.
@DataClassName('SettingRow')
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
