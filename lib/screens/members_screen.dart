import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:go_router/go_router.dart';

import '../data/seed.dart';
import '../models/models.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../utils/formatters.dart';
import '../widgets/data_table_view.dart';
import '../widgets/feedback.dart';
import '../widgets/member_form.dart';
import '../widgets/page_header.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/person_tile.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_badge.dart';
import '../utils/csv_export.dart';

class MembersScreen extends ConsumerWidget {
  const MembersScreen({super.key});

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
                    'Branch', 'Address', 'City', 'Baptised', 'Tags',
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
                        m.address.line1, m.address.city,
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
        ResponsiveGrid(
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Total on file',
              value: Fmt.number(members.length),
              delta: 4.8,
              hint: 'all statuses',
              icon: Icons.people_outline,
            ),
            StatCard(
              label: 'Active members',
              value: Fmt.number(active),
              delta: 3.1,
              hint: '${(active / members.length * 100).round()}% of directory',
              icon: Icons.verified_outlined,
            ),
            StatCard(
              label: 'Visitors to follow up',
              value: Fmt.number(visitors),
              delta: 12.4,
              hint: 'awaiting contact',
              icon: Icons.person_add_outlined,
            ),
            StatCard(
              label: 'Families registered',
              value: Fmt.number(families.length),
              delta: 0,
              hint: '${Fmt.number(baptised)} baptised members',
              icon: Icons.family_restroom_outlined,
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
                '${m.fullName} ${m.email} ${m.phone} ${m.address.city} ${m.tags.join(' ')}',
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
                sortValue: (m) => m.ageAt(kDemoNow),
                cell: (m) => Text('${m.ageAt(kDemoNow)}',
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
            ],
          ),
        ),
      ],
    );
  }
}
