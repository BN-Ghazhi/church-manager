import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../models/models.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../shell/branch_switcher.dart' show accentColor;
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/charts.dart';
import '../widgets/feedback.dart';
import '../widgets/page_header.dart';
import '../widgets/record_forms.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/person_tile.dart';
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

        ResponsiveGrid(
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Branches in view',
              value: '${branches.length}',
              delta: 0,
              hint: '$planting church plant${planting == 1 ? '' : 's'}',
              icon: Icons.account_tree_outlined,
            ),
            StatCard(
              label: 'Members across branches',
              value: Fmt.number(members.length),
              delta: 4.8,
              hint: 'all statuses',
              icon: Icons.people_outline,
            ),
            StatCard(
              label: 'Departments running',
              value: '${departments.length}',
              delta: 6.2,
              hint: 'across every branch',
              icon: Icons.groups_outlined,
            ),
            StatCard(
              label: 'Last Sunday, all branches',
              value: Fmt.number(_latestTotal(attendance)),
              delta: 2.4,
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

        ResponsiveGrid(
          minItemWidth: 380,
          maxColumns: 2,
          children: [
            for (final branch in branches)
              _BranchCard(branch: branch),
          ],
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
}

class _BranchCard extends ConsumerWidget {
  const _BranchCard({required this.branch});

  final Branch branch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final accent = accentColor(branch.accent);

    final members = ref
        .watch(membersProvider)
        .where((m) => m.branchId == branch.id)
        .toList();
    final departments = ref
        .watch(departmentsProvider)
        .where((d) => d.branchId == branch.id)
        .toList();
    final attendance = ref
        .watch(attendanceRecordsProvider)
        .where((r) => r.branchId == branch.id)
        .toList();
    final giving = ref
        .watch(donationsProvider)
        .where((d) => d.branchId == branch.id)
        .fold(0.0, (sum, d) => sum + d.amount);

    final lastService = attendance.isEmpty ? null : attendance.first;

    return SectionCard(
      title: branch.name,
      description: branch.address.full,
      action: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Text(
          branch.code,
          style: theme.textTheme.labelSmall
              ?.copyWith(color: accent, fontWeight: FontWeight.w800),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              StatusBadge(
                label: branch.status.label,
                tone: switch (branch.status) {
                  BranchStatus.active => StatusTone.success,
                  BranchStatus.planting => StatusTone.info,
                  BranchStatus.dormant => StatusTone.neutral,
                },
              ),
              if (branch.isHeadquarters)
                const StatusBadge(
                  label: 'Headquarters',
                  tone: StatusTone.warning,
                  showDot: false,
                ),
              StatusBadge(
                label: 'Est. ${branch.establishedAt.year}',
                tone: StatusTone.neutral,
                showDot: false,
              ),
            ],
          ),
          const Divider(height: AppSpacing.lg),

          // Leadership
          PersonTile(
            name: ref.watch(memberNameProvider(branch.pastorId)),
            secondary: 'Branch pastor',
            compact: true,
          ),
          if (branch.assistantPastorId != null) ...[
            const SizedBox(height: AppSpacing.sm),
            PersonTile(
              name: ref.watch(memberNameProvider(branch.assistantPastorId)),
              secondary: 'Assistant pastor',
              compact: true,
            ),
          ],
          const Divider(height: AppSpacing.lg),

          // Vital statistics
          Row(
            children: [
              _Metric(label: 'Members', value: Fmt.number(members.length)),
              _Metric(label: 'Departments', value: '${departments.length}'),
              _Metric(
                label: 'Last service',
                value: lastService == null
                    ? '—'
                    : Fmt.number(lastService.total),
              ),
              _Metric(label: 'Giving', value: Fmt.compactCurrency(giving)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () =>
                    showBranchLeadershipForm(context, branch: branch),
                icon: const Icon(Icons.manage_accounts_outlined, size: 16),
                label: const Text('Leadership'),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: () {
              ref.read(selectedBranchProvider.notifier).select(branch.id);
              showLocalSuccess(
                context,
                'Now viewing ${branch.name}. Use the branch switcher to go back.',
              );
            },
            icon: const Icon(Icons.filter_center_focus, size: 16),
            label: const Text('Focus this branch'),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          Text(
            label,
            style: theme.textTheme.labelSmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
