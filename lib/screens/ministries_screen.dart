import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:go_router/go_router.dart';

import '../widgets/collapsible.dart';
import '../models/models.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/page_header.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/person_tile.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';

/// Accent colours are resolved here so ministry cards stay visually distinct.
Color _accentColor(AccentToken token) => switch (token) {
      AccentToken.blue => AppTheme.info,
      AccentToken.emerald => AppTheme.success,
      AccentToken.amber => AppTheme.warning,
      AccentToken.violet => AppTheme.violet,
      AccentToken.rose => AppTheme.danger,
      AccentToken.cyan => AppTheme.cyan,
    };

class MinistriesScreen extends ConsumerWidget {
  const MinistriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ministries = ref.watch(ministriesProvider);
    final groups = ref.watch(smallGroupsProvider);
    final serving = ministries.fold(0, (sum, m) => sum + m.memberCount);
    final inGroups = groups.fold(0, (sum, g) => sum + g.memberCount);
    final capacity = groups.fold(0, (sum, g) => sum + g.capacity);

    return PageBody(
      children: [
        PageHeader(
          title: 'Groups & Ministries',
          description:
              'Departments, home cells and the leaders responsible for each.',
          actions: [
            // Departments are the branch-aware model and roll up across
            // campuses; this screen is the older view kept for continuity.
            OutlinedButton.icon(
              onPressed: () => context.go('/departments'),
              icon: const Icon(Icons.groups_outlined, size: 17),
              label: const Text('Go to Departments'),
            ),
          ],
        ),
        StatRow(
          sectionKey: 'ministries.stats',
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Ministries',
              value: '${ministries.length}',
              hint: 'active departments',
              icon: Icons.hub_outlined,
            ),
            StatCard(
              label: 'People serving',
              value: Fmt.number(serving),
              hint: 'across all ministries',
              icon: Icons.people_outline,
            ),
            StatCard(
              label: 'Small groups',
              value: '${groups.length}',
              hint: 'home cells meeting weekly',
              icon: Icons.place_outlined,
            ),
            StatCard(
              label: 'Group capacity used',
              value: Fmt.share(inGroups, capacity),
              hint: '$inGroups of $capacity seats',
              icon: Icons.chair_outlined,
            ),
          ],
        ),
        DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [Tab(text: 'Ministries'), Tab(text: 'Small groups')],
                ),
              ),
              const SizedBox(height: AppSpacing.md + 4),
              SizedBox(
                height: 640,
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: ResponsiveGrid(
                        minItemWidth: 320,
                        maxColumns: 3,
                        children: [
                          for (final m in ministries)
                            SectionCard(
                              title: m.name,
                              description: m.description,
                              action: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: _accentColor(m.accent)
                                      .withValues(alpha: 0.12),
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.md),
                                ),
                                child: Icon(Icons.hub,
                                    size: 17, color: _accentColor(m.accent)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PersonTile(
                                    name: ref.watch(
                                        memberNameProvider(m.leaderId)),
                                    secondary: 'Ministry leader',
                                    compact: true,
                                  ),
                                  const Divider(height: AppSpacing.lg),
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: [
                                      _chip(context, Icons.people_outline,
                                          '${m.memberCount} members'),
                                      _chip(context, Icons.schedule,
                                          '${m.meetingDay.label} · ${m.meetingTime}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: ResponsiveGrid(
                        minItemWidth: 320,
                        maxColumns: 3,
                        children: [
                          for (final g in groups)
                            SectionCard(
                              title: g.name,
                              description:
                                  '${g.meetingDay.label}s at ${g.meetingTime} · ${g.location}',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PersonTile(
                                    name: ref.watch(
                                        memberNameProvider(g.leaderId)),
                                    secondary: 'Cell leader',
                                    compact: true,
                                  ),
                                  const Divider(height: AppSpacing.lg),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text('Capacity',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall),
                                      ),
                                      Text(
                                        '${g.memberCount} / ${g.capacity}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: g.fillRate,
                                      minHeight: 7,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainerHighest,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    g.fillRate >= 0.9
                                        ? 'Nearly full — consider multiplying this cell.'
                                        : '${g.seatsAvailable} seats available.',
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
                        ],
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

  Widget _chip(BuildContext context, IconData icon, String label) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: scheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: scheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
