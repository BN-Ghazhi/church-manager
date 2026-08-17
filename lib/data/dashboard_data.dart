import '../models/models.dart';
import '../utils/formatters.dart';
import 'seed.dart';

List<double> _spark(int seed) =>
    List.generate(12, (i) => Seed.intIn(seed + i * 7, 30, 100).toDouble());

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
  final newcomers =
      members.where((m) => m.joinedAt.isAfter(DateTime.utc(2025, 8, 1))).length;

  // The most recent service date may span several branches; sum them so the
  // headline reflects the whole scope rather than one arbitrary record.
  final latestDate = attendance.isEmpty
      ? null
      : attendance.map((r) => r.date).reduce((a, b) => a.isAfter(b) ? a : b);
  final lastServices =
      attendance.where((r) => r.date == latestDate).toList();
  final lastTotal = lastServices.fold(0, (sum, r) => sum + r.total);
  final lastOnline = lastServices.fold(0, (sum, r) => sum + r.online);

  final monthGiving = donations
      .where((d) => !d.date.isBefore(DateTime.utc(2026, 7, 15)))
      .fold(0.0, (sum, d) => sum + d.amount);
  final inDepartments =
      departments.fold(0, (sum, d) => sum + d.memberCount);

  return [
    KpiStat(
      id: 'members',
      label: 'Active members',
      value: Fmt.number(active),
      delta: 4.8,
      hint: '$newcomers joined recently',
      spark: _spark(3),
    ),
    KpiStat(
      id: 'attendance',
      label: 'Last Sunday attendance',
      value: Fmt.number(lastTotal),
      delta: 2.1,
      hint: '${Fmt.number(lastOnline)} joined online',
      spark: _spark(17),
    ),
    KpiStat(
      id: 'giving',
      label: 'Giving this month',
      value: Fmt.compactCurrency(monthGiving),
      delta: -3.4,
      hint: 'Tithe, offering & funds',
      spark: _spark(29),
    ),
    KpiStat(
      id: 'departments',
      label: 'Departments',
      value: '${departments.length}',
      delta: 12.5,
      hint: '${Fmt.number(inDepartments)} serving members',
      spark: _spark(41),
    ),
  ];
}

final List<ActivityEntry> recentActivity = [
  ActivityEntry(id: 'act-1', kind: ActivityKind.member, actor: 'Grace Ansah', action: 'registered a new member', target: 'Kwabena Asante', at: DateTime.utc(2026, 8, 14, 8, 12)),
  ActivityEntry(id: 'act-2', kind: ActivityKind.donation, actor: 'Daniel Boateng', action: 'recorded a transfer to', target: 'Building Fund · GH₵250,000', at: DateTime.utc(2026, 8, 14, 7, 40)),
  ActivityEntry(id: 'act-3', kind: ActivityKind.volunteer, actor: 'Esther Asante', action: 'published the serving rota for', target: 'Sunday, 17 August', at: DateTime.utc(2026, 8, 13, 18, 5)),
  ActivityEntry(id: 'act-4', kind: ActivityKind.care, actor: 'Pastor Samuel', action: 'closed a care request for', target: 'Ruth Quartey', at: DateTime.utc(2026, 8, 13, 15, 22)),
  ActivityEntry(id: 'act-5', kind: ActivityKind.message, actor: 'Grace Ansah', action: 'sent an SMS campaign to', target: '842 members', at: DateTime.utc(2026, 8, 12, 8)),
  ActivityEntry(id: 'act-6', kind: ActivityKind.event, actor: 'Michael Owusu', action: 'opened registration for', target: 'Leadership Conference', at: DateTime.utc(2026, 8, 11, 11, 30)),
  ActivityEntry(id: 'act-7', kind: ActivityKind.member, actor: 'System', action: 'flagged 6 members as', target: 'inactive (90 days)', at: DateTime.utc(2026, 8, 11, 6)),
  ActivityEntry(id: 'act-8', kind: ActivityKind.donation, actor: 'Naomi Amoah', action: 'fulfilled a pledge toward', target: 'Missions 2026', at: DateTime.utc(2026, 8, 10, 16, 45)),
];

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
      final age = m.ageAt(kDemoNow);
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
  final serving = baptised.where((m) => m.ministryIds.isNotEmpty).toList();
  final inGroup = serving.where((m) => m.groupId != null).toList();

  return [
    CategoryPoint(label: 'First-time visitors', value: members.length.toDouble()),
    CategoryPoint(label: 'Returned within 30 days', value: returned.length.toDouble()),
    CategoryPoint(label: 'Completed membership class', value: baptised.length.toDouble()),
    CategoryPoint(label: 'Serving in a ministry', value: serving.length.toDouble()),
    CategoryPoint(label: 'Leading or in a small group', value: inGroup.length.toDouble()),
  ];
}
