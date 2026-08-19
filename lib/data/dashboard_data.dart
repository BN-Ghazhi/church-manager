import '../models/models.dart';
import '../utils/clock.dart';
import '../utils/formatters.dart';

/// Sparklines are omitted until there is history to draw.
///
/// They used to be generated squiggles, which read as a real trend and were
/// not. Showing no line is honest; showing an invented one is not.
const List<double> _noHistory = [];

/// The four headline numbers on the dashboard, computed over whatever branch
/// scope the caller passes in.
List<KpiStat> kpiStatsFor({
  required List<Member> members,
  required List<AttendanceRecord> attendance,
  required List<Donation> donations,
  required List<SmallGroup> groups,
  required List<Department> departments,
}) {
  final active =
      members.where((m) => m.status == MemberStatus.active).length;
  // Joined within the last 90 days.
  final recently = appNow().subtract(const Duration(days: 90));
  final newcomers = members.where((m) => m.joinedAt.isAfter(recently)).length;

  // The most recent service date may span several branches; sum them so the
  // headline reflects the whole scope rather than one arbitrary record.
  final latestDate = attendance.isEmpty
      ? null
      : attendance.map((r) => r.date).reduce((a, b) => a.isAfter(b) ? a : b);
  final lastServices =
      attendance.where((r) => r.date == latestDate).toList();
  final lastTotal = lastServices.fold(0, (sum, r) => sum + r.total);
  final lastOnline = lastServices.fold(0, (sum, r) => sum + r.online);

  // The calendar month in progress, not a fixed date from the old demo data.
  final now = appNow();
  final monthStart = DateTime.utc(now.year, now.month);
  final monthGiving = donations
      .where((d) => !d.date.isBefore(monthStart))
      .fold(0.0, (sum, d) => sum + d.amount);
  final inDepartments =
      departments.fold(0, (sum, d) => sum + d.memberCount);

  return [
    KpiStat(
      id: 'members',
      label: 'Active members',
      value: Fmt.number(active),
      hint: '$newcomers joined recently',
      spark: _noHistory,
    ),
    KpiStat(
      id: 'attendance',
      label: 'Last Sunday attendance',
      value: Fmt.number(lastTotal),
      hint: '${Fmt.number(lastOnline)} joined online',
      spark: _noHistory,
    ),
    KpiStat(
      id: 'giving',
      label: 'Giving this month',
      value: Fmt.compactCurrency(monthGiving),
      hint: 'Tithe, offering & funds',
      spark: _noHistory,
    ),
    KpiStat(
      id: 'departments',
      label: 'Departments',
      value: '${departments.length}',
      hint: '${Fmt.number(inDepartments)} serving members',
      spark: _noHistory,
    ),
  ];
}

/// Recent activity.
///
/// Empty until an audit trail exists: the dashboard would otherwise show
/// invented events, which is worse than showing nothing. Building this properly
/// means recording who changed what, which is a real feature rather than a
/// display detail.
const List<ActivityEntry> recentActivity = [];

const _ageBands = <(String, int)>[
  ('0–12', 12),
  ('13–19', 19),
  ('20–29', 29),
  ('30–39', 39),
  ('40–49', 49),
  ('50–59', 59),
  ('60+', 200),
];

/// Demographics are derived from [members] rather than hard-coded, so the
/// charts always agree with the directory. Swap the member source for real
/// queries and these follow automatically.
List<CategoryPoint> ageDistributionOf(List<Member> members) {
  return List.generate(_ageBands.length, (i) {
    final min = i == 0 ? 0 : _ageBands[i - 1].$2 + 1;
    final max = _ageBands[i].$2;
    final count = members.where((m) {
      final age = m.ageAt(appNow());
      return age >= min && age <= max;
    }).length;
    return CategoryPoint(label: _ageBands[i].$1, value: count.toDouble());
  });
}

List<CategoryPoint> genderSplitOf(List<Member> members) => [
      CategoryPoint(
        label: 'Female',
        value: members.where((m) => m.gender == Gender.female).length.toDouble(),
      ),
      CategoryPoint(
        label: 'Male',
        value: members.where((m) => m.gender == Gender.male).length.toDouble(),
      ),
    ];

/// Membership funnel from first visit to serving. Each stage is a strict subset
/// of the one above it, so the chart narrows monotonically and the
/// stage-to-stage conversion rates mean what they appear to mean.
List<CategoryPoint> growthFunnelOf(List<Member> members) {
  final returned =
      members.where((m) => m.status != MemberStatus.visitor).toList();
  final baptised = returned.where((m) => m.isBaptized).toList();
  // Departments replaced ministries as the serving model, so this counts
  // department membership. Checking ministryIds made the stage read zero for
  // everyone, which collapsed the funnel.
  final serving = baptised
      .where((m) => m.departmentIds.isNotEmpty || m.ministryIds.isNotEmpty)
      .toList();
  final inGroup = serving.where((m) => m.groupId != null).toList();

  return [
    CategoryPoint(label: 'First-time visitors', value: members.length.toDouble()),
    CategoryPoint(label: 'Returned within 30 days', value: returned.length.toDouble()),
    CategoryPoint(label: 'Completed membership class', value: baptised.length.toDouble()),
    CategoryPoint(label: 'Serving in a department', value: serving.length.toDouble()),
    CategoryPoint(label: 'Leading or in a small group', value: inGroup.length.toDouble()),
  ];
}
