import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:go_router/go_router.dart';

import '../utils/clock.dart';
import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/data_table_view.dart';
import '../widgets/feedback.dart';
import '../widgets/member_form.dart';
import '../widgets/record_forms.dart';
import '../widgets/row_actions.dart';
import '../widgets/collapsible.dart';
import '../widgets/member_detail_sheet.dart';
import '../widgets/page_header.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/person_tile.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_badge.dart';
import '../utils/csv_export.dart';

/// The directory, with leadership on its own tab.
///
/// Leaders are the same members, so they belong on this page rather than a
/// separate screen — but "who leads what" is a different question from "find me
/// a person", and mixing them made both harder. The Pastors tab answers the
/// first, and it derives its list from the branches, departments and groups
/// themselves, so it can never disagree with them.
class MembersScreen extends ConsumerStatefulWidget {
  const MembersScreen({super.key});

  @override
  ConsumerState<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends ConsumerState<MembersScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final leaders = ref.watch(leadersProvider);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: TabBar(
              controller: _tabs,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              labelColor: scheme.primary,
              unselectedLabelColor: scheme.onSurfaceVariant,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                const Tab(
                    icon: Icon(Icons.people_outline, size: 18),
                    text: 'Directory'),
                Tab(
                  icon: const Icon(Icons.workspace_premium_outlined, size: 18),
                  text: 'Pastors & leaders (${leaders.length})',
                ),
              ],
            ),
          ),
        ),
        Divider(height: 1, color: scheme.outlineVariant.withValues(alpha: 0.6)),
        Expanded(
          child: TabBarView(
            controller: _tabs,
            children: const [_DirectoryTab(), _LeadersTab()],
          ),
        ),
      ],
    );
  }
}

class _DirectoryTab extends ConsumerWidget {
  const _DirectoryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersProvider);
    final families = ref.watch(familiesProvider);
    final consolidated = ref.watch(isConsolidatedViewProvider);
    final active = members.where((m) => m.status == MemberStatus.active).length;
    final visitors =
        members.where((m) => m.status == MemberStatus.visitor).length;
    final baptised = members.where((m) => m.isBaptized).length;

    return PageBody(
      children: [
        PageHeader(
          title: 'Members',
          description:
              'The complete directory — search, filter and open any profile for full history.',
          actions: [
            OutlinedButton.icon(
              onPressed: () async {
                // Exports exactly what the user can see — the scoped list, not
                // the whole table.
                final csv = CsvExport.buildCsv(
                  headers: const [
                    'First name', 'Last name', 'Email', 'Phone', 'Gender',
                    'Date of birth', 'Marital status', 'Status', 'Joined',
                    'Branch', 'Address', 'City', 'Region', 'Baptised', 'Tags',
                  ],
                  rows: [
                    for (final m in members)
                      [
                        m.firstName, m.lastName, m.email, m.phone,
                        m.gender.label,
                        m.dateOfBirth.toIso8601String().split('T').first,
                        m.maritalStatus.label, m.status.label,
                        m.joinedAt.toIso8601String().split('T').first,
                        ref.read(branchNameProvider(m.branchId)),
                        m.address.line1, m.address.city, m.address.region,
                        m.isBaptized ? 'Yes' : 'No',
                        m.tags.join('; '),
                      ],
                  ],
                );
                final path = await CsvExport.write('members', csv);
                if (!context.mounted) return;
                showLocalSuccess(
                  context,
                  path == null
                      ? 'Export is only available on desktop.'
                      : 'Exported ${members.length} members to $path',
                );
              },
              icon: const Icon(Icons.download_outlined, size: 17),
              label: const Text('Export CSV'),
            ),
          ],
        ),
        StatRow(
          sectionKey: 'members.stats',
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Total on file',
              value: Fmt.number(members.length),
              hint: 'all statuses',
              icon: Icons.people_outline,
              accent: AppTheme.info,
            ),
            StatCard(
              label: 'Active members',
              value: Fmt.number(active),
              hint: '${Fmt.share(active, members.length)} of directory',
              icon: Icons.verified_outlined,
            ),
            StatCard(
              label: 'Visitors to follow up',
              value: Fmt.number(visitors),
              hint: 'awaiting contact',
              icon: Icons.person_add_outlined,
            ),
            LinkedStatCard(
              label: 'Families registered',
              value: Fmt.number(families.length),
              hint: '${Fmt.number(baptised)} baptised members',
              icon: Icons.family_restroom_outlined,
              accent: AppTheme.violet,
              route: '/departments',
              module: 'Departments',
              tooltip: 'Open departments',
            ),
          ],
        ),
        SectionCard(
          title: 'Member directory',
          description:
              '${Fmt.number(members.length)} records. Select a row to open the full profile.',
          child: DataTableView<Member>(
            rows: members,
            rowId: (m) => m.id,
            pageSize: 12,
            // Newest members first, so someone just added is on screen. The
            // Member column still sorts alphabetically when the header is
            // clicked, which is what a directory lookup needs.
            initialSortId: 'joined',
            initialSortDescending: true,
            searchHint: 'Search by name, email or phone…',
            searchable: (m) =>
                '${m.fullName} ${m.email} ${m.phone} ${m.address.city}'
                ' ${m.address.region} ${m.tags.join(' ')}',
            onRowTap: (m) => context.go('/members/${m.id}'),
            toolbarAction: FilledButton.icon(
              onPressed: () => showMemberForm(context),
              icon: const Icon(Icons.add, size: 17),
              label: const Text('Add member'),
            ),
            filters: [
              TableFilter<Member>(
                id: 'status',
                label: 'Status',
                options: MemberStatus.values.map((s) => s.label).toList(),
                matches: (m, v) => m.status.label == v,
              ),
              TableFilter<Member>(
                id: 'gender',
                label: 'Gender',
                options: Gender.values.map((g) => g.label).toList(),
                matches: (m, v) => m.gender.label == v,
              ),
              if (consolidated)
                TableFilter<Member>(
                  id: 'branch',
                  label: 'Branch',
                  options: ref
                      .watch(visibleBranchesProvider)
                      .map((b) => b.name)
                      .toList(),
                  matches: (m, v) =>
                      ref.read(branchByIdProvider(m.branchId))?.name == v,
                ),
              TableFilter<Member>(
                id: 'baptism',
                label: 'Baptism',
                options: const ['Baptised', 'Not baptised'],
                matches: (m, v) => m.isBaptized == (v == 'Baptised'),
              ),
            ],
            columns: [
              TableColumn<Member>(
                id: 'name',
                header: 'Member',
                flex: 3,
                sortValue: (m) => '${m.lastName} ${m.firstName}',
                cell: (m) => PersonTile(name: m.fullName, secondary: m.email),
              ),
              TableColumn<Member>(
                id: 'phone',
                header: 'Phone',
                flex: 2,
                hideOnNarrow: true,
                cell: (m) => Text(m.phone,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              TableColumn<Member>(
                id: 'age',
                header: 'Age',
                width: 60,
                hideOnNarrow: true,
                sortValue: (m) => m.ageAt(appNow()),
                cell: (m) => Text('${m.ageAt(appNow())}',
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              TableColumn<Member>(
                id: 'city',
                header: 'City',
                flex: 2,
                hideOnNarrow: true,
                sortValue: (m) => m.address.city,
                cell: (m) => Text(m.address.city,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              TableColumn<Member>(
                id: 'joined',
                header: 'Joined',
                flex: 2,
                hideOnNarrow: true,
                sortValue: (m) => m.joinedAt,
                cell: (m) => Text(Fmt.date(m.joinedAt),
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              if (consolidated)
                TableColumn<Member>(
                  id: 'branch',
                  header: 'Branch',
                  width: 92,
                  sortValue: (m) => m.branchId,
                  cell: (m) => Text(
                    ref.read(branchByIdProvider(m.branchId))?.code ?? '—',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              TableColumn<Member>(
                id: 'status',
                header: 'Status',
                width: 118,
                sortValue: (m) => m.status.label,
                cell: (m) => StatusBadge.of(m.status),
              ),
              TableColumn<Member>(
                id: 'actions',
                header: '',
                width: 116,
                cell: (m) => RowActions(
                  onView: () => showMemberDetail(context, ref, m),
                  onEdit: () => showMemberForm(context, member: m),
                  onDelete: () => _deleteMember(context, ref, m),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Everyone who leads something, and what they lead.
class _LeadersTab extends ConsumerWidget {
  const _LeadersTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaders = ref.watch(leadersProvider);
    final posts = ref.watch(leadershipPostsProvider);
    final canEdit = ref.watch(canEditProvider('Members'));
    final theme = Theme.of(context);

    int countOf(LeadershipRole role) =>
        posts.where((p) => p.role == role).length;

    return PageBody(
      children: [
        PageHeader(
          title: 'Pastors & leaders',
          description:
              'Everyone holding a post, drawn from the branches, departments and '
              'groups themselves — so this list is never out of step with them.',
          actions: [
            if (canEdit)
              FilledButton.icon(
                onPressed: () => showLeadershipForm(context),
                icon: const Icon(Icons.add, size: 17),
                label: const Text('Appoint a leader'),
              ),
          ],
        ),
        StatRow(
          sectionKey: 'members.leaders.stats',
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'People leading',
              value: '${leaders.length}',
              hint: '${posts.length} posts in total',
              icon: Icons.workspace_premium_outlined,
              accent: AppTheme.violet,
            ),
            StatCard(
              label: 'Branch pastors',
              value: '${countOf(LeadershipRole.branchPastor)}',
              hint: '${countOf(LeadershipRole.assistantPastor)} assistants',
              icon: Icons.church_outlined,
            ),
            LinkedStatCard(
              label: 'Department heads',
              value: '${countOf(LeadershipRole.departmentHead)}',
              hint:
                  '${countOf(LeadershipRole.assistantDepartmentHead)} assistants',
              icon: Icons.groups_outlined,
              route: '/departments',
              module: 'Departments',
              tooltip: 'Open departments',
            ),
            StatCard(
              label: 'Group leaders',
              value: '${countOf(LeadershipRole.groupLeader)}',
              hint: 'small groups',
              icon: Icons.diversity_3_outlined,
            ),
          ],
        ),
        SectionCard(
          title: 'Leadership',
          description: leaders.isEmpty
              ? 'Nobody holds a post yet.'
              : 'One row per person. Someone holding two posts shows both.',
          child: leaders.isEmpty
              ? EmptyState(
                  title: 'No leaders appointed',
                  description: canEdit
                      ? 'Use "Appoint a leader" once you have members and a '
                          'branch, department or group for them to lead.'
                      : 'Nobody has been appointed to a post yet.',
                  icon: Icons.workspace_premium_outlined,
                )
              : DataTableView<({Member member, List<LeadershipPost> posts})>(
                  rows: leaders,
                  rowId: (r) => r.member.id,
                  pageSize: 12,
                  searchHint: 'Search by name or what they lead…',
                  searchable: (r) =>
                      '${r.member.fullName} '
                      '${r.posts.map((p) => '${p.role.label} ${p.scopeName}').join(' ')}',
                  onRowTap: (r) => showMemberDetail(context, ref, r.member),
                  filters: [
                    TableFilter<({Member member, List<LeadershipPost> posts})>(
                      id: 'role',
                      label: 'Post',
                      options:
                          LeadershipRole.values.map((r) => r.label).toList(),
                      matches: (r, v) =>
                          r.posts.any((p) => p.role.label == v),
                    ),
                  ],
                  columns: [
                    TableColumn<({Member member, List<LeadershipPost> posts})>(
                      id: 'name',
                      header: 'Leader',
                      flex: 3,
                      sortValue: (r) => r.member.lastName,
                      cell: (r) => PersonTile(
                        name: r.member.fullName,
                        secondary: r.member.phone.isEmpty
                            ? r.member.email
                            : r.member.phone,
                      ),
                    ),
                    TableColumn<({Member member, List<LeadershipPost> posts})>(
                      id: 'posts',
                      header: 'Leads',
                      flex: 4,
                      cell: (r) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (final post in r.posts.take(3))
                            Text(
                              '${post.role.label} · ${post.scopeName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: post.role.isPastoral
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurfaceVariant,
                                fontWeight: post.role.isPastoral
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          if (r.posts.length > 3)
                            Text('+ ${r.posts.length - 3} more',
                                style: theme.textTheme.labelSmall),
                        ],
                      ),
                    ),
                    TableColumn<({Member member, List<LeadershipPost> posts})>(
                      id: 'branch',
                      header: 'Branch',
                      flex: 2,
                      hideOnNarrow: true,
                      cell: (r) => Text(
                        ref.watch(branchNameProvider(r.member.branchId)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    TableColumn<({Member member, List<LeadershipPost> posts})>(
                      id: 'actions',
                      header: '',
                      width: 116,
                      cell: (r) => RowActions(
                        onView: () => showMemberDetail(context, ref, r.member),
                        onEdit: canEdit
                            ? () => showLeadershipForm(
                                  context,
                                  role: r.posts.first.role,
                                  memberId: r.member.id,
                                )
                            : null,
                        // Removing a post is done by reassigning it, from the
                        // branch, department or group that owns it. A delete
                        // here would look like it removes the person.
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

Future<void> _deleteMember(
  BuildContext context,
  WidgetRef ref,
  Member member,
) async {
  final ok = await confirmDelete(
    context,
    what: member.fullName,
    consequence:
        'Their giving history and attendance stay in the records for reporting, '
        'but they will no longer appear in the directory.',
  );
  if (!ok || !context.mounted) return;

  await ref.read(repositoryProvider).deleteMember(member.id);
  if (!context.mounted) return;
  showLocalSuccess(context, '${member.fullName} removed from the directory.');
}
