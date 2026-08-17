import '../models/models.dart';
import 'branches_data.dart';
import 'members_data.dart';
import 'seed.dart';

final List<Campaign> campaigns = [
  Campaign(
    id: Seed.id('cmp', 0),
    subject: 'Sunday service reminder — two services',
    channel: CampaignChannel.sms,
    status: CampaignStatus.sent,
    audience: 'All members',
    recipients: 842,
    branchId: hqBranchId,
    openRate: 96,
    sentAt: atHour(-2, 8),
  ),
  Campaign(
    id: Seed.id('cmp', 1),
    subject: 'August newsletter: what God is doing',
    channel: CampaignChannel.email,
    status: CampaignStatus.sent,
    audience: 'All members',
    recipients: 796,
    branchId: hqBranchId,
    openRate: 58,
    sentAt: atHour(-6, 12),
  ),
  Campaign(
    id: Seed.id('cmp', 2),
    subject: 'Choir rehearsal moved to 6:30 PM',
    channel: CampaignChannel.whatsapp,
    status: CampaignStatus.sent,
    audience: 'Worship & Choir',
    recipients: 38,
    branchId: hqBranchId,
    openRate: 92,
    sentAt: atHour(-1, 15),
  ),
  Campaign(
    id: Seed.id('cmp', 3),
    subject: 'Leadership conference — early registration',
    channel: CampaignChannel.email,
    status: CampaignStatus.scheduled,
    audience: 'Leaders',
    recipients: 124,
    branchId: hqBranchId,
    scheduledFor: atHour(2, 9),
  ),
  Campaign(
    id: Seed.id('cmp', 4),
    subject: 'First-timer follow-up sequence',
    channel: CampaignChannel.sms,
    status: CampaignStatus.scheduled,
    audience: 'Visitors (last 30 days)',
    recipients: 47,
    branchId: hqBranchId,
    scheduledFor: atHour(1, 10),
  ),
  Campaign(
    id: Seed.id('cmp', 5),
    subject: 'Welfare support application window',
    channel: CampaignChannel.push,
    status: CampaignStatus.draft,
    audience: 'All members',
    recipients: 0,
    branchId: hqBranchId,
  ),
  Campaign(
    id: Seed.id('cmp', 6),
    subject: 'Vigil transport arrangements',
    channel: CampaignChannel.whatsapp,
    status: CampaignStatus.failed,
    audience: 'Prayer & Intercession',
    recipients: 27,
    branchId: hqBranchId,
    sentAt: atHour(-4, 19),
  ),
];

const _careSeeds = [
  [CareType.hospital, 'Admitted at Korle Bu for surgery; requests pastoral visit.'],
  [CareType.prayer, 'Praying for job placement after six months of searching.'],
  [CareType.counselling, 'Marital counselling requested — third session.'],
  [CareType.bereavement, 'Lost a parent last week; family needs support.'],
  [CareType.financial, 'School fees assistance requested for two children.'],
  [CareType.prayer, 'Health concerns following recent diagnosis.'],
  [CareType.counselling, 'Career and calling clarity conversation.'],
  [CareType.hospital, 'Post-natal recovery; meals rota being arranged.'],
];

const _careStatuses = [
  CareStatus.open, CareStatus.open, CareStatus.inProgress,
  CareStatus.resolved, CareStatus.resolved,
];

const _carePriorities = [
  CarePriority.high, CarePriority.medium, CarePriority.medium, CarePriority.low,
];

final List<CareRequest> careRequests = List.generate(48, (i) {
  final seed = _careSeeds[i % _careSeeds.length];
  return CareRequest(
    id: Seed.id('care', i),
    memberId: members[(i * 11 + 4) % members.length].id,
    type: seed[0] as CareType,
    summary: seed[1] as String,
    status: Seed.pick(_careStatuses, i),
    priority: Seed.pick(_carePriorities, i * 3),
    branchId: members[(i * 11 + 4) % members.length].branchId,
    // Hour 7 is before the 09:00 demo "now", so a same-day offset still reads
    // as the past rather than rendering as a future time.
    createdAt: atHour(-Seed.intIn(i * 7, 0, 40), 7),
    assignedToId: i % 4 == 0 ? null : members[(i * 3) % 10].id,
  );
});

const _assetSeeds = [
  ['Yamaha Digital Mixer MG16XU', 'Audio', 890000.0],
  ['Shure SM58 Microphone (×8)', 'Audio', 420000.0],
  ['Canon EOS R6 Camera Body', 'Video', 2400000.0],
  ['Epson Projector EB-L200', 'Video', 1150000.0],
  ['Church Bus — Toyota Hiace', 'Vehicle', 18500000.0],
  ['Generator 60 KVA Perkins', 'Power', 7200000.0],
  ['Plastic Chairs (500 units)', 'Furniture', 1500000.0],
  ['Grand Piano — Kawai', 'Instrument', 5600000.0],
  ['Drum Kit — Pearl Export', 'Instrument', 980000.0],
  ['Inverter & Battery Bank', 'Power', 3100000.0],
  ['Air Conditioners (×6)', 'Facility', 2700000.0],
  ['Laptop — MacBook Pro M3', 'IT', 3400000.0],
  ['Livestream Encoder', 'Video', 760000.0],
  ['Stage Lighting Rig', 'Video', 1900000.0],
];

const _conditions = [
  AssetCondition.good, AssetCondition.good, AssetCondition.brandNew,
  AssetCondition.fair, AssetCondition.needsRepair,
];

const _locations = [
  'Main Auditorium', 'Store Room', 'Studio', 'Car Park', "Children's Hall",
];

final List<AssetItem> assets = List.generate(_assetSeeds.length, (i) {
  final s = _assetSeeds[i];
  return AssetItem(
    id: Seed.id('ast', i),
    name: s[0] as String,
    category: s[1] as String,
    serial: 'SN-${48210 + i * 373}',
    condition: Seed.pick(_conditions, i),
    location: Seed.pick(_locations, i),
    purchasedAt: dayOnly(-Seed.intIn(i * 13, 120, 1800)),
    branchId: branchIdAt(i % branchSeeds.length),
    value: s[2] as double,
  );
});

class _StaffSeed {
  const _StaffSeed(this.name, this.role, this.branchIndex, [this.deptIndex]);

  final String name;
  final UserRole role;

  /// Null for church-wide roles that are not tied to a single branch.
  final int? branchIndex;
  final int? deptIndex;
}

const _staffSeeds = <_StaffSeed>[
  // Church-wide
  _StaffSeed('Grace Ansah', UserRole.superAdmin, null),
  _StaffSeed('Pastor Samuel Mensah', UserRole.seniorPastor, null),
  _StaffSeed('Daniel Boateng', UserRole.hqFinance, null),
  // Headquarters
  _StaffSeed('Michael Owusu', UserRole.branchPastor, 0),
  _StaffSeed('Esther Asante', UserRole.assistantPastor, 0),
  _StaffSeed('Ruth Quartey', UserRole.branchAdmin, 0),
  _StaffSeed('Joshua Adjei', UserRole.departmentHead, 0, 0),
  // Tema
  _StaffSeed('Peter Osei', UserRole.branchPastor, 1),
  _StaffSeed('Naomi Amoah', UserRole.branchFinance, 1),
  _StaffSeed('Comfort Appiah', UserRole.departmentHead, 1, 1),
  // Kumasi
  _StaffSeed('Kwame Nkrumah', UserRole.branchPastor, 2),
  _StaffSeed('Deborah Lartey', UserRole.branchAdmin, 2),
  // Takoradi
  _StaffSeed('Gideon Yeboah', UserRole.branchPastor, 3),
  _StaffSeed('Hannah Ofori', UserRole.volunteer, 3, 0),
  // Tamale
  _StaffSeed('Isaac Darko', UserRole.branchPastor, 4),
  // Cape Coast (church plant)
  _StaffSeed('Mariama Abdulai', UserRole.branchPastor, 5),
];

const _accountStatuses = [
  AccountStatus.active, AccountStatus.active, AccountStatus.active,
  AccountStatus.active, AccountStatus.invited, AccountStatus.suspended,
];

final List<StaffUser> staffUsers = List.generate(_staffSeeds.length, (i) {
  final seed = _staffSeeds[i];
  final surname = seed.name.split(' ').last.toLowerCase();
  final branchId =
      seed.branchIndex == null ? null : branchIdAt(seed.branchIndex!);

  return StaffUser(
    id: Seed.id('usr', i),
    name: seed.name,
    email: '$surname@gracechapel.org',
    role: seed.role,
    lastActiveAt: atHour(-Seed.intIn(i * 5, 0, 9), 7),
    status: Seed.pick(_accountStatuses, i),
    branchId: branchId,
    departmentId: seed.deptIndex == null || branchId == null
        ? null
        : Seed.id('dep', seed.deptIndex!),
  );
});

/// Which modules each role can reach.
///
/// This is *what* a role may do. How far it reaches — one branch or all of
/// them — is [UserRole.scope]. Both are enforced together; see
/// `lib/providers/permissions.dart`.
const List<ModulePermission> permissionMatrix = [
  ModulePermission(module: 'Branches', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.full,
    UserRole.hqFinance: PermissionLevel.read,
    UserRole.branchPastor: PermissionLevel.read,
    UserRole.assistantPastor: PermissionLevel.read,
    UserRole.branchAdmin: PermissionLevel.read,
    UserRole.branchFinance: PermissionLevel.none,
    UserRole.departmentHead: PermissionLevel.none,
    UserRole.volunteer: PermissionLevel.none,
    UserRole.member: PermissionLevel.none,
  }),
  ModulePermission(module: 'Members', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.full,
    UserRole.hqFinance: PermissionLevel.read,
    UserRole.branchPastor: PermissionLevel.full,
    UserRole.assistantPastor: PermissionLevel.full,
    UserRole.branchAdmin: PermissionLevel.full,
    UserRole.branchFinance: PermissionLevel.read,
    UserRole.departmentHead: PermissionLevel.read,
    UserRole.volunteer: PermissionLevel.none,
    UserRole.member: PermissionLevel.none,
  }),
  ModulePermission(module: 'Departments', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.full,
    UserRole.hqFinance: PermissionLevel.none,
    UserRole.branchPastor: PermissionLevel.full,
    UserRole.assistantPastor: PermissionLevel.full,
    UserRole.branchAdmin: PermissionLevel.full,
    UserRole.branchFinance: PermissionLevel.none,
    UserRole.departmentHead: PermissionLevel.full,
    UserRole.volunteer: PermissionLevel.read,
    UserRole.member: PermissionLevel.read,
  }),
  ModulePermission(module: 'Attendance', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.full,
    UserRole.hqFinance: PermissionLevel.none,
    UserRole.branchPastor: PermissionLevel.full,
    UserRole.assistantPastor: PermissionLevel.full,
    UserRole.branchAdmin: PermissionLevel.full,
    UserRole.branchFinance: PermissionLevel.none,
    UserRole.departmentHead: PermissionLevel.full,
    UserRole.volunteer: PermissionLevel.read,
    UserRole.member: PermissionLevel.none,
  }),
  ModulePermission(module: 'Giving & Finance', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.read,
    UserRole.hqFinance: PermissionLevel.full,
    UserRole.branchPastor: PermissionLevel.read,
    UserRole.assistantPastor: PermissionLevel.none,
    UserRole.branchAdmin: PermissionLevel.none,
    UserRole.branchFinance: PermissionLevel.full,
    UserRole.departmentHead: PermissionLevel.none,
    UserRole.volunteer: PermissionLevel.none,
    UserRole.member: PermissionLevel.none,
  }),
  ModulePermission(module: 'Events', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.full,
    UserRole.hqFinance: PermissionLevel.none,
    UserRole.branchPastor: PermissionLevel.full,
    UserRole.assistantPastor: PermissionLevel.full,
    UserRole.branchAdmin: PermissionLevel.full,
    UserRole.branchFinance: PermissionLevel.none,
    UserRole.departmentHead: PermissionLevel.full,
    UserRole.volunteer: PermissionLevel.read,
    UserRole.member: PermissionLevel.read,
  }),
  ModulePermission(module: 'Communication', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.full,
    UserRole.hqFinance: PermissionLevel.none,
    UserRole.branchPastor: PermissionLevel.full,
    UserRole.assistantPastor: PermissionLevel.full,
    UserRole.branchAdmin: PermissionLevel.full,
    UserRole.branchFinance: PermissionLevel.none,
    UserRole.departmentHead: PermissionLevel.read,
    UserRole.volunteer: PermissionLevel.none,
    UserRole.member: PermissionLevel.none,
  }),
  ModulePermission(module: 'Pastoral Care', roles: {
    UserRole.superAdmin: PermissionLevel.read,
    UserRole.seniorPastor: PermissionLevel.full,
    UserRole.hqFinance: PermissionLevel.none,
    UserRole.branchPastor: PermissionLevel.full,
    UserRole.assistantPastor: PermissionLevel.full,
    UserRole.branchAdmin: PermissionLevel.read,
    UserRole.branchFinance: PermissionLevel.none,
    UserRole.departmentHead: PermissionLevel.none,
    UserRole.volunteer: PermissionLevel.none,
    UserRole.member: PermissionLevel.none,
  }),
  ModulePermission(module: 'Volunteers', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.read,
    UserRole.hqFinance: PermissionLevel.none,
    UserRole.branchPastor: PermissionLevel.full,
    UserRole.assistantPastor: PermissionLevel.full,
    UserRole.branchAdmin: PermissionLevel.full,
    UserRole.branchFinance: PermissionLevel.none,
    UserRole.departmentHead: PermissionLevel.full,
    UserRole.volunteer: PermissionLevel.read,
    UserRole.member: PermissionLevel.none,
  }),
  ModulePermission(module: 'Discipleship', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.full,
    UserRole.hqFinance: PermissionLevel.none,
    UserRole.branchPastor: PermissionLevel.full,
    UserRole.assistantPastor: PermissionLevel.full,
    UserRole.branchAdmin: PermissionLevel.read,
    UserRole.branchFinance: PermissionLevel.none,
    UserRole.departmentHead: PermissionLevel.read,
    UserRole.volunteer: PermissionLevel.read,
    UserRole.member: PermissionLevel.read,
  }),
  ModulePermission(module: 'Assets', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.read,
    UserRole.hqFinance: PermissionLevel.read,
    UserRole.branchPastor: PermissionLevel.full,
    UserRole.assistantPastor: PermissionLevel.read,
    UserRole.branchAdmin: PermissionLevel.full,
    UserRole.branchFinance: PermissionLevel.read,
    UserRole.departmentHead: PermissionLevel.none,
    UserRole.volunteer: PermissionLevel.none,
    UserRole.member: PermissionLevel.none,
  }),
  ModulePermission(module: 'Reports', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.full,
    UserRole.hqFinance: PermissionLevel.full,
    UserRole.branchPastor: PermissionLevel.read,
    UserRole.assistantPastor: PermissionLevel.read,
    UserRole.branchAdmin: PermissionLevel.read,
    UserRole.branchFinance: PermissionLevel.read,
    UserRole.departmentHead: PermissionLevel.none,
    UserRole.volunteer: PermissionLevel.none,
    UserRole.member: PermissionLevel.none,
  }),
  ModulePermission(module: 'Roles & Access', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.read,
    UserRole.hqFinance: PermissionLevel.none,
    UserRole.branchPastor: PermissionLevel.read,
    UserRole.assistantPastor: PermissionLevel.none,
    UserRole.branchAdmin: PermissionLevel.read,
    UserRole.branchFinance: PermissionLevel.none,
    UserRole.departmentHead: PermissionLevel.none,
    UserRole.volunteer: PermissionLevel.none,
    UserRole.member: PermissionLevel.none,
  }),
  ModulePermission(module: 'Settings', roles: {
    UserRole.superAdmin: PermissionLevel.full,
    UserRole.seniorPastor: PermissionLevel.read,
    UserRole.hqFinance: PermissionLevel.none,
    UserRole.branchPastor: PermissionLevel.read,
    UserRole.assistantPastor: PermissionLevel.none,
    UserRole.branchAdmin: PermissionLevel.read,
    UserRole.branchFinance: PermissionLevel.none,
    UserRole.departmentHead: PermissionLevel.none,
    UserRole.volunteer: PermissionLevel.none,
    UserRole.member: PermissionLevel.none,
  }),
];
