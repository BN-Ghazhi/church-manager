import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../config/app_config.dart';
import '../data/seed.dart';
import '../models/models.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/data_table_view.dart';
import '../widgets/event_tile.dart';
import '../widgets/page_header.dart';
import '../widgets/record_forms.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);
    final upcoming = ref.watch(upcomingEventsProvider);
    final recurring = events.where((e) => e.isRecurring).length;
    final registered = upcoming.fold(0, (s, e) => s + e.registeredCount);
    final expected = upcoming.fold(0, (s, e) => s + e.expectedAttendance);
    final announcements = [...ref.watch(announcementsProvider)]
      ..sort((a, b) => (b.pinned ? 1 : 0).compareTo(a.pinned ? 1 : 0));

    return PageBody(
      children: [
        PageHeader(
          title: 'Events',
          description:
              'The church calendar — services, rehearsals, outreaches and conferences.',
          actions: [
            FilledButton.icon(
              onPressed: () => showEventForm(context),
              icon: const Icon(Icons.add, size: 17),
              label: const Text('Create event'),
            ),
          ],
        ),
        ResponsiveGrid(
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Upcoming events',
              value: '${upcoming.length}',
              delta: 8.3,
              hint: 'in the next 35 days',
              icon: Icons.calendar_month_outlined,
            ),
            StatCard(
              label: 'Registrations',
              value: Fmt.number(registered),
              delta: 11.2,
              hint: '${(registered / expected * 100).round()}% of expected',
              icon: Icons.people_outline,
            ),
            StatCard(
              label: 'Recurring services',
              value: '$recurring',
              delta: 0,
              hint: 'repeat weekly',
              icon: Icons.repeat,
            ),
            StatCard(
              label: 'Weekly services',
              value: '${ChurchConfig.services.length}',
              delta: 0,
              hint: 'on the standing schedule',
              icon: Icons.event_repeat_outlined,
            ),
          ],
        ),
        SplitRow(
          primary: SectionCard(
            title: 'Next on the calendar',
            description: 'Everything scheduled from today onward.',
            child: Column(
              children: [for (final e in upcoming) EventTile(event: e)],
            ),
          ),
          secondary: SectionCard(
            title: 'Registration progress',
            description: 'How close each event is to its expected turnout.',
            child: Column(
              children: [
                for (final e in upcoming.take(6))
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(e.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.bodySmall),
                            ),
                            Text(
                              '${(e.registrationRate.clamp(0, 1) * 100).round()}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: e.registrationRate.clamp(0, 1).toDouble(),
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
        SectionCard(
          title: 'Event register',
          description: 'Past and future events with organiser and turnout.',
          child: DataTableView<ChurchEvent>(
            rows: events,
            rowId: (e) => e.id,
            pageSize: 10,
            searchHint: 'Search events by title or venue…',
            searchable: (e) => '${e.title} ${e.location}',
            filters: [
              TableFilter<ChurchEvent>(
                id: 'category',
                label: 'Category',
                options: EventCategory.values.map((c) => c.label).toList(),
                matches: (e, v) => e.category.label == v,
              ),
              TableFilter<ChurchEvent>(
                id: 'repeats',
                label: 'Repeats',
                options: const ['Recurring', 'One-off'],
                matches: (e, v) => e.isRecurring == (v == 'Recurring'),
              ),
            ],
            columns: [
              TableColumn<ChurchEvent>(
                id: 'title',
                header: 'Event',
                flex: 3,
                sortValue: (e) => e.title,
                cell: (e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(e.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    Text(e.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ),
              TableColumn<ChurchEvent>(
                id: 'category',
                header: 'Category',
                flex: 2,
                sortValue: (e) => e.category.label,
                cell: (e) => Text(e.category.label,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              TableColumn<ChurchEvent>(
                id: 'starts',
                header: 'Starts',
                flex: 3,
                hideOnNarrow: true,
                sortValue: (e) => e.startsAt,
                cell: (e) => Text(Fmt.dateTime(e.startsAt),
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              TableColumn<ChurchEvent>(
                id: 'organizer',
                header: 'Organiser',
                flex: 2,
                hideOnNarrow: true,
                cell: (e) => Text(
                  ref.watch(memberNameProvider(e.organizerId)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TableColumn<ChurchEvent>(
                id: 'registered',
                header: 'Registered',
                flex: 2,
                alignEnd: true,
                sortValue: (e) => e.registeredCount,
                cell: (e) => Text(
                  '${Fmt.number(e.registeredCount)} / ${Fmt.number(e.expectedAttendance)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        SplitRow(
          primary: SectionCard(
            title: 'Announcements',
            description: 'Notices published to the congregation.',
            child: Column(
              children: [
                for (final a in announcements)
                  Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.sm + 4),
                    padding: const EdgeInsets.all(AppSpacing.md),
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
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(a.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                            ),
                            if (a.pinned)
                              Icon(Icons.push_pin,
                                  size: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(a.body,
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 4),
                        Text(
                          '${ref.watch(memberNameProvider(a.authorId))} · '
                          '${Fmt.relative(a.postedAt, kDemoNow)}',
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
          secondary: SectionCard(
            title: 'Standing weekly schedule',
            description:
                'Recurring services that do not need creating each week.',
            child: Column(
              children: [
                for (final s in ChurchConfig.services)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(s.name,
                        style: Theme.of(context).textTheme.bodyMedium),
                    subtitle: Text(s.venue,
                        style: Theme.of(context).textTheme.labelSmall),
                    trailing: Text('${s.day} · ${s.time}',
                        style: Theme.of(context).textTheme.labelSmall),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
