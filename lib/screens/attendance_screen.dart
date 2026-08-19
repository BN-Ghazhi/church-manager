import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/charts.dart';
import '../widgets/data_table_view.dart';
import '../widgets/feedback.dart';
import '../widgets/page_header.dart';
import '../widgets/record_forms.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/person_tile.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  final _checkedIn = <String>{};
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final records = ref.watch(attendanceRecordsProvider);
    final members = ref.watch(membersProvider);

    // A fresh install has no services recorded, so nothing here may assume a
    // first or second record exists.
    final latest = records.isEmpty ? null : records.first;
    final previous = records.length > 1 ? records[1] : null;
    final delta = (previous == null || previous.total == 0)
        ? null
        : (latest!.total - previous.total) / previous.total * 100;

    final totalAttendance = records.fold(0, (sum, r) => sum + r.total);
    final average = records.isEmpty ? 0 : totalAttendance ~/ records.length;
    final totalOnline = records.fold(0, (sum, r) => sum + r.online);

    int avgOf(int Function(AttendanceRecord) pick) => records.isEmpty
        ? 0
        : records.fold(0, (sum, r) => sum + pick(r)) ~/ records.length;

    final segments = [
      CategoryPoint(label: 'Adults', value: avgOf((r) => r.adults).toDouble()),
      CategoryPoint(label: 'Children', value: avgOf((r) => r.children).toDouble()),
      CategoryPoint(label: 'Visitors', value: avgOf((r) => r.visitors).toDouble()),
      CategoryPoint(label: 'Online', value: avgOf((r) => r.online).toDouble()),
    ];

    return PageBody(
      children: [
        PageHeader(
          title: 'Attendance',
          description:
              'Record service headcounts, check members in and watch the trend over time.',
          actions: [
            OutlinedButton.icon(
              onPressed: () => showServiceRecordForm(context),
              icon: const Icon(Icons.add, size: 17),
              label: const Text('New service record'),
            ),
          ],
        ),
        ResponsiveGrid(
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Last service',
              value: latest == null ? '—' : Fmt.number(latest.total),
              delta: delta == null
                  ? null
                  : double.parse(delta.toStringAsFixed(1)),
              hint: latest?.serviceName ?? 'no services recorded yet',
              icon: Icons.how_to_reg_outlined,
            ),
            StatCard(
              label: '26-week average',
              value: Fmt.number(average),
              hint: 'all services',
              icon: Icons.trending_up,
            ),
            StatCard(
              label: 'Online share',
              value: Fmt.share(totalOnline, totalAttendance),
              hint: 'of total attendance',
              icon: Icons.laptop_outlined,
            ),
            StatCard(
              label: 'Checked in today',
              value: Fmt.number(_checkedIn.length),
              hint: 'of ${members.length} on file',
              icon: Icons.people_outline,
            ),
          ],
        ),
        SplitRow(
          primary: SectionCard(
            title: 'In person versus online',
            description: 'Total attendance across the last twelve services.',
            child: TrendChart(
              data: ref.watch(attendanceTrendProvider),
              valueLabel: 'In person',
              compareLabel: 'Online',
              height: 290,
            ),
          ),
          secondary: SectionCard(
            title: 'Average by segment',
            description: 'Mean headcount per service.',
            child: CategoryBarChart(data: segments, height: 290),
          ),
        ),
        SectionCard(
          title: 'Service records',
          description: 'Every recorded headcount, newest first.',
          child: DataTableView<AttendanceRecord>(
            rows: records,
            rowId: (r) => r.id,
            pageSize: 10,
            searchHint: 'Search by service…',
            searchable: (r) => r.serviceName,
            filters: [
              TableFilter<AttendanceRecord>(
                id: 'service',
                label: 'Service',
                options: const ['First Service', 'Second Service'],
                matches: (r, v) => r.serviceName == v,
              ),
            ],
            columns: [
              TableColumn<AttendanceRecord>(
                id: 'date',
                header: 'Date',
                flex: 2,
                sortValue: (r) => r.date,
                cell: (r) => Text(Fmt.date(r.date),
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              TableColumn<AttendanceRecord>(
                id: 'service',
                header: 'Service',
                flex: 2,
                sortValue: (r) => r.serviceName,
                cell: (r) => Text(r.serviceName,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              for (final col in [
                ('adults', 'Adults', (AttendanceRecord r) => r.adults),
                ('children', 'Children', (AttendanceRecord r) => r.children),
                ('visitors', 'Visitors', (AttendanceRecord r) => r.visitors),
                ('online', 'Online', (AttendanceRecord r) => r.online),
              ])
                TableColumn<AttendanceRecord>(
                  id: col.$1,
                  header: col.$2,
                  width: 84,
                  hideOnNarrow: true,
                  sortValue: (r) => col.$3(r),
                  cell: (r) => Text(Fmt.number(col.$3(r)),
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              TableColumn<AttendanceRecord>(
                id: 'total',
                header: 'Total',
                width: 84,
                sortValue: (r) => r.total,
                cell: (r) => Text(
                  Fmt.number(r.total),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Member check-in',
          description:
              "Mark attendance for today's service. Search, tick and save.",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (v) => setState(() => _search = v),
                      decoration: const InputDecoration(
                        hintText: 'Search members…',
                        prefixIcon: Icon(Icons.search, size: 18),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text('${_checkedIn.length} selected',
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(width: AppSpacing.sm + 4),
                  FilledButton.icon(
                    onPressed: _checkedIn.isEmpty
                        ? null
                        : () async {
                            final branchId =
                                ref.read(selectedBranchProvider) ??
                                    ref
                                        .read(visibleBranchesProvider)
                                        .firstOrNull
                                        ?.id;
                            if (branchId == null) return;

                            final now = DateTime.now();
                            final count = _checkedIn.length;
                            await ref.read(repositoryProvider).saveCheckIns(
                                  branchId: branchId,
                                  date: DateTime.utc(
                                      now.year, now.month, now.day),
                                  serviceName: 'First Service',
                                  memberIds: _checkedIn,
                                );
                            if (!context.mounted) return;
                            showLocalSuccess(context,
                                'Checked in $count members — saved to the database.');
                            setState(_checkedIn.clear);
                          },
                    icon: const Icon(Icons.how_to_reg, size: 17),
                    label: const Text('Save check-in'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 320,
                child: Builder(builder: (context) {
                  final needle = _search.trim().toLowerCase();
                  final visible = members
                      .take(30)
                      .where((m) => needle.isEmpty ||
                          m.fullName.toLowerCase().contains(needle))
                      .toList();

                  if (visible.isEmpty) {
                    return const EmptyState(
                      title: 'No members found',
                      description: 'Try a different name or clear the search.',
                      icon: Icons.search_off,
                    );
                  }

                  return ListView.builder(
                    itemCount: visible.length,
                    itemBuilder: (context, i) {
                      final m = visible[i];
                      return CheckboxListTile(
                        dense: true,
                        value: _checkedIn.contains(m.id),
                        onChanged: (on) => setState(() {
                          if (on == true) {
                            _checkedIn.add(m.id);
                          } else {
                            _checkedIn.remove(m.id);
                          }
                        }),
                        title: Text(m.fullName,
                            style: Theme.of(context).textTheme.bodyMedium),
                        subtitle: Text(m.phone,
                            style: Theme.of(context).textTheme.labelSmall),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
