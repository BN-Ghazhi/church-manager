import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../widgets/collapsible.dart';
import '../utils/clock.dart';
import '../models/models.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../shell/branch_switcher.dart' show accentColor;
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/charts.dart';
import '../widgets/department_form.dart';
import '../widgets/page_header.dart';
import '../widgets/record_forms.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/person_tile.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_badge.dart';

/// Icon for a department type, resolved from the catalogue's icon token.
IconData departmentIcon(String token) => switch (token) {
      'youth' => Icons.diversity_3,
      'children' => Icons.child_care,
      'worship' => Icons.music_note,
      'ushering' => Icons.co_present,
      'media' => Icons.videocam,
      'evangelism' => Icons.campaign,
      'prayer' => Icons.self_improvement,
      'welfare' => Icons.favorite,
      _ => Icons.groups,
    };

class DepartmentsScreen extends ConsumerWidget {
  const DepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departments = ref.watch(departmentsProvider);
    final types = ref.watch(departmentTypesProvider);
    final consolidated = ref.watch(isConsolidatedViewProvider);
    final canEdit = ref.watch(canEditProvider('Departments'));

    final serving = departments.fold(0, (sum, d) => sum + d.memberCount);
    final typesRunning =
        departments.map((d) => d.typeId).toSet().length;

    return PageBody(
      children: [
        PageHeader(
          title: 'Departments',
          description: consolidated
              ? 'Every department across the branches in view. Youth and Children run at every branch; totals roll up because all branches share one catalogue.'
              : 'Departments running at this branch, with their heads and members.',
          actions: [
            if (canEdit) ...[
              OutlinedButton.icon(
                onPressed: () => showDepartmentTypeForm(context),
                icon: const Icon(Icons.category_outlined, size: 17),
                label: const Text('New type'),
              ),
              FilledButton.icon(
                onPressed: () => showDepartmentForm(context),
                icon: const Icon(Icons.add, size: 17),
                label: const Text('Start a department'),
              ),
            ],
          ],
        ),

        StatRow(
          sectionKey: 'departments.stats',
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Departments running',
              value: '${departments.length}',
              hint: consolidated ? 'across branches in view' : 'at this branch',
              icon: Icons.groups_outlined,
            ),
            StatCard(
              label: 'People serving',
              value: Fmt.number(serving),
              hint: 'department members',
              icon: Icons.people_outline,
            ),
            StatCard(
              label: 'Types in the catalogue',
              value: '${types.length}',
              hint: '$typesRunning in use here',
              icon: Icons.category_outlined,
            ),
            StatCard(
              label: 'Average size',
              value: departments.isEmpty
                  ? '—'
                  : Fmt.number(serving ~/ departments.length),
              hint: 'members per department',
              icon: Icons.equalizer,
            ),
          ],
        ),

        // Cross-branch roll-up — the payoff of a shared catalogue.
        if (consolidated)
          SectionCard(
            title: 'Department strength across branches',
            description:
                'Because every branch draws from the same catalogue, the same department is directly comparable between campuses.',
            child: CategoryBarChart(
              data: [
                for (final type in types)
                  CategoryPoint(
                    label: type.name,
                    value: departments
                        .where((d) => d.typeId == type.id)
                        .fold(0, (sum, d) => sum + d.memberCount)
                        .toDouble(),
                  ),
              ]..sort((a, b) => b.value.compareTo(a.value)),
              horizontal: true,
              height: 290,
            ),
          ),

        if (departments.isEmpty)
          const SectionCard(
            title: 'No departments yet',
            child: EmptyState(
              title: 'Nothing running here',
              description:
                  'Start a department from the catalogue to give this branch its Youth, Children and other teams.',
              icon: Icons.groups_outlined,
            ),
          )
        else
          ResponsiveGrid(
            minItemWidth: 380,
            maxColumns: 2,
            children: [
              for (final department in _sorted(departments, types))
                _DepartmentCard(
                  department: department,
                  showBranch: consolidated,
                ),
            ],
          ),
      ],
    );
  }

  /// Core departments first (Youth, Children), then the rest — grouped so the
  /// two you care most about are always at the top.
  List<Department> _sorted(
      List<Department> departments, List<DepartmentType> types) {
    final order = {
      for (var i = 0; i < types.length; i++) types[i].id: i,
    };
    return [...departments]..sort((a, b) {
        final ta = order[a.typeId] ?? 99;
        final tb = order[b.typeId] ?? 99;
        if (ta != tb) return ta.compareTo(tb);
        return a.branchId.compareTo(b.branchId);
      });
  }
}

class _DepartmentCard extends ConsumerWidget {
  const _DepartmentCard({required this.department, required this.showBranch});

  final Department department;
  final bool showBranch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final type = ref.watch(departmentTypeByIdProvider(department.typeId));
    final branch = ref.watch(branchByIdProvider(department.branchId));
    final members = ref.watch(departmentMembersProvider(department.id));
    final canEdit = ref.watch(canEditProvider('Departments'));

    if (type == null) return const SizedBox.shrink();
    final accent = accentColor(type.accent);

    return SectionCard(
      title: type.name,
      description: showBranch && branch != null
          ? '${branch.name} · ${department.meetingDay.label}s at ${department.meetingTime}'
          : '${department.meetingDay.label}s at ${department.meetingTime}',
      action: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Icon(departmentIcon(type.icon), size: 17, color: accent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              if (branch != null)
                StatusBadge(
                  label: branch.code,
                  tone: StatusTone.neutral,
                  showDot: false,
                ),
              if (type.isCore)
                const StatusBadge(
                  label: 'Core',
                  tone: StatusTone.info,
                  showDot: false,
                ),
              if (type.ageRange != null)
                StatusBadge(
                  label: 'Ages ${type.ageRange!.min}–${type.ageRange!.max}',
                  tone: StatusTone.neutral,
                  showDot: false,
                ),
              StatusBadge(
                label: '${department.memberCount} members',
                tone: StatusTone.success,
                showDot: false,
              ),
            ],
          ),
          const Divider(height: AppSpacing.lg),

          // Leadership
          PersonTile(
            name: ref.watch(memberNameProvider(department.headId)),
            secondary: 'Department head',
            compact: true,
          ),
          if (department.assistantHeadId != null) ...[
            const SizedBox(height: AppSpacing.sm),
            PersonTile(
              name: ref.watch(memberNameProvider(department.assistantHeadId)),
              secondary: 'Assistant head',
              compact: true,
            ),
          ],
          const Divider(height: AppSpacing.lg),

          // Members drawn from this branch's roll
          Text(
            'Members — drawn from ${branch?.name ?? 'this branch'}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (members.isEmpty)
            Text('No members yet.',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant))
          else
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final m in members.take(8))
                  Chip(
                    label: Text(
                      '${m.firstName} ${m.lastName[0]}.',
                      style: theme.textTheme.labelSmall,
                    ),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: scheme.surfaceContainerHighest,
                    avatar: CircleAvatar(
                      backgroundColor: accent.withValues(alpha: 0.15),
                      child: Text(
                        m.firstName[0],
                        style: theme.textTheme.labelSmall
                            ?.copyWith(color: accent, fontSize: 9),
                      ),
                    ),
                  ),
                if (members.length > 8)
                  Chip(
                    label: Text('+${members.length - 8} more',
                        style: theme.textTheme.labelSmall),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: scheme.outlineVariant),
                  ),
              ],
            ),

          if (canEdit) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () => showDepartmentMemberPicker(
                    context,
                    department: department,
                    typeName: type.name,
                  ),
                  icon: const Icon(Icons.person_add_outlined, size: 15),
                  label: const Text('Manage members'),
                ),
                const SizedBox(width: AppSpacing.sm),
                IconButton(
                  onPressed: () => showDepartmentEditForm(
                    context,
                    department: department,
                    typeName: type.name,
                  ),
                  icon: const Icon(Icons.edit_outlined, size: 17),
                  tooltip: 'Edit department',
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Age eligibility helper shared with the member picker.
bool isEligibleFor(Member member, DepartmentType type) {
  if (type.ageRange == null) return true;
  final age = member.ageAt(appNow());
  return age >= type.ageRange!.min && age <= type.ageRange!.max;
}
