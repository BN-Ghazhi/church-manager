import '../models/models.dart';
import 'branches_data.dart';
import 'members_data.dart';
import 'seed.dart';

/// The branches, with pastors resolved from the member roll.
///
/// Built here rather than in `branches_data.dart` because it depends on
/// `members`, and `members` depends on the branch *ids* — splitting the seeds
/// from the resolved records keeps that dependency one-directional.
final List<Branch> branches = List.generate(branchSeeds.length, (i) {
  final seed = branchSeeds[i];
  final id = branchIdAt(i);
  final roll = membersOfBranch(id);

  // The two longest-standing members of a branch lead it — deterministic, and
  // it guarantees the pastor is always someone who belongs to that branch.
  final byTenure = [...roll]..sort((a, b) => a.joinedAt.compareTo(b.joinedAt));

  return Branch(
    id: id,
    name: seed.name,
    code: seed.code,
    address: Address(line1: seed.line1, city: seed.city, state: seed.state),
    status: seed.status,
    establishedAt: DateTime.utc(seed.year, Seed.intIn(i * 7, 1, 12), 1),
    pastorId: byTenure.isNotEmpty ? byTenure.first.id : members.first.id,
    assistantPastorId: byTenure.length > 1 ? byTenure[1].id : null,
    accent: seed.accent,
    isHeadquarters: seed.isHq,
  );
});

final Map<String, Branch> _branchById = {for (final b in branches) b.id: b};

Branch? branchById(String id) => _branchById[id];

String branchName(String? id) =>
    id == null ? 'All branches' : (_branchById[id]?.name ?? 'Unknown branch');

String branchCode(String? id) =>
    id == null ? 'ALL' : (_branchById[id]?.code ?? '—');

/* ---------------------------------------------------------- catalogue */

/// The shared department catalogue. HQ owns this list; every branch runs its
/// own instance of the types it needs, which is what makes "Youth" comparable
/// across branches in reports.
const List<DepartmentType> departmentTypes = [
  DepartmentType(
    id: 'dpt-youth',
    name: 'Youth Ministry',
    description:
        'Teenagers and young adults — weekly fellowship, mentoring and outreach.',
    icon: 'youth',
    accent: AccentToken.violet,
    isCore: true,
    ageRange: (min: 13, max: 30),
  ),
  DepartmentType(
    id: 'dpt-children',
    name: "Children's Department",
    description:
        'Age-graded Sunday school, holiday clubs and child safeguarding.',
    icon: 'children',
    accent: AccentToken.amber,
    isCore: true,
    ageRange: (min: 0, max: 12),
  ),
  DepartmentType(
    id: 'dpt-worship',
    name: 'Worship & Choir',
    description: 'Leads congregational worship and midweek rehearsals.',
    icon: 'worship',
    accent: AccentToken.rose,
    isCore: true,
  ),
  DepartmentType(
    id: 'dpt-ushering',
    name: 'Ushering & Protocol',
    description: 'Welcomes and seats the congregation; manages offering flow.',
    icon: 'ushering',
    accent: AccentToken.blue,
    isCore: true,
  ),
  DepartmentType(
    id: 'dpt-media',
    name: 'Media & Technical',
    description: 'Livestream, sound, lighting, slides and recordings.',
    icon: 'media',
    accent: AccentToken.cyan,
  ),
  DepartmentType(
    id: 'dpt-evangelism',
    name: 'Evangelism & Outreach',
    description: 'Community outreach and follow-up of new converts.',
    icon: 'evangelism',
    accent: AccentToken.emerald,
  ),
  DepartmentType(
    id: 'dpt-prayer',
    name: 'Prayer & Intercession',
    description: 'Early morning prayer, vigils and intercession.',
    icon: 'prayer',
    accent: AccentToken.violet,
  ),
  DepartmentType(
    id: 'dpt-welfare',
    name: 'Welfare & Benevolence',
    description: 'Practical support for members in need.',
    icon: 'welfare',
    accent: AccentToken.amber,
  ),
];

final Map<String, DepartmentType> _typeById = {
  for (final t in departmentTypes) t.id: t,
};

DepartmentType? departmentTypeById(String id) => _typeById[id];

/// Core types run at every branch; the rest only at the larger ones. The church
/// plant runs core departments only, which is what a new branch looks like.
List<DepartmentType> _typesForBranch(Branch branch) {
  if (branch.status == BranchStatus.planting) {
    return departmentTypes.where((t) => t.isCore).toList();
  }
  if (branch.isHeadquarters) return departmentTypes;
  return departmentTypes.take(6).toList();
}

const _meetingDays = [
  Weekday.tuesday, Weekday.wednesday, Weekday.thursday,
  Weekday.friday, Weekday.saturday,
];

/// Every department instance across every branch.
final List<Department> departments = () {
  final result = <Department>[];
  var index = 0;

  for (final branch in branches) {
    final roll = membersOfBranch(branch.id);

    for (final type in _typesForBranch(branch)) {
      // Age-gated departments only draw from eligible members, so the
      // Children's department never contains adults.
      final eligible = type.ageRange == null
          ? roll
          : roll.where((m) {
              final age = m.ageAt(kDemoNow);
              return age >= type.ageRange!.min && age <= type.ageRange!.max;
            }).toList();

      if (eligible.isEmpty) continue;

      // Heads must be adults even for the children's department.
      final adults =
          roll.where((m) => m.ageAt(kDemoNow) >= 21).toList();
      final headPool = adults.isNotEmpty ? adults : roll;

      final size = eligible.length < 4
          ? eligible.length
          : Seed.intIn(index * 13, 4, eligible.length.clamp(4, 22));

      final picked = <String>{};
      for (var k = 0; k < size; k++) {
        picked.add(eligible[Seed.intIn(index * 31 + k * 7, 0, eligible.length - 1)].id);
      }

      result.add(Department(
        id: Seed.id('dep', index),
        typeId: type.id,
        branchId: branch.id,
        headId: headPool[Seed.intIn(index * 17, 0, headPool.length - 1)].id,
        assistantHeadId: headPool.length > 1
            ? headPool[Seed.intIn(index * 19 + 3, 0, headPool.length - 1)].id
            : null,
        memberIds: picked.toList(),
        meetingDay: Seed.pick(_meetingDays, index),
        meetingTime: Seed.pick(const ['5:00 PM', '6:00 PM', '6:30 PM', '4:00 PM'], index),
      ));
      index++;
    }
  }
  return result;
}();

Department? departmentById(String id) =>
    departments.where((d) => d.id == id).firstOrNull;

/// Departments running at one branch.
List<Department> departmentsOfBranch(String branchId) =>
    departments.where((d) => d.branchId == branchId).toList();

/// The same department type across every branch — the cross-branch roll-up that
/// the shared catalogue exists to make possible.
List<Department> departmentsOfType(String typeId) =>
    departments.where((d) => d.typeId == typeId).toList();

/// Display name for a department instance, e.g. "Youth Ministry · Tema".
String departmentName(String id) {
  final dept = departmentById(id);
  if (dept == null) return 'Unknown department';
  final type = departmentTypeById(dept.typeId);
  return type?.name ?? 'Department';
}
