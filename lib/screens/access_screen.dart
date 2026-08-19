import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../widgets/collapsible.dart';
import '../utils/clock.dart';
import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/feedback.dart';
import '../widgets/page_header.dart';
import '../widgets/record_forms.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/person_tile.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_badge.dart';

const _roleSummary = <UserRole, String>{
  UserRole.superAdmin:
      'Complete control of every branch, including settings, roles and billing. '
      'The only role that sees other branches by default.',
  UserRole.seniorPastor:
      'Pastoral oversight — people, care, events and reporting. Scoped to one '
      'branch unless granted church-wide access.',
  UserRole.hqFinance:
      'Owns giving, expenses and financial reporting. Scoped to one branch '
      'unless granted church-wide access.',
  UserRole.branchPastor:
      'Leads one branch: its people, departments, services and care.',
  UserRole.assistantPastor:
      'Supports the branch pastor with people, care and events.',
  UserRole.branchAdmin:
      'Day-to-day administration of one branch — records, rotas and assets.',
  UserRole.branchFinance:
      'Giving and expenses for a single branch.',
  UserRole.departmentHead:
      'Runs one department: its members, rota and attendance.',
  UserRole.volunteer:
      'Sees their own serving schedule and the events calendar.',
  UserRole.member:
      'Self-service only — profile, giving history and events.',
};

class AccessScreen extends ConsumerWidget {
  const AccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(staffUsersProvider);
    final matrix = ref.watch(permissionMatrixProvider);
    final active = users.where((u) => u.status == AccountStatus.active).length;
    final invited = users.where((u) => u.status == AccountStatus.invited).length;
    final multiBranch = users.where((u) => u.canSeeAllBranches).length;

    return PageBody(
      children: [
        PageHeader(
          title: 'Roles & Access',
          description:
              'Who can reach which part of the system, across which branches, and what they may do there. '
              'Cross-branch sight is granted per account and marked with a key.',
          actions: [
            FilledButton.icon(
              onPressed: () => showInviteUserForm(context),
              icon: const Icon(Icons.person_add_outlined, size: 17),
              label: const Text('Invite user'),
            ),
          ],
        ),

        const _ScopeExplainer(),

        StatRow(
          sectionKey: 'access.stats',
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Users with access',
              value: '${users.length}',
              hint: 'staff and volunteers',
              icon: Icons.people_outline,
            ),
            StatCard(
              label: 'Active accounts',
              value: '$active',
              hint: 'signed in recently',
              icon: Icons.verified_user_outlined,
            ),
            StatCard(
              label: 'Church-wide access',
              value: '$multiBranch',
              hint: 'accounts seeing every branch',
              icon: Icons.public,
            ),
            StatCard(
              label: 'Pending invites',
              value: '$invited',
              hint: 'awaiting first sign-in',
              icon: Icons.mark_email_unread_outlined,
            ),
          ],
        ),

        SectionCard(
          title: 'User accounts',
          description:
              'Everyone who can sign in. "Scope" is how far their authority reaches.',
          child: Column(
            children: [
              for (final u in users)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm + 4),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: PersonTile(name: u.name, secondary: u.username),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(u.role.label,
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                      Expanded(
                        flex: 2,
                        child: _ScopeChip(user: u),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          Fmt.relative(u.lastActiveAt, appNow()),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      StatusBadge.of(u.status),
                      const SizedBox(width: AppSpacing.sm),
                      _BranchAccessToggle(user: u),
                    ],
                  ),
                ),
            ],
          ),
        ),

        SectionCard(
          title: 'Module permissions',
          description:
              'What each role may do. How far it reaches is the scope column above — both are enforced together.',
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 18,
              headingRowHeight: 44,
              dataRowMinHeight: 42,
              dataRowMaxHeight: 42,
              columns: [
                const DataColumn(label: Text('Module')),
                for (final role in UserRole.values)
                  DataColumn(
                    label: Tooltip(
                      message: '${role.label} · ${role.scope.label}',
                      child: Text(role.label,
                          style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ),
              ],
              rows: [
                for (final row in matrix)
                  DataRow(cells: [
                    DataCell(Text(
                      row.module,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    )),
                    for (final role in UserRole.values)
                      DataCell(StatusBadge.of(row.levelFor(role),
                          showDot: false)),
                  ]),
              ],
            ),
          ),
        ),

        ResponsiveGrid(
          minItemWidth: 340,
          maxColumns: 3,
          children: [
            for (final role in UserRole.values)
              Builder(builder: (context) {
                final full = matrix
                    .where((m) => m.levelFor(role) == PermissionLevel.full)
                    .length;
                final read = matrix
                    .where((m) => m.levelFor(role) == PermissionLevel.read)
                    .length;

                return SectionCard(
                  title: role.label,
                  description: _roleSummary[role],
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      StatusBadge(
                        label: role.grantsAllBranchesByDefault
                            ? 'All branches'
                            : role.scope.label,
                        tone: role.grantsAllBranchesByDefault
                            ? StatusTone.warning
                            : StatusTone.neutral,
                        showDot: false,
                      ),
                      if (!role.grantsAllBranchesByDefault &&
                          role.mayBeGrantedAllBranches)
                        const StatusBadge(
                          label: 'Can be granted church-wide',
                          tone: StatusTone.info,
                          showDot: false,
                        ),
                      StatusBadge(
                        label: '$full full',
                        tone: StatusTone.success,
                        showDot: false,
                      ),
                      StatusBadge(
                        label: '$read read only',
                        tone: StatusTone.info,
                        showDot: false,
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

/// Shows the branch/department a user's authority is limited to.
class _ScopeChip extends ConsumerWidget {
  const _ScopeChip({required this.user});

  final StaffUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = switch (user.effectiveScope) {
      RoleScope.allBranches => 'All branches',
      RoleScope.ownBranch => ref.watch(branchNameProvider(user.branchId)),
      RoleScope.ownDepartment => user.departmentId == null
          ? ref.watch(branchNameProvider(user.branchId))
          : '${ref.watch(departmentNameProvider(user.departmentId!))}'
              ' · ${ref.watch(branchCodeProvider(user.branchId))}',
      RoleScope.self => 'Self only',
    };

    return Row(
      children: [
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: user.canSeeAllBranches
                      ? AppTheme.warning
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight:
                      user.canSeeAllBranches ? FontWeight.w700 : FontWeight.w400,
                ),
          ),
        ),
        // Marks sight that was granted rather than inherited, so a widened
        // account is never quietly indistinguishable from a default one.
        if (user.canSeeAllBranches && user.hasExplicitBranchGrant)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Tooltip(
              message: 'Cross-branch access granted explicitly',
              child: Icon(Icons.key, size: 12, color: AppTheme.warning),
            ),
          ),
      ],
    );
  }
}

/// A short, honest explanation of the two-dimensional model — and of the fact
/// that it is presentation only until the backend enforces it.
class _ScopeExplainer extends ConsumerWidget {
  const _ScopeExplainer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final scope = ref.watch(scopeDescriptionProvider);
    final user = ref.watch(currentUserProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppTheme.info.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppTheme.info.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 18, color: AppTheme.info),
          const SizedBox(width: AppSpacing.sm + 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Access has two dimensions',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  'What you may do (the matrix below) × whose data you see (your scope). '
                  'Seeing other branches is a separate permission held by the account, '
                  'not the role — only Super Admin has it by default. '
                  'You are signed in as ${user.name} — ${user.role.label}, $scope.',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                Text(
                  'This is UI-level only. Every check must be repeated server-side once the backend exists.',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
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

/// Grants or revokes cross-branch visibility for one account.
///
/// Only a Super Admin can operate it, and only roles at branch level or above
/// can receive it — a volunteer cannot be widened to the whole church.
class _BranchAccessToggle extends ConsumerWidget {
  const _BranchAccessToggle({required this.user});

  final StaffUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canEdit = ref.watch(canEditProvider('Roles & Access'));
    final me = ref.watch(currentUserProvider);

    if (!canEdit || !user.role.mayBeGrantedAllBranches) {
      return const SizedBox(width: 40);
    }

    // Removing your own church-wide access would lock you out of this screen.
    final isSelf = user.id == me.id;
    final granted = user.canSeeAllBranches;

    return Tooltip(
      message: isSelf
          ? 'You cannot change your own branch access'
          : granted
              ? 'Revoke access to other branches'
              : 'Grant access to every branch',
      child: IconButton(
        visualDensity: VisualDensity.compact,
        icon: Icon(
          granted ? Icons.public : Icons.public_off,
          size: 17,
          color: granted
              ? AppTheme.warning
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onPressed: isSelf
            ? null
            : () async {
                await ref
                    .read(repositoryProvider)
                    .setBranchVisibility(user.id, granted ? false : true);
                if (!context.mounted) return;
                showLocalSuccess(
                  context,
                  granted
                      ? '${user.name} can no longer see other branches.'
                      : '${user.name} can now see every branch.',
                );
              },
      ),
    );
  }
}
