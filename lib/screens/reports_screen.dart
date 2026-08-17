import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../widgets/charts.dart';
import '../widgets/feedback.dart';
import '../utils/csv_export.dart';
import '../widgets/page_header.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';

class _ReportTemplate {
  const _ReportTemplate(this.name, this.description, this.module, this.format);

  final String name;
  final String description;
  final String module;
  final String format;
}

/// Report templates the team can run on demand.
const _templates = [
  _ReportTemplate('Attendance summary',
      'Headcounts by service and segment over any date range.', 'Attendance', 'PDF'),
  _ReportTemplate('Annual giving statements',
      'Per-member contribution statements for tax purposes.', 'Finance', 'PDF'),
  _ReportTemplate('Fund breakdown',
      'Income and expenditure split by designated fund.', 'Finance', 'XLSX'),
  _ReportTemplate('Member directory export',
      'Full directory with contact details and ministry involvement.', 'Members', 'CSV'),
  _ReportTemplate('New members and visitors',
      'Everyone who joined or first visited in the period.', 'Members', 'CSV'),
  _ReportTemplate('Serving rota coverage',
      'Filled versus open slots by role and service.', 'Volunteers', 'PDF'),
  _ReportTemplate('Pastoral care log',
      'Care requests with resolution times and assigned pastors.', 'Care', 'PDF'),
  _ReportTemplate('Asset register',
      'All equipment with condition, location and value.', 'Assets', 'XLSX'),
];

const _scheduled = [
  ('Weekly attendance summary', 'Every Monday, 8:00 AM', 'Leadership team'),
  ('Monthly finance pack', '1st of the month', 'Finance committee'),
  ('Quarterly growth review', 'Every quarter', 'Pastor & board'),
];

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageBody(
      children: [
        PageHeader(
          title: 'Reports',
          description:
              'Export your data as CSV, and preview the figures behind each '
              'report. Template rendering and scheduling are not built yet.',
          actions: [
            FilledButton.icon(
              onPressed: () => _exportAll(context, ref),
              icon: const Icon(Icons.download_outlined, size: 17),
              label: const Text('Export data'),
            ),
          ],
        ),
        ResponsiveGrid(
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Members in scope',
              value: '${ref.watch(membersProvider).length}',
              hint: 'included in an export',
              icon: Icons.people_outline,
            ),
            StatCard(
              label: 'Giving records',
              value: '${ref.watch(donationsProvider).length}',
              hint: 'in the ledger',
              icon: Icons.payments_outlined,
            ),
            StatCard(
              label: 'Service records',
              value: '${ref.watch(attendanceRecordsProvider).length}',
              hint: 'headcounts logged',
              icon: Icons.how_to_reg_outlined,
            ),
            StatCard(
              label: 'Templates planned',
              value: '${_templates.length}',
              hint: 'not yet rendering',
              icon: Icons.bar_chart_outlined,
            ),
          ],
        ),
        SplitRow(
          primaryFlex: 1,
          secondaryFlex: 1,
          primary: SectionCard(
            title: 'Attendance overview',
            description: 'The data behind the attendance summary report.',
            child: TrendChart(
              data: ref.watch(attendanceTrendProvider),
              valueLabel: 'In person',
              compareLabel: 'Online',
            ),
          ),
          secondary: SectionCard(
            title: 'Finance overview',
            description: 'The data behind the monthly finance pack.',
            child: TrendChart(
              data: ref.watch(financeTrendProvider),
              valueLabel: 'Income',
              compareLabel: 'Expenses',
              format: ValueFormat.currency,
            ),
          ),
        ),
        SplitRow(
          primaryFlex: 1,
          secondaryFlex: 1,
          primary: SectionCard(
            title: 'Giving by fund',
            description: 'Designations across the reporting period.',
            child: CategoryBarChart(
              data: ref.watch(givingByFundProvider),
              format: ValueFormat.currency,
              horizontal: true,
            ),
          ),
          secondary: SectionCard(
            title: 'Age distribution',
            description: 'Demographic profile for the growth review.',
            child: CategoryBarChart(data: ref.watch(ageDistributionProvider)),
          ),
        ),
        SplitRow(
          primary: SectionCard(
            title: 'Report templates',
            description:
                'Planned templates. Rendering these to PDF/XLSX is not built '
                'yet — use Export data for CSV in the meantime.',
            child: ResponsiveGrid(
              minItemWidth: 280,
              maxColumns: 2,
              children: [
                for (final t in _templates)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm + 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(alpha: 0.7),
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          t.format == 'PDF'
                              ? Icons.picture_as_pdf_outlined
                              : Icons.table_chart_outlined,
                          size: 18,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.sm + 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(t.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              Text(t.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall),
                              const SizedBox(height: 4),
                              Text('${t.module} · ${t.format}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          secondary: SectionCard(
            title: 'Scheduled reports',
            description: 'Run and emailed without anyone lifting a finger.',
            child: Column(
              children: [
                for (final (name, cadence, recipients) in _scheduled)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        Text(cadence,
                            style: Theme.of(context).textTheme.labelSmall),
                        Text('To: $recipients',
                            style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Exports the datasets in scope as CSV files.
///
/// Everything written respects branch scoping, so an export cannot be used to
/// read another branch's records.
Future<void> _exportAll(BuildContext context, WidgetRef ref) async {
  final members = ref.read(membersProvider);
  final donations = ref.read(donationsProvider);
  final attendance = ref.read(attendanceRecordsProvider);

  try {
    final written = <String>[];

    written.add((await CsvExport.write(
      'members',
      CsvExport.buildCsv(
        headers: const [
          'First name', 'Last name', 'Email', 'Phone', 'Branch', 'Status',
        ],
        rows: [
          for (final m in members)
            [
              m.firstName,
              m.lastName,
              m.email,
              m.phone,
              ref.read(branchNameProvider(m.branchId)),
              m.status.label,
            ],
        ],
      ),
    ))!);

    written.add((await CsvExport.write(
      'giving',
      CsvExport.buildCsv(
        headers: const ['Date', 'Donor', 'Fund', 'Method', 'Amount', 'Branch'],
        rows: [
          for (final d in donations)
            [
              d.date.toIso8601String().split('T').first,
              d.donorName,
              d.fund.label,
              d.method.label,
              d.amount.toStringAsFixed(0),
              ref.read(branchNameProvider(d.branchId)),
            ],
        ],
      ),
    ))!);

    written.add((await CsvExport.write(
      'attendance',
      CsvExport.buildCsv(
        headers: const [
          'Date', 'Service', 'Branch', 'Adults', 'Children', 'Visitors',
          'Online', 'Total',
        ],
        rows: [
          for (final a in attendance)
            [
              a.date.toIso8601String().split('T').first,
              a.serviceName,
              ref.read(branchNameProvider(a.branchId)),
              a.adults,
              a.children,
              a.visitors,
              a.online,
              a.total,
            ],
        ],
      ),
    ))!);

    if (!context.mounted) return;
    showLocalSuccess(
      context,
      'Exported ${written.length} files to your Documents folder.',
    );
  } catch (error) {
    if (!context.mounted) return;
    showLocalSuccess(context, 'Could not export: $error');
  }
}
