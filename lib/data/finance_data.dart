import '../models/models.dart';
import 'branches_data.dart';
import 'members_data.dart';
import 'seed.dart';

const _funds = [
  GivingFund.tithe, GivingFund.tithe, GivingFund.tithe,
  GivingFund.offering, GivingFund.offering,
  GivingFund.building, GivingFund.missions,
  GivingFund.welfare, GivingFund.special,
];

const _methods = [
  PaymentMethod.transfer, PaymentMethod.transfer, PaymentMethod.card,
  PaymentMethod.cash, PaymentMethod.mobile, PaymentMethod.cheque,
];

/// 140 donations spread over the last 120 days, newest first.
final List<Donation> donations = List.generate(320, (i) {
  final member = members[(i * 7) % members.length];
  final anonymous = i % 11 == 0;
  return Donation(
    id: Seed.id('don', i),
    memberId: anonymous ? null : member.id,
    donorName: anonymous ? 'Anonymous' : member.fullName,
    amount: Seed.intIn(i * 3, 2, 240) * 1000.0,
    fund: Seed.pick(_funds, i),
    method: Seed.pick(_methods, i * 3),
    date: dayOnly(-Seed.intIn(i * 5, 0, 120)),
    reference: 'TXN-${(920000 + i * 137).toString().substring(0, 6)}',
    branchId: member.branchId,
    isRecurring: i % 6 == 0,
  );
})..sort((a, b) => b.date.compareTo(a.date));

const _campaignNames = [
  'New Sanctuary Build', 'Missions 2026', 'Bus Fund', 'Welfare Endowment',
];

final List<Pledge> pledges = List.generate(22, (i) {
  final pledged = Seed.intIn(i * 13, 50, 500) * 10000.0;
  return Pledge(
    id: Seed.id('pld', i),
    memberId: members[(i * 9) % members.length].id,
    campaign: Seed.pick(_campaignNames, i),
    pledged: pledged,
    fulfilled: pledged * (Seed.intIn(i * 17, 10, 100) / 100),
    dueDate: dayOnly(Seed.intIn(i * 19, 10, 300)),
  );
});

const _expenseCategories = [
  'Utilities', 'Salaries', 'Maintenance', 'Outreach', 'Equipment',
  'Transport', 'Hospitality', 'Rent', 'Media Subscriptions',
];

const _vendors = [
  'Electricity Company of Ghana', 'Staff Payroll', 'Bright Facility Ltd',
  'Hope Outreach', 'SoundPro Audio', 'Swift Logistics Ghana',
  'Grace Catering', 'Adabraka Properties', 'StreamHost Inc',
];

const _expenseStatuses = [
  ExpenseStatus.paid, ExpenseStatus.paid, ExpenseStatus.approved,
  ExpenseStatus.pending, ExpenseStatus.rejected,
];

final List<ExpenseRecord> expenses = List.generate(90, (i) {
  return ExpenseRecord(
    id: Seed.id('exp', i),
    category: _expenseCategories[i % _expenseCategories.length],
    vendor: _vendors[i % _vendors.length],
    amount: Seed.intIn(i * 7, 15, 900) * 1000.0,
    date: dayOnly(-Seed.intIn(i * 11, 0, 90)),
    approvedBy: members[(i * 5) % members.length].id,
    branchId: branchIdAt(i % branchSeeds.length),
    status: Seed.pick(_expenseStatuses, i),
  );
})..sort((a, b) => b.date.compareTo(a.date));

const _months = [
  'Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb',
  'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug',
];

/// Twelve months of income against expenditure.
final List<TrendPoint> financeTrend = List.generate(12, (i) {
  return TrendPoint(
    label: _months[i],
    value: 3800000 + Seed.intIn(i * 23, -400, 1400) * 1000.0,
    compare: 2400000 + Seed.intIn(i * 29, -300, 900) * 1000.0,
  );
});

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

/// Twelve-month income/expense trend for a scoped donation set. Falls back to
/// the shaped seed series so the chart keeps its twelve-month shape even when a
/// single branch has sparse history.
List<TrendPoint> financeTrendOf(List<Donation> scoped) {
  if (scoped.length == donations.length) return financeTrend;
  final share = donations.isEmpty ? 0.0 : scoped.length / donations.length;
  return [
    for (final p in financeTrend)
      TrendPoint(
        label: p.label,
        value: p.value * share,
        compare: (p.compare ?? 0) * share,
      ),
  ];
}
