import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../models/models.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/charts.dart';
import '../widgets/data_table_view.dart';
import '../widgets/page_header.dart';
import '../widgets/record_forms.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_badge.dart';

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final donations = ref.watch(donationsProvider);
    final expenses = ref.watch(expensesProvider);
    final pledges = ref.watch(pledgesProvider);
    final income = ref.watch(totalGivingProvider);
    final outgoings = ref.watch(totalExpensesProvider);

    final pledged = pledges.fold(0.0, (s, p) => s + p.pledged);
    final fulfilled = pledges.fold(0.0, (s, p) => s + p.fulfilled);
    final pending =
        expenses.where((e) => e.status == ExpenseStatus.pending).length;

    return PageBody(
      children: [
        PageHeader(
          title: 'Giving & Finance',
          description:
              "Donations, pledges and expenditure with a clear picture of the church's position.",
          actions: [
            OutlinedButton.icon(
              onPressed: () => showExpenseForm(context),
              icon: const Icon(Icons.receipt_long_outlined, size: 17),
              label: const Text('Record expense'),
            ),
            FilledButton.icon(
              onPressed: () => showDonationForm(context),
              icon: const Icon(Icons.add, size: 17),
              label: const Text('Record giving'),
            ),
          ],
        ),
        ResponsiveGrid(
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Total giving',
              value: Fmt.compactCurrency(income),
              delta: 6.4,
              hint: 'last 120 days',
              icon: Icons.payments_outlined,
            ),
            StatCard(
              label: 'Expenditure',
              value: Fmt.compactCurrency(outgoings),
              delta: 2.8,
              hint: '$pending awaiting approval',
              icon: Icons.receipt_long_outlined,
              invertDelta: true,
            ),
            StatCard(
              label: 'Net position',
              value: Fmt.compactCurrency(income - outgoings),
              delta: 9.1,
              hint: 'income less paid expenses',
              icon: Icons.account_balance_outlined,
            ),
            StatCard(
              label: 'Pledges fulfilled',
              value: '${(fulfilled / pledged * 100).round()}%',
              delta: 4.2,
              hint:
                  '${Fmt.compactCurrency(fulfilled)} of ${Fmt.compactCurrency(pledged)}',
              icon: Icons.flag_outlined,
            ),
          ],
        ),
        SplitRow(
          primary: SectionCard(
            title: 'Income and expenses',
            description: 'Rolling twelve months.',
            child: TrendChart(
              data: ref.watch(financeTrendProvider),
              valueLabel: 'Income',
              compareLabel: 'Expenses',
              format: ValueFormat.currency,
              height: 290,
            ),
          ),
          secondary: SectionCard(
            title: 'Giving by fund',
            description: 'Where gifts are designated.',
            child: DonutChart(
              data: ref.watch(givingByFundProvider),
              format: ValueFormat.currency,
              height: 230,
            ),
          ),
        ),
        DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(text: 'Donations'),
                    Tab(text: 'Expenses'),
                    Tab(text: 'Pledges'),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md + 4),
              SizedBox(
                height: 720,
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: SectionCard(
                        title: 'Donation ledger',
                        description:
                            '${donations.length} recorded gifts across all funds.',
                        child: DataTableView<Donation>(
                          rows: donations,
                          rowId: (d) => d.id,
                          pageSize: 10,
                          searchHint: 'Search by donor or reference…',
                          searchable: (d) => '${d.donorName} ${d.reference}',
                          filters: [
                            TableFilter<Donation>(
                              id: 'fund',
                              label: 'Fund',
                              options:
                                  GivingFund.values.map((f) => f.label).toList(),
                              matches: (d, v) => d.fund.label == v,
                            ),
                            TableFilter<Donation>(
                              id: 'method',
                              label: 'Method',
                              options: PaymentMethod.values
                                  .map((m) => m.label)
                                  .toList(),
                              matches: (d, v) => d.method.label == v,
                            ),
                          ],
                          columns: [
                            TableColumn<Donation>(
                              id: 'donor',
                              header: 'Donor',
                              flex: 3,
                              sortValue: (d) => d.donorName,
                              cell: (d) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(d.donorName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600)),
                                  Text(d.reference,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall),
                                ],
                              ),
                            ),
                            TableColumn<Donation>(
                              id: 'fund',
                              header: 'Fund',
                              flex: 2,
                              sortValue: (d) => d.fund.label,
                              cell: (d) => Text(d.fund.label,
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                            TableColumn<Donation>(
                              id: 'method',
                              header: 'Method',
                              flex: 2,
                              hideOnNarrow: true,
                              sortValue: (d) => d.method.label,
                              cell: (d) => Text(d.method.label,
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                            TableColumn<Donation>(
                              id: 'date',
                              header: 'Date',
                              flex: 2,
                              hideOnNarrow: true,
                              sortValue: (d) => d.date,
                              cell: (d) => Text(Fmt.date(d.date),
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                            TableColumn<Donation>(
                              id: 'amount',
                              header: 'Amount',
                              flex: 2,
                              alignEnd: true,
                              sortValue: (d) => d.amount,
                              cell: (d) => Text(
                                Fmt.currency(d.amount),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: SectionCard(
                        title: 'Expense ledger',
                        description: 'Every expense with its approval status.',
                        child: DataTableView<ExpenseRecord>(
                          rows: expenses,
                          rowId: (e) => e.id,
                          pageSize: 10,
                          searchHint: 'Search by vendor or category…',
                          searchable: (e) => '${e.vendor} ${e.category}',
                          filters: [
                            TableFilter<ExpenseRecord>(
                              id: 'status',
                              label: 'Status',
                              options: ExpenseStatus.values
                                  .map((s) => s.label)
                                  .toList(),
                              matches: (e, v) => e.status.label == v,
                            ),
                          ],
                          columns: [
                            TableColumn<ExpenseRecord>(
                              id: 'vendor',
                              header: 'Vendor',
                              flex: 3,
                              sortValue: (e) => e.vendor,
                              cell: (e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(e.vendor,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600)),
                                  Text(e.category,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall),
                                ],
                              ),
                            ),
                            TableColumn<ExpenseRecord>(
                              id: 'date',
                              header: 'Date',
                              flex: 2,
                              hideOnNarrow: true,
                              sortValue: (e) => e.date,
                              cell: (e) => Text(Fmt.date(e.date),
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                            TableColumn<ExpenseRecord>(
                              id: 'status',
                              header: 'Status',
                              width: 118,
                              sortValue: (e) => e.status.label,
                              cell: (e) => StatusBadge.of(e.status),
                            ),
                            TableColumn<ExpenseRecord>(
                              id: 'amount',
                              header: 'Amount',
                              flex: 2,
                              alignEnd: true,
                              sortValue: (e) => e.amount,
                              cell: (e) => Text(
                                Fmt.currency(e.amount),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: SectionCard(
                        title: 'Pledge tracking',
                        description:
                            'Campaign commitments and how much has come in.',
                        child: Column(
                          children: [
                            for (final p in pledges)
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: AppSpacing.md),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                ref.watch(memberNameProvider(
                                                    p.memberId)),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              Text(
                                                '${p.campaign} · due ${Fmt.date(p.dueDate)}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '${Fmt.currency(p.fulfilled)} of ${Fmt.currency(p.pledged)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: p.progress,
                                        minHeight: 7,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainerHighest,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
