import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:go_router/go_router.dart';

import '../utils/clock.dart';
import '../models/models.dart';
import '../providers/photos.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/compose_form.dart';
import '../widgets/member_form.dart';
import '../widgets/page_header.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/person_tile.dart';
import '../widgets/section_card.dart';
import '../widgets/status_badge.dart';

class MemberDetailScreen extends ConsumerWidget {
  const MemberDetailScreen({super.key, required this.memberId});

  final String memberId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.watch(memberByIdProvider(memberId));

    if (member == null) {
      return PageBody(
        children: [
          const EmptyState(
            title: 'Member not found',
            description: 'This record may have been removed or merged.',
            icon: Icons.person_off_outlined,
          ),
          Center(
            child: OutlinedButton(
              onPressed: () => context.go('/members'),
              child: const Text('Back to directory'),
            ),
          ),
        ],
      );
    }

    final theme = Theme.of(context);
    final ministries = ref.watch(ministriesProvider);
    final groups = ref.watch(smallGroupsProvider);
    final giving =
        ref.watch(donationsProvider).where((d) => d.memberId == member.id).toList();
    final givingTotal = giving.fold(0.0, (sum, d) => sum + d.amount);
    final care =
        ref.watch(careRequestsProvider).where((c) => c.memberId == member.id).toList();
    final serving = ref
        .watch(volunteerSlotsProvider)
        .where((s) => s.memberId == member.id)
        .toList();

    final memberMinistries = ministries
        .where((m) => member.ministryIds.contains(m.id))
        .map((m) => m.name)
        .toList();
    final branch = ref.watch(branchByIdProvider(member.branchId));
    final memberDepartments = ref
        .watch(departmentsAllProvider)
        .where((d) => d.memberIds.contains(member.id))
        .map((d) => ref.watch(departmentTypeByIdProvider(d.typeId))?.name)
        .whereType<String>()
        .toList();
    final group = groups.where((g) => g.id == member.groupId).firstOrNull;
    final family = ref
        .watch(familiesProvider)
        .where((f) => f.id == member.familyId)
        .firstOrNull;

    return PageBody(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => context.go('/members'),
            icon: const Icon(Icons.arrow_back, size: 17),
            label: const Text('Back to directory'),
          ),
        ),
        PageHeader(
          title: member.fullName,
          description:
              '${branch?.name ?? 'Unassigned'} · member since ${Fmt.date(member.joinedAt)}',
          actions: [
            OutlinedButton.icon(
              // Composing is real; actual delivery needs an SMS/email
              // provider, which the compose dialog states plainly.
              onPressed: () => showComposeForm(context),
              icon: const Icon(Icons.send_outlined, size: 17),
              label: const Text('Message'),
            ),
            FilledButton.icon(
              onPressed: () => showMemberForm(context, member: member),
              icon: const Icon(Icons.edit_outlined, size: 17),
              label: const Text('Edit profile'),
            ),
          ],
        ),
        SplitRow(
          primaryFlex: 1,
          secondaryFlex: 2,
          primary: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionCard(
                title: 'Profile',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          foregroundImage: () {
                            final photo =
                                ref.watch(memberPhotoProvider(member));
                            return photo == null ? null : FileImage(photo);
                          }(),
                          child: Text(
                            member.initials,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                member.fullName,
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: [
                                  StatusBadge.of(member.status),
                                  if (member.isBaptized)
                                    const StatusBadge(
                                      label: 'Baptised',
                                      tone: StatusTone.info,
                                      showDot: false,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: AppSpacing.xl),
                    _detail(context, Icons.mail_outline, 'Email', member.email),
                    _detail(context, Icons.phone_outlined, 'Phone', member.phone),
                    _detail(
                      context,
                      Icons.cake_outlined,
                      'Date of birth',
                      '${Fmt.date(member.dateOfBirth)} · ${member.ageAt(appNow())} yrs',
                    ),
                    _detail(context, Icons.place_outlined, 'Address',
                        member.address.full),
                    _detail(context, Icons.event_available_outlined, 'Joined',
                        Fmt.dateLong(member.joinedAt)),
                    _detail(context, Icons.favorite_outline, 'Marital status',
                        member.maritalStatus.label),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md + 4),
              SectionCard(
                title: 'Tags',
                description: 'Used to build audiences and reports.',
                child: member.tags.isEmpty
                    ? Text('No tags yet.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ))
                    : Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final tag in member.tags)
                            Chip(
                              label: Text(tag),
                              visualDensity: VisualDensity.compact,
                              backgroundColor:
                                  theme.colorScheme.surfaceContainerHighest,
                            ),
                        ],
                      ),
              ),
              const SizedBox(height: AppSpacing.md + 4),
              SectionCard(
                title: 'Belonging',
                child: Column(
                  children: [
                    _detail(context, Icons.account_tree_outlined, 'Home branch',
                        branch?.name ?? 'Unassigned'),
                    _detail(
                      context,
                      Icons.groups_outlined,
                      'Departments',
                      memberDepartments.isEmpty
                          ? 'Not in a department'
                          : memberDepartments.join(', '),
                    ),
                    _detail(context, null, 'Small group',
                        group?.name ?? 'Not in a group'),
                    _detail(context, null, 'Family',
                        family?.name ?? 'No family record'),
                    _detail(
                      context,
                      null,
                      'Ministries',
                      memberMinistries.isEmpty
                          ? 'Not serving yet'
                          : memberMinistries.join(', '),
                    ),
                  ],
                ),
              ),
            ],
          ),
          secondary: DefaultTabController(
            length: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    tabs: const [
                      Tab(text: 'Giving'),
                      Tab(text: 'Serving'),
                      Tab(text: 'Care'),
                      Tab(text: 'Notes'),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  height: 520,
                  child: TabBarView(
                    children: [
                      _GivingTab(giving: giving, total: givingTotal),
                      _ServingTab(slots: serving),
                      _CareTab(requests: care),
                      SectionCard(
                        title: 'Pastoral notes',
                        description:
                            'Visible only to pastors and administrators.',
                        child: member.notes == null
                            ? const EmptyState(
                                title: 'No notes recorded',
                                description:
                                    'Add a note from the edit profile form.',
                                icon: Icons.note_outlined,
                              )
                            : Text(member.notes!,
                                style: theme.textTheme.bodyMedium),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _detail(
      BuildContext context, IconData? icon, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.sm + 4),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    )),
                Text(value, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GivingTab extends StatelessWidget {
  const _GivingTab({required this.giving, required this.total});

  final List<Donation> giving;
  final double total;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Giving history',
      description:
          '${giving.length} recorded gifts totalling ${Fmt.currency(total)}.',
      child: giving.isEmpty
          ? const EmptyState(
              title: 'No giving recorded',
              description: 'Gifts recorded against this member appear here.',
              icon: Icons.payments_outlined,
            )
          : Column(
              children: [
                for (final d in giving.take(8))
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(d.fund.label,
                        style: Theme.of(context).textTheme.bodyMedium),
                    subtitle: Text(
                      '${Fmt.date(d.date)} · ${d.method.label} · ${d.reference}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    trailing: Text(
                      Fmt.currency(d.amount),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _ServingTab extends StatelessWidget {
  const _ServingTab({required this.slots});

  final List<VolunteerSlot> slots;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Serving assignments',
      description: 'Rota slots this member is scheduled for.',
      child: slots.isEmpty
          ? const EmptyState(
              title: 'Not on any rota',
              description:
                  'Assign this member to a serving role from the volunteers screen.',
              icon: Icons.assignment_outlined,
            )
          : Column(
              children: [
                for (final s in slots)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(s.role.label,
                        style: Theme.of(context).textTheme.bodyMedium),
                    subtitle: Text('${s.serviceName} · ${Fmt.date(s.date)}',
                        style: Theme.of(context).textTheme.labelSmall),
                    trailing: StatusBadge.of(s.status),
                  ),
              ],
            ),
    );
  }
}

class _CareTab extends ConsumerWidget {
  const _CareTab({required this.requests});

  final List<CareRequest> requests;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SectionCard(
      title: 'Pastoral care',
      description: 'Prayer, counselling and visitation history.',
      child: requests.isEmpty
          ? const EmptyState(
              title: 'No care requests',
              description:
                  'This member has no open or historical care requests.',
              icon: Icons.volunteer_activism_outlined,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final r in requests)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(r.type.label,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                            ),
                            StatusBadge.of(r.priority),
                            const SizedBox(width: 6),
                            StatusBadge.of(r.status),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(r.summary,
                            style: Theme.of(context).textTheme.bodySmall),
                        Text(
                          'Raised ${Fmt.relative(r.createdAt, appNow())} · '
                          'assigned to ${ref.watch(memberNameProvider(r.assignedToId))}',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
