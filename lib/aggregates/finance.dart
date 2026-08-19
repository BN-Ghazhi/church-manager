import '../models/models.dart';

/// Finance aggregates.
///
/// Pure functions over whatever the database returns. The demo ledgers that
/// used to live here are gone — the church enters its own giving and expenses.

double totalGivingOf(List<Donation> scoped) =>
    scoped.fold(0.0, (sum, d) => sum + d.amount);

double totalExpensesOf(List<ExpenseRecord> scoped) => scoped
    .where((e) => e.status == ExpenseStatus.paid)
    .fold(0.0, (sum, e) => sum + e.amount);

/// Giving totals per fund, largest first.
List<CategoryPoint> givingByFundOf(List<Donation> scoped) {
  final totals = <GivingFund, double>{};
  for (final d in scoped) {
    totals[d.fund] = (totals[d.fund] ?? 0) + d.amount;
  }
  final entries = totals.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return entries
      .map((e) => CategoryPoint(label: e.key.label, value: e.value))
      .toList();
}

/// Twelve months of income against expenditure, derived from real records.
///
/// Months with no activity read zero rather than being hidden, so the shape of
/// the year is honest about the gaps.
List<TrendPoint> financeTrendOf(
  List<Donation> donations, {
  List<ExpenseRecord> expenses = const [],
  DateTime? now,
}) {
  final end = now ?? DateTime.now().toUtc();
  const monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  return [
    for (var back = 11; back >= 0; back--)
      () {
        final month = DateTime.utc(end.year, end.month - back);
        bool inMonth(DateTime d) =>
            d.year == month.year && d.month == month.month;

        return TrendPoint(
          label: monthNames[month.month - 1],
          value: donations
              .where((d) => inMonth(d.date))
              .fold<double>(0, (sum, d) => sum + d.amount),
          compare: expenses
              .where((e) => inMonth(e.date))
              .fold<double>(0, (sum, e) => sum + e.amount),
        );
      }(),
  ];
}
