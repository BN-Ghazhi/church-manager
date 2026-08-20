import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../providers/auth.dart';
import '../widgets/row_actions.dart';
import '../widgets/collapsible.dart';
import '../widgets/feedback.dart';
import '../providers/permissions.dart';
import '../utils/clock.dart';
import '../models/models.dart';
import '../providers/repository.dart';
import '../utils/formatters.dart';
import '../widgets/charts.dart';
import '../widgets/data_table_view.dart';
import '../widgets/page_header.dart';
import '../widgets/record_forms.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/person_tile.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_badge.dart';

class CareScreen extends ConsumerWidget {
  const CareScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(careRequestsProvider);
    final open = requests.where((c) => c.status == CareStatus.open).length;
    final inProgress =
        requests.where((c) => c.status == CareStatus.inProgress).length;
    final resolved =
        requests.where((c) => c.status == CareStatus.resolved).length;
    final unassigned = requests
        .where((c) => c.assignedToId == null && c.status != CareStatus.resolved)
        .length;

    final byType = <CareType, int>{};
    for (final r in requests) {
      byType[r.type] = (byType[r.type] ?? 0) + 1;
    }
    final typeData = byType.entries
        .map((e) => CategoryPoint(label: e.key.label, value: e.value.toDouble()))
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return PageBody(
      children: [
        PageHeader(
          title: 'Pastoral Care',
          description:
              'Prayer requests, counselling, hospital visits and bereavement support in one queue.',
          actions: [
            FilledButton.icon(
              onPressed: () => showCareForm(context),
              icon: const Icon(Icons.add, size: 17),
              label: const Text('Log a request'),
            ),
          ],
        ),
        StatRow(
          sectionKey: 'care.stats',
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Open requests',
              value: '$open',
              hint: 'awaiting first contact',
              icon: Icons.error_outline,
              invertDelta: true,
            ),
            StatCard(
              label: 'In progress',
              value: '$inProgress',
              hint: 'being followed up',
              icon: Icons.schedule,
            ),
            StatCard(
              label: 'Resolved',
              value: '$resolved',
              hint: 'closed recently',
              icon: Icons.check_circle_outline,
            ),
            StatCard(
              label: 'Unassigned',
              value: '$unassigned',
              hint: 'need a pastor allocated',
              icon: Icons.person_search_outlined,
              invertDelta: true,
            ),
          ],
        ),
        SplitRow(
          primary: SectionCard(
            title: 'Care queue',
            description:
                'Every request with its priority, owner and current status.',
            child: DataTableView<CareRequest>(
              rows: requests,
              rowId: (c) => c.id,
              pageSize: 10,
              searchHint: 'Search by member or summary…',
              searchable: (c) =>
                  '${ref.read(memberNameProvider(c.memberId))} ${c.summary} ${c.type.label}',
              filters: [
                TableFilter<CareRequest>(
                  id: 'status',
                  label: 'Status',
                  options: CareStatus.values.map((s) => s.label).toList(),
                  matches: (c, v) => c.status.label == v,
                ),
                TableFilter<CareRequest>(
                  id: 'priority',
                  label: 'Priority',
                  options: CarePriority.values.map((p) => p.label).toList(),
                  matches: (c, v) => c.priority.label == v,
                ),
                TableFilter<CareRequest>(
                  id: 'type',
                  label: 'Type',
                  options: CareType.values.map((t) => t.label).toList(),
                  matches: (c, v) => c.type.label == v,
                ),
              ],
              columns: [
                TableColumn<CareRequest>(
                  id: 'member',
                  header: 'Member',
                  flex: 3,
                  cell: (c) => PersonTile(
                    name: ref.watch(memberNameProvider(c.memberId)),
                    secondary: c.type.label,
                    compact: true,
                  ),
                ),
                TableColumn<CareRequest>(
                  id: 'summary',
                  header: 'Request',
                  flex: 4,
                  hideOnNarrow: true,
                  cell: (c) => Text(
                    c.summary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                TableColumn<CareRequest>(
                  id: 'priority',
                  header: 'Priority',
                  width: 104,
                  sortValue: (c) => c.priority.index,
                  cell: (c) => StatusBadge.of(c.priority),
                ),
                TableColumn<CareRequest>(
                  id: 'raised',
                  header: 'Raised',
                  flex: 2,
                  hideOnNarrow: true,
                  sortValue: (c) => c.createdAt,
                  cell: (c) => Text(
                    Fmt.relative(c.createdAt, appNow()),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                TableColumn<CareRequest>(
                  id: 'status',
                  header: 'Status',
                  width: 122,
                  sortValue: (c) => c.status.label,
                  cell: (c) => StatusBadge.of(c.status),
                ),
                TableColumn<CareRequest>(
                  id: 'actions',
                  header: '',
                  width: 116,
                  cell: (c) => RowActions(
                    onView: () => _showCare(context, ref, c),
                    onEdit: () => showCareForm(context, request: c),
                    onDelete: () => _deleteCare(context, ref, c),
                  ),
                ),
              ],
            ),
          ),
          secondary: SectionCard(
            title: 'Requests by type',
            description: 'What the congregation is asking for.',
            child: CategoryBarChart(
              data: typeData,
              horizontal: true,
              height: 300,
            ),
          ),
        ),
      ],
    );
  }
}

void _showCare(BuildContext context, WidgetRef ref, CareRequest request) {
  showDetailSheet<void>(
    context,
    title: ref.read(memberNameProvider(request.memberId)),
    subtitle: '${request.type.label} · ${request.priority.label} priority',
    children: [
      DetailRows(entries: {
        'Member': ref.read(memberNameProvider(request.memberId)),
        'Type': request.type.label,
        'Priority': request.priority.label,
        'Status': request.status.label,
        'Raised': Fmt.dateTime(request.createdAt),
        'Assigned to': (request.assignedToId ?? '').isEmpty
            ? 'Unassigned'
            : ref.read(memberNameProvider(request.assignedToId)),
        'Branch': ref.read(branchNameProvider(request.branchId)),
        'Summary': request.summary,
      }),
    ],
    actions: (close) => [
      if (ref.read(canEditProvider('Care')))
        OutlinedButton.icon(
          onPressed: () {
            close();
            showCareForm(context, request: request);
          },
          icon: const Icon(Icons.edit_outlined, size: 16),
          label: const Text('Edit'),
        ),
    ],
  );
}

Future<void> _deleteCare(
  BuildContext context,
  WidgetRef ref,
  CareRequest request,
) async {
  final ok = await confirmDelete(
    context,
    what: 'the ${request.type.label.toLowerCase()} request for '
        '${ref.read(memberNameProvider(request.memberId))}',
    consequence: 'It leaves the pastoral care queue.',
  );
  if (!ok || !context.mounted) return;
  await ref.read(repositoryProvider).deleteCareRequest(request.id);
  if (!context.mounted) return;
  showLocalSuccess(context, 'Care request removed.');
}
