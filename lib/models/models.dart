import 'package:flutter/foundation.dart';

/// Domain model for the church management system.
///
/// These classes are the contract between the UI and the (future) API. Every
/// mock dataset in `lib/data` is typed against them, so when the backend lands
/// the only thing that changes is where the data comes from.
///
/// All models are immutable value types. Enums carry a `label` so the UI never
/// has to re-derive display text from a raw identifier.

/* ------------------------------------------------------------------ people */

enum MemberStatus {
  active('Active'),
  inactive('Inactive'),
  visitor('Visitor'),
  transferred('Transferred');

  const MemberStatus(this.label);
  final String label;
}

enum Gender {
  female('Female'),
  male('Male');

  const Gender(this.label);
  final String label;
}

enum MaritalStatus {
  single('Single'),
  married('Married'),
  widowed('Widowed'),
  divorced('Divorced');

  const MaritalStatus(this.label);
  final String label;
}

@immutable
class Address {
  const Address({
    required this.line1,
    required this.city,
    required this.state,
    this.country = 'Ghana',
  });

  final String line1;
  final String city;
  final String state;
  final String country;

  String get short => '$city, $state';
  String get full => '$line1, $city, $state, $country';
}

@immutable
class Member {
  const Member({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dateOfBirth,
    required this.maritalStatus,
    required this.status,
    required this.joinedAt,
    required this.address,
    required this.isBaptized,
    required this.branchId,
    this.departmentIds = const [],
    this.ministryIds = const [],
    this.groupId,
    this.familyId,
    this.notes,
    this.tags = const [],
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final Gender gender;
  final DateTime dateOfBirth;
  final MaritalStatus maritalStatus;
  final MemberStatus status;
  final DateTime joinedAt;
  final Address address;
  final bool isBaptized;

  /// The member's home branch. Every member belongs to exactly one.
  final String branchId;

  /// Departments this member serves in, all at their home branch.
  final List<String> departmentIds;
  final List<String> ministryIds;
  final String? groupId;
  final String? familyId;
  final String? notes;
  final List<String> tags;

  String get fullName => '$firstName $lastName';

  String get initials {
    final f = firstName.isNotEmpty ? firstName[0] : '';
    final l = lastName.isNotEmpty ? lastName[0] : '';
    return '$f$l'.toUpperCase();
  }

  /// Whole years, computed against the dataset's fixed "today".
  int ageAt(DateTime now) {
    var age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }
}

@immutable
class Family {
  const Family({
    required this.id,
    required this.name,
    required this.headMemberId,
    required this.memberIds,
    required this.branchId,
    required this.address,
  });

  final String id;
  final String name;
  final String headMemberId;
  final List<String> memberIds;
  final String branchId;
  final Address address;
}

/* --------------------------------------------------------------- ministries */

enum Weekday {
  sunday('Sunday'),
  monday('Monday'),
  tuesday('Tuesday'),
  wednesday('Wednesday'),
  thursday('Thursday'),
  friday('Friday'),
  saturday('Saturday');

  const Weekday(this.label);
  final String label;
}

/// Visual accent for grouping ministries in the UI.
enum AccentToken { blue, emerald, amber, violet, rose, cyan }

@immutable
class Ministry {
  const Ministry({
    required this.id,
    required this.name,
    required this.description,
    required this.leaderId,
    required this.memberCount,
    required this.meetingDay,
    required this.meetingTime,
    required this.branchId,
    required this.accent,
  });

  final String id;
  final String name;
  final String description;
  final String leaderId;
  final int memberCount;
  final Weekday meetingDay;
  final String meetingTime;
  final String branchId;
  final AccentToken accent;
}

@immutable
class SmallGroup {
  const SmallGroup({
    required this.id,
    required this.name,
    required this.leaderId,
    required this.memberCount,
    required this.location,
    required this.meetingDay,
    required this.meetingTime,
    required this.branchId,
    required this.capacity,
  });

  final String id;
  final String name;
  final String leaderId;
  final int memberCount;
  final String location;
  final Weekday meetingDay;
  final String meetingTime;
  final String branchId;
  final int capacity;

  double get fillRate => capacity == 0 ? 0 : memberCount / capacity;
  int get seatsAvailable => capacity - memberCount;
}

@immutable
class Course {
  const Course({
    required this.id,
    required this.name,
    required this.description,
    required this.lessons,
    required this.enrolled,
    required this.completed,
    required this.branchId,
    required this.facilitatorId,
  });

  final String id;
  final String name;
  final String description;
  final int lessons;
  final int enrolled;
  final int completed;
  final String branchId;
  final String facilitatorId;

  double get completionRate => enrolled == 0 ? 0 : completed / enrolled;
}

/* ------------------------------------------------------------------ events */

enum EventCategory {
  service('Service'),
  rehearsal('Rehearsal'),
  meeting('Meeting'),
  outreach('Outreach'),
  conference('Conference'),
  youth('Youth'),
  prayer('Prayer');

  const EventCategory(this.label);
  final String label;
}

@immutable
class ChurchEvent {
  const ChurchEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.startsAt,
    required this.endsAt,
    required this.location,
    required this.organizerId,
    required this.expectedAttendance,
    required this.registeredCount,
    required this.branchId,
    required this.isRecurring,
  });

  final String id;
  final String title;
  final String description;
  final EventCategory category;
  final DateTime startsAt;
  final DateTime endsAt;
  final String location;
  final String organizerId;
  final int expectedAttendance;
  final int registeredCount;

  /// Branch hosting the event.
  final String branchId;
  final bool isRecurring;

  double get registrationRate =>
      expectedAttendance == 0 ? 0 : registeredCount / expectedAttendance;
}

@immutable
class AnnouncementItem {
  const AnnouncementItem({
    required this.id,
    required this.title,
    required this.body,
    required this.postedAt,
    required this.authorId,
    required this.branchId,
    required this.pinned,
  });

  final String id;
  final String title;
  final String body;
  final DateTime postedAt;
  final String authorId;
  final String branchId;
  final bool pinned;
}

/* -------------------------------------------------------------- attendance */

@immutable
class AttendanceRecord {
  const AttendanceRecord({
    required this.id,
    required this.date,
    required this.serviceName,
    required this.adults,
    required this.children,
    required this.visitors,
    required this.branchId,
    required this.online,
  });

  final String id;
  final DateTime date;
  final String serviceName;
  final int adults;
  final int children;
  final int visitors;
  final String branchId;
  final int online;

  int get inPerson => adults + children + visitors;
  int get total => inPerson + online;
}

/* ------------------------------------------------------------------ giving */

enum GivingFund {
  tithe('Tithe'),
  offering('Offering'),
  building('Building'),
  missions('Missions'),
  welfare('Welfare'),
  special('Special');

  const GivingFund(this.label);
  final String label;
}

enum PaymentMethod {
  cash('Cash'),
  card('Card'),
  transfer('Transfer'),
  mobile('Mobile'),
  cheque('Cheque');

  const PaymentMethod(this.label);
  final String label;
}

enum ExpenseStatus {
  pending('Pending'),
  approved('Approved'),
  paid('Paid'),
  rejected('Rejected');

  const ExpenseStatus(this.label);
  final String label;
}

@immutable
class Donation {
  const Donation({
    required this.id,
    required this.donorName,
    required this.amount,
    required this.fund,
    required this.method,
    required this.date,
    required this.reference,
    required this.branchId,
    required this.isRecurring,
    this.memberId,
  });

  final String id;
  final String donorName;
  final double amount;
  final GivingFund fund;
  final PaymentMethod method;
  final DateTime date;
  final String reference;
  final String branchId;
  final bool isRecurring;
  final String? memberId;
}

@immutable
class Pledge {
  const Pledge({
    required this.id,
    required this.memberId,
    required this.campaign,
    required this.pledged,
    required this.fulfilled,
    required this.dueDate,
  });

  final String id;
  final String memberId;
  final String campaign;
  final double pledged;
  final double fulfilled;
  final DateTime dueDate;

  double get progress => pledged == 0 ? 0 : fulfilled / pledged;
}

@immutable
class ExpenseRecord {
  const ExpenseRecord({
    required this.id,
    required this.category,
    required this.vendor,
    required this.amount,
    required this.date,
    required this.approvedBy,
    required this.branchId,
    required this.status,
  });

  final String id;
  final String category;
  final String vendor;
  final double amount;
  final DateTime date;
  final String approvedBy;
  final String branchId;
  final ExpenseStatus status;
}

/* ------------------------------------------------------- communication */

enum CampaignChannel {
  email('Email'),
  sms('SMS'),
  push('Push'),
  whatsapp('WhatsApp');

  const CampaignChannel(this.label);
  final String label;
}

enum CampaignStatus {
  draft('Draft'),
  scheduled('Scheduled'),
  sent('Sent'),
  failed('Failed');

  const CampaignStatus(this.label);
  final String label;
}

@immutable
class Campaign {
  const Campaign({
    required this.id,
    required this.subject,
    required this.channel,
    required this.status,
    required this.audience,
    required this.branchId,
    required this.recipients,
    this.openRate,
    this.sentAt,
    this.scheduledFor,
  });

  final String id;
  final String subject;
  final CampaignChannel channel;
  final CampaignStatus status;
  final String audience;

  /// Branch that sent it; null-safe 'all branches' campaigns use the HQ id.
  final String branchId;
  final int recipients;
  final int? openRate;
  final DateTime? sentAt;
  final DateTime? scheduledFor;
}

/* --------------------------------------------------------------- volunteers */

enum ServingRole {
  usher('Usher'),
  worship('Worship'),
  media('Media'),
  children('Children'),
  security('Security'),
  hospitality('Hospitality'),
  prayer('Prayer');

  const ServingRole(this.label);
  final String label;
}

enum SlotStatus {
  filled('Filled'),
  open('Open'),
  declined('Declined');

  const SlotStatus(this.label);
  final String label;
}

@immutable
class VolunteerSlot {
  const VolunteerSlot({
    required this.id,
    required this.date,
    required this.serviceName,
    required this.role,
    required this.branchId,
    required this.status,
    this.memberId,
  });

  final String id;
  final DateTime date;
  final String serviceName;
  final ServingRole role;
  final String branchId;
  final SlotStatus status;
  final String? memberId;
}

/* -------------------------------------------------------------- pastoral */

enum CareType {
  prayer('Prayer'),
  counselling('Counselling'),
  hospital('Hospital'),
  bereavement('Bereavement'),
  financial('Financial');

  const CareType(this.label);
  final String label;
}

enum CareStatus {
  open('Open'),
  inProgress('In progress'),
  resolved('Resolved');

  const CareStatus(this.label);
  final String label;
}

enum CarePriority {
  high('High'),
  medium('Medium'),
  low('Low');

  const CarePriority(this.label);
  final String label;
}

@immutable
class CareRequest {
  const CareRequest({
    required this.id,
    required this.memberId,
    required this.type,
    required this.summary,
    required this.status,
    required this.priority,
    required this.branchId,
    required this.createdAt,
    this.assignedToId,
  });

  final String id;
  final String memberId;
  final CareType type;
  final String summary;
  final CareStatus status;
  final CarePriority priority;
  final String branchId;
  final DateTime createdAt;
  final String? assignedToId;
}

/* -------------------------------------------------------------- assets */

enum AssetCondition {
  brandNew('New'),
  good('Good'),
  fair('Fair'),
  needsRepair('Needs repair');

  const AssetCondition(this.label);
  final String label;
}

@immutable
class AssetItem {
  const AssetItem({
    required this.id,
    required this.name,
    required this.category,
    required this.serial,
    required this.condition,
    required this.location,
    required this.purchasedAt,
    required this.branchId,
    required this.value,
  });

  final String id;
  final String name;
  final String category;
  final String serial;
  final AssetCondition condition;
  final String location;
  final DateTime purchasedAt;
  final String branchId;
  final double value;
}

/* -------------------------------------------------------------- access */

/// Roles are ordered from most to least privileged. The order matters: several
/// checks use `index` to compare seniority, so never reorder casually.
///
/// [scope] is the role's *default* reach. Seeing across branches is a separate,
/// grantable permission ([StaffUser.canSeeAllBranches]) rather than something
/// baked into the role — so a Senior Pastor can be given church-wide sight, or
/// kept to their own branch, without inventing a new role for each case.
///
/// Only [superAdmin] holds that permission by default.
enum UserRole {
  superAdmin('Super Admin', RoleScope.allBranches),
  seniorPastor('Senior Pastor', RoleScope.ownBranch),
  hqFinance('HQ Finance', RoleScope.ownBranch),
  branchPastor('Branch Pastor', RoleScope.ownBranch),
  assistantPastor('Assistant Pastor', RoleScope.ownBranch),
  branchAdmin('Branch Admin', RoleScope.ownBranch),
  branchFinance('Branch Finance', RoleScope.ownBranch),
  departmentHead('Department Head', RoleScope.ownDepartment),
  volunteer('Volunteer', RoleScope.ownDepartment),
  member('Member', RoleScope.self);

  const UserRole(this.label, this.scope);
  final String label;

  /// The reach this role gets when no cross-branch permission is granted.
  final RoleScope scope;

  /// Whether accounts with this role see every branch unless told otherwise.
  ///
  /// Super Admin alone: the church's data is deliberately siloed per branch, and
  /// anything wider has to be granted explicitly and visibly.
  bool get grantsAllBranchesByDefault => this == UserRole.superAdmin;

  /// True when this role may be *given* cross-branch sight at all.
  ///
  /// Department-level and self-scoped roles are excluded: granting a volunteer
  /// church-wide visibility would be a mistake, not a policy choice.
  bool get mayBeGrantedAllBranches =>
      scope == RoleScope.ownBranch || scope == RoleScope.allBranches;

  /// True when the role leads a branch (used for "who runs this branch" lookups).
  bool get leadsBranch =>
      this == UserRole.branchPastor || this == UserRole.assistantPastor;
}

/// How far a role's authority reaches. Combined with [PermissionLevel] this
/// gives the two-dimensional model: *what* you may do × *whose data* you see.
enum RoleScope {
  allBranches('All branches'),
  ownBranch('Own branch'),
  ownDepartment('Own department'),
  self('Self only');

  const RoleScope(this.label);
  final String label;
}

enum AccountStatus {
  active('Active'),
  invited('Invited'),
  suspended('Suspended');

  const AccountStatus(this.label);
  final String label;
}

enum PermissionLevel {
  full('Full'),
  read('Read'),
  none('None');

  const PermissionLevel(this.label);
  final String label;

  bool get canRead => this != PermissionLevel.none;
  bool get canWrite => this == PermissionLevel.full;
}

@immutable
class StaffUser {
  const StaffUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.lastActiveAt,
    required this.status,
    this.branchId,
    this.departmentId,
    this.branchAccessGrant,
  });

  final String id;
  final String name;
  final String email;
  final UserRole role;
  final DateTime lastActiveAt;
  final AccountStatus status;

  /// Null for church-wide roles, which are not tied to a single branch.
  final String? branchId;

  /// Set for department heads and volunteers.
  final String? departmentId;

  /// Explicit grant, when one has been made. Null means "use the role default",
  /// which is church-wide only for Super Admin.
  final bool? branchAccessGrant;

  /// Whether this account may see data from branches other than its own.
  ///
  /// This is the single question the whole app asks before showing anything
  /// cross-branch. It is a *permission on the account*, not a property of the
  /// role, so it can be granted or revoked per person.
  bool get canSeeAllBranches =>
      branchAccessGrant ?? role.grantsAllBranchesByDefault;

  /// True when the grant was set explicitly rather than inherited — used by the
  /// access screen to show which accounts were deliberately given wider sight.
  bool get hasExplicitBranchGrant => branchAccessGrant != null;

  /// The reach actually in force, once the grant is taken into account.
  RoleScope get effectiveScope =>
      canSeeAllBranches ? RoleScope.allBranches : role.scope;

  String get initials => name
      .split(' ')
      .where((p) => p.isNotEmpty)
      .take(2)
      .map((p) => p[0].toUpperCase())
      .join();
}

@immutable
class ModulePermission {
  const ModulePermission({required this.module, required this.roles});

  final String module;
  final Map<UserRole, PermissionLevel> roles;

  PermissionLevel levelFor(UserRole role) =>
      roles[role] ?? PermissionLevel.none;
}

/* ------------------------------------------------------------- branches */

enum BranchStatus {
  active('Active'),
  planting('Church plant'),
  dormant('Dormant');

  const BranchStatus(this.label);
  final String label;
}

/// A campus of the church. The headquarters is itself a branch, flagged with
/// [isHeadquarters], so every query can treat branches uniformly rather than
/// special-casing HQ.
@immutable
class Branch {
  const Branch({
    required this.id,
    required this.name,
    required this.code,
    required this.address,
    required this.status,
    required this.establishedAt,
    required this.pastorId,
    required this.accent,
    this.assistantPastorId,
    this.isHeadquarters = false,
  });

  final String id;
  final String name;

  /// Short code used in tables and ids, e.g. "HQ", "IKJ".
  final String code;
  final Address address;
  final BranchStatus status;
  final DateTime establishedAt;

  /// The branch pastor — always a member of this branch.
  final String pastorId;
  final String? assistantPastorId;
  final AccentToken accent;
  final bool isHeadquarters;
}

/* ---------------------------------------------------------- departments */

/// The shared catalogue of department types. HQ defines these; each branch runs
/// its own instance of the ones it needs, which is what makes cross-branch
/// reporting possible — "Youth" means the same thing everywhere.
@immutable
class DepartmentType {
  const DepartmentType({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.accent,
    this.isCore = false,
    this.ageRange,
  });

  final String id;
  final String name;
  final String description;

  /// Icon codepoint name resolved by the UI; kept as data so the catalogue
  /// stays serialisable when it moves to the database.
  final String icon;
  final AccentToken accent;

  /// Core departments (Youth, Children) are expected at every branch.
  final bool isCore;

  /// Set for age-gated departments, used to suggest eligible members.
  final ({int min, int max})? ageRange;
}

/// A department as it actually runs at one branch.
@immutable
class Department {
  const Department({
    required this.id,
    required this.typeId,
    required this.branchId,
    required this.headId,
    required this.memberIds,
    required this.meetingDay,
    required this.meetingTime,
    this.assistantHeadId,
    this.notes,
  });

  final String id;
  final String typeId;
  final String branchId;

  /// The department head — a member of the same branch.
  final String headId;
  final String? assistantHeadId;
  final List<String> memberIds;
  final Weekday meetingDay;
  final String meetingTime;
  final String? notes;

  int get memberCount => memberIds.length;
}

/* ------------------------------------------------------------ primitives */

/// A single point on a time-series chart. [compare] powers the second series.
@immutable
class TrendPoint {
  const TrendPoint({required this.label, required this.value, this.compare});

  final String label;
  final double value;
  final double? compare;
}

/// A labelled magnitude — used by bar charts, donuts and funnels.
@immutable
class CategoryPoint {
  const CategoryPoint({required this.label, required this.value});

  final String label;
  final double value;
}

@immutable
class KpiStat {
  const KpiStat({
    required this.id,
    required this.label,
    required this.value,
    required this.hint,
    this.delta,
    this.spark = const [],
    this.invertDelta = false,
  });

  final String id;
  final String label;
  final String value;

  /// Percentage change against the previous period. Null when there is no
  /// history to compare against, which is the case on a fresh install — the
  /// tile then shows the figure without a trend rather than inventing one.
  final double? delta;
  final String hint;
  final List<double> spark;

  /// Set when a decrease is the good outcome (e.g. open care requests).
  final bool invertDelta;
}

enum ActivityKind { member, donation, event, care, message, volunteer }

@immutable
class ActivityEntry {
  const ActivityEntry({
    required this.id,
    required this.kind,
    required this.actor,
    required this.action,
    required this.target,
    required this.at,
  });

  final String id;
  final ActivityKind kind;
  final String actor;
  final String action;
  final String target;
  final DateTime at;
}
