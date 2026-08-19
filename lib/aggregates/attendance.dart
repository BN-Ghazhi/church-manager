import '../models/models.dart';

/// Attendance aggregates.
///
/// The demo calendar and attendance history that used to live here are gone —
/// the church records its own services.

/// In-person against online for the most recent service dates, oldest first.
///
/// Records are summed per date, so the trend reflects whichever branches are in
/// scope rather than one branch standing in for the whole church.
List<TrendPoint> attendanceTrendFor(
  List<AttendanceRecord> records, {
  int months = 12,
}) {
  final byDate = <DateTime, List<AttendanceRecord>>{};
  for (final r in records) {
    byDate.putIfAbsent(r.date, () => []).add(r);
  }
  final dates = byDate.keys.toList()..sort();
  final recent =
      dates.length <= months ? dates : dates.sublist(dates.length - months);

  return [
    for (final date in recent)
      TrendPoint(
        label: '${date.month}/${date.day}',
        value: byDate[date]!.fold<double>(0, (s, r) => s + r.inPerson),
        compare: byDate[date]!.fold<double>(0, (s, r) => s + r.online),
      ),
  ];
}
