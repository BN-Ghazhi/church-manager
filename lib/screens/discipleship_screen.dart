import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../models/models.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/charts.dart';
import '../widgets/page_header.dart';
import '../widgets/record_forms.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/person_tile.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';

class DiscipleshipScreen extends ConsumerWidget {
  const DiscipleshipScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(coursesProvider);
    final enrolled = courses.fold(0, (s, c) => s + c.enrolled);
    final completed = courses.fold(0, (s, c) => s + c.completed);
    final lessons = courses.fold(0, (s, c) => s + c.lessons);
    final funnel = ref.watch(growthFunnelProvider);

    return PageBody(
      children: [
        PageHeader(
          title: 'Discipleship',
          description:
              'Courses and classes that move people from first visit to mature, serving membership.',
          actions: [
            FilledButton.icon(
              onPressed: () => showCourseForm(context),
              icon: const Icon(Icons.add, size: 17),
              label: const Text('New course'),
            ),
          ],
        ),
        ResponsiveGrid(
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Active courses',
              value: '${courses.length}',
              delta: 0,
              hint: '$lessons lessons in total',
              icon: Icons.menu_book_outlined,
            ),
            StatCard(
              label: 'Enrolled',
              value: Fmt.number(enrolled),
              delta: 13.9,
              hint: 'across all courses',
              icon: Icons.people_outline,
            ),
            StatCard(
              label: 'Completed',
              value: Fmt.number(completed),
              delta: 7.5,
              hint: 'finished every lesson',
              icon: Icons.workspace_premium_outlined,
            ),
            StatCard(
              label: 'Completion rate',
              value: '${(completed / enrolled * 100).round()}%',
              delta: 2.8,
              hint: 'enrolled who finish',
              icon: Icons.school_outlined,
            ),
          ],
        ),
        SplitRow(
          primary: SectionCard(
            title: 'Enrolment by course',
            description: 'Where people are choosing to grow.',
            child: CategoryBarChart(
              data: [
                for (final c in courses)
                  CategoryPoint(label: c.name, value: c.enrolled.toDouble()),
              ],
              horizontal: true,
              height: 280,
            ),
          ),
          secondary: SectionCard(
            title: 'Growth pathway',
            description: 'The intended journey through discipleship.',
            child: Column(
              children: [
                for (var i = 0; i < funnel.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text(
                            '${i + 1}',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm + 4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(funnel[i].label,
                                  style:
                                      Theme.of(context).textTheme.bodySmall),
                              Text('${Fmt.number(funnel[i].value)} people',
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        ResponsiveGrid(
          minItemWidth: 380,
          maxColumns: 2,
          children: [
            for (final c in courses)
              SectionCard(
                title: c.name,
                description: c.description,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PersonTile(
                      name: ref.watch(memberNameProvider(c.facilitatorId)),
                      secondary: 'Facilitator',
                      compact: true,
                    ),
                    const Divider(height: AppSpacing.lg),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${c.lessons} lessons · ${Fmt.number(c.enrolled)} enrolled',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                        Text(
                          '${(c.completionRate * 100).round()}% complete',
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
                        value: c.completionRate,
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
      ],
    );
  }
}
