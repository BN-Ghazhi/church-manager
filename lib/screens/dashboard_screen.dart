import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/charts.dart';
import '../widgets/event_tile.dart';
import '../widgets/page_header.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_badge.dart';

/// Keyed by the stat's id, not its position: cards belonging to switched-off
/// modules are filtered out, and a positional list would then hand the wrong
/// icon to every card after the gap.
const _kpiIcons = <String, IconData>{
  'members': Icons.people_outline,
  'attendance': Icons.how_to_reg_outlined,
  'giving': Icons.payments_outlined,
  'departments': Icons.hub_outlined,
};

/// Cards that only make sense while their module is switched on.
const _kpiModules = <String, String>{
  'giving': 'Giving & Finance',
};

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(kpiStatsProvider).where((s) {
      final module = _kpiModules[s.id];
      return module == null || ref.watch(canViewProvider(module));
    }).toList();
    final events = ref.watch(upcomingEventsProvider).take(5).toList();
    final care = ref
        .watch(careRequestsProvider)
        .where((c) => c.status != CareStatus.resolved)
        .take(5)
        .toList();
    final slots = ref.watch(volunteerSlotsProvider);
    final openSlots =
        slots.where((s) => s.status != SlotStatus.filled).take(5).toList();
    final filled = slots.where((s) => s.status == SlotStatus.filled).length;
    final consolidated = ref.watch(isConsolidatedViewProvider);
    final user = ref.watch(currentUserProvider);
    final scope = ref.watch(scopeDescriptionProvider);

    return PageBody(
      children: [
        PageHeader(
          title: 'Welcome back, ${user.name.split(' ').first}',
          description: consolidated
              ? 'Consolidated across $scope. Use the branch switcher to focus one campus.'
              : 'How $scope is doing this week across people, attendance and departments.',
          actions: [
            OutlinedButton.icon(
              onPressed: () => context.go('/reports'),
              icon: const Icon(Icons.download_outlined, size: 17),
              label: const Text('Export'),
            ),
            FilledButton.icon(
              onPressed: () => context.go('/members'),
              icon: const Icon(Icons.add, size: 17),
              label: const Text('Add member'),
            ),
          ],
        ),

        ResponsiveGrid(
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            for (final stat in stats)
              StatCard.fromStat(
                stat,
                icon: _kpiIcons[stat.id] ?? Icons.insights_outlined,
              ),
          ],
        ),

        SplitRow(
          primary: SectionCard(
            title: 'Attendance trend',
            description: 'In-person versus online across the last twelve services.',
            action: TextButton(
              onPressed: () => context.go('/attendance'),
              child: const Text('Details'),
            ),
            child: TrendChart(
              data: ref.watch(attendanceTrendProvider),
              valueLabel: 'In person',
              compareLabel: 'Online',
            ),
          ),
          secondary: SectionCard(
            title: 'Membership journey',
            description: 'How visitors progress into serving members.',
            child: _Funnel(steps: ref.watch(growthFunnelProvider)),
          ),
        ),

        // Belongs to a switched-off module, so it goes when the module does.
        if (ref.watch(canViewProvider('Giving & Finance')))
          SplitRow(
            primary: SectionCard(
              title: 'Income and expenses',
              description: 'Twelve-month view of total giving against expenditure.',
              action: TextButton(
                onPressed: () => context.go('/finance'),
                child: const Text('Open finance'),
              ),
              child: TrendChart(
                data: ref.watch(financeTrendProvider),
                valueLabel: 'Income',
                compareLabel: 'Expenses',
                format: ValueFormat.currency,
              ),
            ),
            secondary: consolidated
                ? SectionCard(
                    title: 'Attendance by branch',
                    description: 'Last Sunday, every campus in view.',
                    child: CategoryBarChart(
                      data: ref.watch(attendanceByBranchProvider),
                      height: 230,
                    ),
                  )
                : SectionCard(
                    title: 'Gender split',
                    description: 'Across this branch.',
                    child: DonutChart(data: ref.watch(genderSplitProvider)),
                  ),
          ),

        ResponsiveGrid(
          minItemWidth: 340,
          maxColumns: 3,
          children: [
            SectionCard(
              title: 'Age distribution',
              description: 'Congregation by age bracket.',
              child: CategoryBarChart(
                data: ref.watch(ageDistributionProvider),
                height: 230,
              ),
            ),
            SectionCard(
              title: 'Upcoming events',
              description: 'The next five items on the church calendar.',
              action: TextButton(
                onPressed: () => context.go('/events'),
                child: const Text('Calendar'),
              ),
              child: Column(
                children: [
                  for (final event in events) EventTile(event: event),
                ],
              ),
            ),
            SectionCard(
              title: 'Recent activity',
              description: 'What your team has been doing.',
              child: _ActivityFeed(
                entries: ref.watch(recentActivityProvider).take(6).toList(),
              ),
            ),
          ],
        ),

        // Pastoral Care and Volunteers are both switched off; when either
        // returns this row comes back with it.
        if (ref.watch(canViewProvider('Pastoral Care')) ||
            ref.watch(canViewProvider('Volunteers')))
          SplitRow(
            primaryFlex: 1,
            secondaryFlex: 1,
            primary: SectionCard(
              title: 'Care requests needing attention',
              description: 'Open and in-progress pastoral care.',
              action: TextButton(
                onPressed: () => context.go('/care'),
                child: const Text('All requests'),
              ),
              child: Column(
                children: [
                  for (final request in care)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm + 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  ref.watch(memberNameProvider(request.memberId)),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${request.type.label} · ${request.summary}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          StatusBadge.of(request.priority),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            secondary: SectionCard(
              title: 'Rota gaps',
              description: 'Serving slots still unfilled for coming services.',
              action: TextButton(
                onPressed: () => context.go('/volunteers'),
                child: const Text('Manage rota'),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final slot in openSlots)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm + 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  slot.role.label,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${slot.serviceName} · ${Fmt.date(slot.date)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          StatusBadge.of(slot.status),
                        ],
                      ),
                    ),
                  const Divider(),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '$filled of ${slots.length} slots filled across the next four Sundays.',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
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

/// Membership journey as proportional bars, with the conversion rate from the
/// previous stage shown inline.
class _Funnel extends StatelessWidget {
  const _Funnel({required this.steps});

  final List<CategoryPoint> steps;

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final top = steps.first.value;

    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        steps[i].label,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    Text(
                      Fmt.number(steps[i].value),
                      style: theme.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    // On an empty database every stage is zero, and 0/0 is NaN
                    // — which throws on .round() rather than printing oddly.
                    if (i > 0 && steps[i - 1].value > 0) ...[
                      const SizedBox(width: 6),
                      Text(
                        '${(steps[i].value / steps[i - 1].value * 100).round()}%',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: top == 0 ? 0 : steps[i].value / top,
                    minHeight: 7,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ActivityFeed extends StatelessWidget {
  const _ActivityFeed({required this.entries});

  final List<ActivityEntry> entries;

  static (IconData, Color) _meta(ActivityKind kind) => switch (kind) {
        ActivityKind.member => (Icons.person_add_outlined, AppTheme.info),
        ActivityKind.donation => (Icons.payments_outlined, AppTheme.success),
        ActivityKind.event => (Icons.event_outlined, AppTheme.violet),
        ActivityKind.care => (Icons.volunteer_activism_outlined, AppTheme.danger),
        ActivityKind.message => (Icons.campaign_outlined, AppTheme.warning),
        ActivityKind.volunteer => (Icons.assignment_outlined, AppTheme.cyan),
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        for (final entry in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(builder: (context) {
                  final (icon, color) = _meta(entry.kind);
                  return Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 15, color: color),
                  );
                }),
                const SizedBox(width: AppSpacing.sm + 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: theme.textTheme.bodySmall,
                          children: [
                            TextSpan(
                              text: entry.actor,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: ' ${entry.action} ',
                              style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            TextSpan(
                              text: entry.target,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        Fmt.relative(entry.at, DateTime.utc(2026, 8, 14, 9)),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
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
