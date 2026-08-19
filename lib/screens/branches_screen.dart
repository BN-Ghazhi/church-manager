import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../shell/branch_switcher.dart' show accentColor;
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/charts.dart';
import '../widgets/feedback.dart';
import '../widgets/data_table_view.dart';
import '../widgets/row_actions.dart';
import '../widgets/collapsible.dart';
import '../widgets/page_header.dart';
import '../widgets/record_forms.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_badge.dart';

/// The network view: every campus side by side.
///
/// Only reachable by roles whose scope spans branches; a Branch Pastor sees
/// their own branch here and nothing else, because the providers are scoped.
class BranchesScreen extends ConsumerWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visible = ref.watch(visibleBranchesProvider);
    final active = ref.watch(activeBranchIdsProvider);
    final branches =
        visible.where((b) => active.contains(b.id)).toList();

    final members = ref.watch(membersProvider);
    final departments = ref.watch(departmentsProvider);
    final attendance = ref.watch(attendanceRecordsProvider);
    final canEdit = ref.watch(canEditProvider('Branches'));

    final planting =
        branches.where((b) => b.status == BranchStatus.planting).length;

    return PageBody(
      children: [
        PageHeader(
          title: 'Branches',
          description:
              'Every campus in the church network, with its leadership, size and health.',
          actions: [
            if (canEdit)
              FilledButton.icon(
                onPressed: () => showBranchForm(context),
                icon: const Icon(Icons.add, size: 17),
                label: const Text('Add branch'),
              ),
          ],
        ),

        StatRow(
          sectionKey: 'branches.stats',
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Branches in view',
              value: '${branches.length}',
              hint: '$planting church plant${planting == 1 ? '' : 's'}',
              icon: Icons.account_tree_outlined,
            ),
            StatCard(
              label: 'Members across branches',
              value: Fmt.number(members.length),
              hint: 'all statuses',
              icon: Icons.people_outline,
            ),
            StatCard(
              label: 'Departments running',
              value: '${departments.length}',
              hint: 'across every branch',
              icon: Icons.groups_outlined,
            ),
            StatCard(
              label: 'Last Sunday, all branches',
              value: Fmt.number(_latestTotal(attendance)),
              hint: 'combined attendance',
              icon: Icons.how_to_reg_outlined,
            ),
          ],
        ),

        if (branches.length > 1)
          SplitRow(
            primary: SectionCard(
              title: 'Members by branch',
              description: 'Relative size of each campus.',
              child: CategoryBarChart(
                data: ref.watch(membersByBranchProvider),
                height: 250,
              ),
            ),
            secondary: SectionCard(
              title: 'Giving by branch',
              description: 'Contribution to total giving.',
              child: CategoryBarChart(
                data: ref.watch(givingByBranchProvider),
                format: ValueFormat.currency,
                height: 250,
              ),
            ),
          ),

        SectionCard(
          title: 'Branches',
          description:
              'Select a branch to see its leadership and figures.',
          child: DataTableView<Branch>(
            rows: branches,
            rowId: (b) => b.id,
            pageSize: 12,
            searchHint: 'Search by name, code or city…',
            searchable: (b) => '${b.name} ${b.code} ${b.address.city}'
                ' ${b.address.region}',
            onRowTap: (b) => _showBranch(context, ref, b),
            columns: [
              TableColumn<Branch>(
                id: 'code',
                header: 'Code',
                width: 76,
                sortValue: (b) => b.code,
                cell: (b) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: accentColor(b.accent).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    b.code,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: accentColor(b.accent),
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ),
              TableColumn<Branch>(
                id: 'name',
                header: 'Branch',
                flex: 3,
                sortValue: (b) => b.name,
                cell: (b) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            b.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        if (b.isHeadquarters)
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              'HQ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: AppTheme.warning),
                            ),
                          ),
                      ],
                    ),
                    if (b.address.short.isNotEmpty)
                      Text(b.address.short,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ),
              TableColumn<Branch>(
                id: 'pastor',
                header: 'Branch pastor',
                flex: 2,
                hideOnNarrow: true,
                cell: (b) => Text(
                  b.pastorId.isEmpty
                      ? 'Not assigned'
                      : ref.watch(memberNameProvider(b.pastorId)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: (b.pastorId.isEmpty)
                            ? FontStyle.italic
                            : FontStyle.normal,
                      ),
                ),
              ),
              TableColumn<Branch>(
                id: 'members',
                header: 'Members',
                width: 92,
                sortValue: (b) =>
                    members.where((m) => m.branchId == b.id).length,
                cell: (b) => Text(
                  Fmt.number(members.where((m) => m.branchId == b.id).length),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TableColumn<Branch>(
                id: 'status',
                header: 'Status',
                width: 128,
                sortValue: (b) => b.status.label,
                cell: (b) => StatusBadge(
                  label: b.status.label,
                  tone: switch (b.status) {
                    BranchStatus.active => StatusTone.success,
                    BranchStatus.planting => StatusTone.info,
                    BranchStatus.dormant => StatusTone.neutral,
                  },
                ),
              ),
              TableColumn<Branch>(
                id: 'actions',
                header: '',
                width: 116,
                cell: (b) => RowActions(
                  onView: () => _showBranch(context, ref, b),
                  onEdit: canEdit
                      ? () => showBranchLeadershipForm(context, branch: b)
                      : null,
                  onDelete: canEdit && !b.isHeadquarters
                      ? () => _deleteBranch(context, ref, b)
                      : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  int _latestTotal(List<AttendanceRecord> records) {
    if (records.isEmpty) return 0;
    final latest =
        records.map((r) => r.date).reduce((a, b) => a.isAfter(b) ? a : b);
    return records
        .where((r) => r.date == latest)
        .fold(0, (sum, r) => sum + r.total);
  }
}void _showBranch(BuildContext context, WidgetRef ref, Branch branch) {
  final members =
      ref.read(membersProvider).where((m) => m.branchId == branch.id).toList();
  final departments = ref
      .read(departmentsProvider)
      .where((d) => d.branchId == branch.id)
      .toList();
  final attendance = ref
      .read(attendanceRecordsProvider)
      .where((r) => r.branchId == branch.id)
      .toList();
  final giving = ref
      .read(donationsProvider)
      .where((d) => d.branchId == branch.id)
      .fold(0.0, (sum, d) => sum + d.amount);
  final canEdit = ref.read(canEditProvider('Branches'));

  showDetailSheet<void>(
    context,
    title: branch.name,
    subtitle: branch.address.full.isEmpty
        ? branch.code
        : '${branch.code} · ${branch.address.full}',
    children: [
      DetailRows(entries: {
        'Status': branch.status.label,
        if (branch.isHeadquarters) 'Role': 'Headquarters',
        'Established': Fmt.date(branch.establishedAt),
        'Branch pastor': branch.pastorId.isEmpty
            ? 'Not assigned'
            : ref.read(memberNameProvider(branch.pastorId)),
        'Assistant pastor': (branch.assistantPastorId ?? '').isEmpty
            ? ''
            : ref.read(memberNameProvider(branch.assistantPastorId)),
        'Members': Fmt.number(members.length),
        'Departments': '${departments.length}',
        'Services recorded': '${attendance.length}',
        'Total giving': Fmt.currency(giving),
      }),
    ],
    actions: [
      if (canEdit)
        OutlinedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
            showBranchLeadershipForm(context, branch: branch);
          },
          icon: const Icon(Icons.edit_outlined, size: 16),
          label: const Text('Edit leadership'),
        ),
      FilledButton.icon(
        onPressed: () {
          ref.read(selectedBranchProvider.notifier).select(branch.id);
          Navigator.of(context).pop();
          showLocalSuccess(context, 'Now viewing ${branch.name}.');
        },
        icon: const Icon(Icons.filter_center_focus, size: 16),
        label: const Text('Focus this branch'),
      ),
    ],
  );
}

Future<void> _deleteBranch(
  BuildContext context,
  WidgetRef ref,
  Branch branch,
) async {
  final members =
      ref.read(membersProvider).where((m) => m.branchId == branch.id).length;

  final ok = await confirmDelete(
    context,
    what: branch.name,
    consequence: members == 0
        ? 'The branch has no members, so nothing else is affected.'
        : 'This branch still has $members member(s). They will remain in the '
            'database but will no longer belong to a visible branch — move them '
            'first if you want them kept.',
  );
  if (!ok || !context.mounted) return;

  await ref.read(repositoryProvider).deleteBranch(branch.id);
  if (!context.mounted) return;
  showLocalSuccess(context, '${branch.name} removed.');
}
