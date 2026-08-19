import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

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
import '../widgets/status_badge.dart';
import '../widgets/rota_form.dart';

class VolunteersScreen extends ConsumerWidget {
  const VolunteersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slots = ref.watch(volunteerSlotsProvider);
    final filled = slots.where((s) => s.status == SlotStatus.filled).length;
    final open = slots.where((s) => s.status == SlotStatus.open).length;
    final declined = slots.where((s) => s.status == SlotStatus.declined).length;

    // Group by service date so each Sunday renders as its own rota card.
    final byDate = <DateTime, List<VolunteerSlot>>{};
    for (final slot in slots) {
      byDate.putIfAbsent(slot.date, () => []).add(slot);
    }
    final dates = byDate.keys.toList()..sort();

    // Coverage per role, in the enum's declared order.
    final roleCoverage = <ServingRole, (int filled, int total)>{};
    for (final slot in slots) {
      final current = roleCoverage[slot.role] ?? (0, 0);
      roleCoverage[slot.role] = (
        current.$1 + (slot.status == SlotStatus.filled ? 1 : 0),
        current.$2 + 1,
      );
    }

    return PageBody(
      children: [
        PageHeader(
          title: 'Volunteers',
          description:
              'Serving rotas for the next four Sundays — see gaps before they become problems.',
          actions: [
            FilledButton.icon(
              onPressed: () => showRotaSummary(context, slots),
              icon: const Icon(Icons.schedule_send_outlined, size: 17),
              label: const Text('Review rota'),
            ),
          ],
        ),
        StatRow(
          sectionKey: 'volunteers.stats',
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Rota coverage',
              value: Fmt.share(filled, slots.length),
              hint: '$filled of ${slots.length} slots',
              icon: Icons.how_to_reg_outlined,
            ),
            StatCard(
              label: 'Open slots',
              value: '$open',
              hint: 'need a volunteer',
              icon: Icons.error_outline,
              invertDelta: true,
            ),
            StatCard(
              label: 'Declined',
              value: '$declined',
              hint: 'volunteer unavailable',
              icon: Icons.person_off_outlined,
              invertDelta: true,
            ),
            StatCard(
              label: 'Serving roles',
              value: '${roleCoverage.length}',
              hint: 'across every service',
              icon: Icons.assignment_outlined,
            ),
          ],
        ),
        SectionCard(
          title: 'Coverage by role',
          description: 'Which teams are short of hands.',
          child: ResponsiveGrid(
            minItemWidth: 220,
            maxColumns: 4,
            children: [
              for (final entry in roleCoverage.entries)
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(entry.key.label,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                          ),
                          Text('${entry.value.$1}/${entry.value.$2}',
                              style: Theme.of(context).textTheme.labelSmall),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: entry.value.$1 / entry.value.$2,
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
        ResponsiveGrid(
          minItemWidth: 380,
          maxColumns: 2,
          children: [
            for (final date in dates)
              Builder(builder: (context) {
                final daySlots = byDate[date]!;
                final dayFilled =
                    daySlots.where((s) => s.status == SlotStatus.filled).length;

                return SectionCard(
                  title: Fmt.dateLong(date),
                  description:
                      '$dayFilled of ${daySlots.length} roles covered · ${daySlots.first.serviceName}',
                  child: Column(
                    children: [
                      for (final slot in daySlots)
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: AppSpacing.sm + 2),
                          child: Row(
                            children: [
                              Expanded(
                                child: slot.memberId != null
                                    ? PersonTile(
                                        name: ref.watch(memberNameProvider(
                                            slot.memberId)),
                                        secondary: slot.role.label,
                                        compact: true,
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(slot.role.label,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          Text('Nobody assigned',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall),
                                        ],
                                      ),
                              ),
                              StatusBadge.of(slot.status),
                              const SizedBox(width: AppSpacing.sm),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                icon: const Icon(Icons.person_add_outlined,
                                    size: 17),
                                tooltip: 'Assign someone',
                                onPressed: () =>
                                    showRotaAssignForm(context, slot: slot),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ],
    );
  }
}
