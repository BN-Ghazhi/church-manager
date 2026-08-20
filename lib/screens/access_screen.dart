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
import '../widgets/data_table_view.dart';
import '../widgets/row_actions.dart';
import '../widgets/access_forms.dart';
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

class AccessScreen extends ConsumerStatefulWidget {
  const AccessScreen({super.key});

  @override
  ConsumerState<AccessScreen> createState() => _AccessScreenState();
}

/// Users, roles and permissions as three tables behind three tabs.
///
/// They were one long scroll of cards before. Cards look tidy with four
/// accounts and become unusable with forty: no sorting, no search, and nowhere
/// to put per-row actions. Tables give all three, and splitting them into tabs
/// means each answers one question — who can sign in, what a role is, and what
/// a role may do.
class _AccessScreenState extends ConsumerState<AccessScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 3, vsync: this);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final users = ref.watch(staffUsersProvider);
    final active = users.where((u) => u.status == AccountStatus.active).length;
    final invited = users.where((u) => u.status == AccountStatus.invited).length;
    final multiBranch = users.where((u) => u.canSeeAllBranches).length;
    final canEdit = ref.watch(canEditProvider('Roles & Access'));

    return Column(
      children: [
        Expanded(
          child: PageBody(
            children: [
              PageHeader(
                title: 'Roles & Access',
                description:
                    'Who can sign in, what each role is, and what that role may '
                    'do. Cross-branch sight is granted per account, not by role.',
                actions: [
                  if (canEdit)
                    FilledButton.icon(
                      onPressed: () => showInviteUserForm(context),
                      icon: const Icon(Icons.person_add_outlined, size: 17),
                      label: const Text('Add user'),
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
              TabBar(
                controller: _tabs,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: scheme.outlineVariant.withValues(alpha: 0.6),
                labelColor: scheme.primary,
                unselectedLabelColor: scheme.onSurfaceVariant,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(icon: Icon(Icons.people_outline, size: 18), text: 'Users'),
                  Tab(icon: Icon(Icons.badge_outlined, size: 18), text: 'Roles'),
                  Tab(
                      icon: Icon(Icons.lock_outline, size: 18),
                      text: 'Permissions'),
                ],
              ),
              // A fixed height because this sits inside a scrolling page: an
              // unbounded TabBarView cannot lay out here.
              SizedBox(
                height: 620,
                child: TabBarView(
                  controller: _tabs,
                  children: const [
                    _UsersTab(),
                    _RolesTab(),
                    _PermissionsTab(),
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

/* ------------------------------------------------------------------ users */

class _UsersTab extends ConsumerWidget {
  const _UsersTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(staffUsersProvider);
    final canEdit = ref.watch(canEditProvider('Roles & Access'));
    final me = ref.watch(currentUserProvider);

    return SingleChildScrollView(
      child: SectionCard(
        title: 'User accounts',
        description:
            'Everyone who can sign in. Scope is how far their authority reaches.',
        child: DataTableView<StaffUser>(
          rows: users,
          rowId: (u) => u.id,
          pageSize: 10,
          searchHint: 'Search by name or username…',
          searchable: (u) => '${u.name} ${u.username} ${u.role.label}',
          onRowTap: (u) => _showUser(context, ref, u),
          filters: [
            TableFilter<StaffUser>(
              id: 'role',
              label: 'Role',
              options: UserRole.values.map((r) => r.label).toList(),
              matches: (u, v) => u.role.label == v,
            ),
            TableFilter<StaffUser>(
              id: 'status',
              label: 'Status',
              options: AccountStatus.values.map((s) => s.label).toList(),
              matches: (u, v) => u.status.label == v,
            ),
          ],
          columns: [
            TableColumn<StaffUser>(
              id: 'name',
              header: 'User',
              flex: 3,
              sortValue: (u) => u.name,
              cell: (u) => PersonTile(name: u.name, secondary: u.username),
            ),
            TableColumn<StaffUser>(
              id: 'role',
              header: 'Role',
              flex: 2,
              sortValue: (u) => u.role.label,
              cell: (u) => Text(u.role.label,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            TableColumn<StaffUser>(
              id: 'scope',
              header: 'Scope',
              flex: 2,
              hideOnNarrow: true,
              cell: (u) => _ScopeChip(user: u),
            ),
            TableColumn<StaffUser>(
              id: 'seen',
              header: 'Last active',
              flex: 2,
              hideOnNarrow: true,
              sortValue: (u) => u.lastActiveAt,
              cell: (u) => Text(Fmt.relative(u.lastActiveAt, appNow()),
                  style: Theme.of(context).textTheme.labelSmall),
            ),
            TableColumn<StaffUser>(
              id: 'status',
              header: 'Status',
              width: 116,
              sortValue: (u) => u.status.label,
              cell: (u) => StatusBadge.of(u.status),
            ),
            TableColumn<StaffUser>(
              id: 'actions',
              header: '',
              width: 116,
              cell: (u) => RowActions(
                onView: () => _showUser(context, ref, u),
                onEdit: canEdit ? () => showUserEditForm(context, user: u) : null,
                // Deleting your own account would sign you out of the screen
                // that manages accounts, with no way back in.
                onDelete: canEdit && u.id != me.id
                    ? () => _deleteUser(context, ref, u)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showUser(BuildContext context, WidgetRef ref, StaffUser user) {
  final canEdit = ref.read(canEditProvider('Roles & Access'));

  showDetailSheet<void>(
    context,
    title: user.name,
    subtitle: '${user.role.label} · ${user.username}',
    children: [
      DetailRows(entries: {
        'Username': user.username,
        'Role': user.role.label,
        'Status': user.status.label,
        'Branch': user.branchId == null
            ? 'Not tied to a branch'
            : ref.read(branchNameProvider(user.branchId)),
        'Department': user.departmentId == null
            ? ''
            : ref.read(departmentNameProvider(user.departmentId!)),
        'Sees all branches': user.canSeeAllBranches ? 'Yes' : 'No',
        'Scope': user.effectiveScope.label,
        'Last active': Fmt.dateTime(user.lastActiveAt),
      }),
    ],
    actions: (close) => [
      if (canEdit)
        OutlinedButton.icon(
          onPressed: () {
            close();
            showPasswordResetForm(context, user: user);
          },
          icon: const Icon(Icons.key_outlined, size: 16),
          label: const Text('Reset password'),
        ),
      if (canEdit)
        FilledButton.icon(
          onPressed: () {
            close();
            showUserEditForm(context, user: user);
          },
          icon: const Icon(Icons.edit_outlined, size: 16),
          label: const Text('Edit'),
        ),
    ],
  );
}

Future<void> _deleteUser(
  BuildContext context,
  WidgetRef ref,
  StaffUser user,
) async {
  final ok = await confirmDelete(
    context,
    what: '${user.name}\'s account',
    consequence: 'They can no longer sign in. Records they entered are kept.',
  );
  if (!ok || !context.mounted) return;
  await ref.read(repositoryProvider).deleteUser(user.id);
  if (!context.mounted) return;
  showLocalSuccess(context, '${user.name} can no longer sign in.');
}

/* ------------------------------------------------------------------ roles */

class _RolesTab extends ConsumerWidget {
  const _RolesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matrix = ref.watch(permissionMatrixProvider);
    final users = ref.watch(staffUsersProvider);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: SectionCard(
        title: 'Roles',
        description:
            'The ten roles and what each one reaches. Edit a role to change what '
            'it may do in every module at once.',
        child: DataTableView<UserRole>(
          rows: UserRole.values,
          rowId: (r) => r.name,
          pageSize: 10,
          searchHint: 'Search roles…',
          searchable: (r) => '${r.label} ${r.scope.label}',
          onRowTap: (r) => _showRole(context, ref, r),
          columns: [
            TableColumn<UserRole>(
              id: 'role',
              header: 'Role',
              flex: 3,
              sortValue: (r) => r.label,
              cell: (r) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(r.label,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  Text(
                    _roleSummary[r] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            TableColumn<UserRole>(
              id: 'scope',
              header: 'Reach',
              flex: 2,
              hideOnNarrow: true,
              sortValue: (r) => r.scope.label,
              cell: (r) => StatusBadge(
                label: r.grantsAllBranchesByDefault
                    ? 'All branches'
                    : r.scope.label,
                tone: r.grantsAllBranchesByDefault
                    ? StatusTone.warning
                    : StatusTone.neutral,
                showDot: false,
              ),
            ),
            TableColumn<UserRole>(
              id: 'accounts',
              header: 'Accounts',
              width: 90,
              sortValue: (r) => users.where((u) => u.role == r).length,
              cell: (r) => Text(
                '${users.where((u) => u.role == r).length}',
                style: theme.textTheme.bodySmall,
              ),
            ),
            TableColumn<UserRole>(
              id: 'full',
              header: 'Full access',
              width: 104,
              hideOnNarrow: true,
              sortValue: (r) => _countAt(matrix, r, PermissionLevel.full),
              cell: (r) => Text(
                '${_countAt(matrix, r, PermissionLevel.full)} modules',
                style: theme.textTheme.bodySmall,
              ),
            ),
            TableColumn<UserRole>(
              id: 'read',
              header: 'Read only',
              width: 104,
              hideOnNarrow: true,
              sortValue: (r) => _countAt(matrix, r, PermissionLevel.read),
              cell: (r) => Text(
                '${_countAt(matrix, r, PermissionLevel.read)} modules',
                style: theme.textTheme.bodySmall,
              ),
            ),
            TableColumn<UserRole>(
              id: 'actions',
              header: '',
              width: 116,
              cell: (r) => RowActions(
                onView: () => _showRole(context, ref, r),
                // A role is part of the system, not a record: it can be
                // reconfigured but never removed, so there is no delete here.
                onEdit: ref.watch(canEditProvider('Roles & Access')) &&
                        r != UserRole.superAdmin
                    ? () => showRolePermissionsForm(context, role: r)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int _countAt(
  List<ModulePermission> matrix,
  UserRole role,
  PermissionLevel level,
) =>
    matrix.where((m) => m.levelFor(role) == level).length;

void _showRole(BuildContext context, WidgetRef ref, UserRole role) {
  final matrix = ref.read(permissionMatrixProvider);
  final users = ref.read(staffUsersProvider).where((u) => u.role == role);
  final canEdit = ref.read(canEditProvider('Roles & Access'));

  showDetailSheet<void>(
    context,
    title: role.label,
    subtitle: role.scope.label,
    children: [
      DetailRows(entries: {
        'What it is': _roleSummary[role] ?? '',
        'Reach': role.grantsAllBranchesByDefault
            ? 'Every branch by default'
            : role.scope.label,
        'May be granted church-wide':
            role.mayBeGrantedAllBranches ? 'Yes' : 'No',
        'Accounts with this role': '${users.length}',
        'Full access': '${_countAt(matrix, role, PermissionLevel.full)} modules',
        'Read only': '${_countAt(matrix, role, PermissionLevel.read)} modules',
        'No access': '${_countAt(matrix, role, PermissionLevel.none)} modules',
      }),
      const SizedBox(height: AppSpacing.md),
      _RoleModuleList(role: role),
    ],
    actions: (close) => [
      if (canEdit && role != UserRole.superAdmin)
        FilledButton.icon(
          onPressed: () {
            close();
            showRolePermissionsForm(context, role: role);
          },
          icon: const Icon(Icons.edit_outlined, size: 16),
          label: const Text('Edit permissions'),
        ),
    ],
  );
}

/// Module-by-module access for one role, inside its detail sheet.
class _RoleModuleList extends ConsumerWidget {
  const _RoleModuleList({required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matrix = ref.watch(permissionMatrixProvider);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Module by module', style: theme.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        for (final m in matrix)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Expanded(
                  child: Text(m.module, style: theme.textTheme.bodySmall),
                ),
                StatusBadge.of(m.levelFor(role), showDot: false),
              ],
            ),
          ),
      ],
    );
  }
}

/* ------------------------------------------------------------ permissions */

class _PermissionsTab extends ConsumerWidget {
  const _PermissionsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matrix = ref.watch(permissionMatrixProvider);
    final canEdit = ref.watch(canEditProvider('Roles & Access'));
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: SectionCard(
        title: 'Module permissions',
        description:
            'One row per module. Edit a row to set what every role may do there. '
            'Super Admin always keeps full access.',
        child: DataTableView<ModulePermission>(
          rows: matrix,
          rowId: (m) => m.module,
          pageSize: 14,
          searchHint: 'Search modules…',
          searchable: (m) => m.module,
          onRowTap: (m) => _showModule(context, ref, m),
          columns: [
            TableColumn<ModulePermission>(
              id: 'module',
              header: 'Module',
              flex: 3,
              sortValue: (m) => m.module,
              cell: (m) => Text(
                m.module,
                style: theme.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            TableColumn<ModulePermission>(
              id: 'full',
              header: 'Full',
              width: 84,
              sortValue: (m) => _rolesAt(m, PermissionLevel.full).length,
              cell: (m) => Text('${_rolesAt(m, PermissionLevel.full).length}',
                  style: theme.textTheme.bodySmall),
            ),
            TableColumn<ModulePermission>(
              id: 'read',
              header: 'Read',
              width: 84,
              sortValue: (m) => _rolesAt(m, PermissionLevel.read).length,
              cell: (m) => Text('${_rolesAt(m, PermissionLevel.read).length}',
                  style: theme.textTheme.bodySmall),
            ),
            TableColumn<ModulePermission>(
              id: 'none',
              header: 'No access',
              width: 100,
              hideOnNarrow: true,
              sortValue: (m) => _rolesAt(m, PermissionLevel.none).length,
              cell: (m) => Text('${_rolesAt(m, PermissionLevel.none).length}',
                  style: theme.textTheme.bodySmall),
            ),
            TableColumn<ModulePermission>(
              id: 'who',
              header: 'Full access for',
              flex: 3,
              hideOnNarrow: true,
              cell: (m) => Text(
                _rolesAt(m, PermissionLevel.full)
                    .map((r) => r.label)
                    .join(', '),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
            TableColumn<ModulePermission>(
              id: 'actions',
              header: '',
              width: 116,
              cell: (m) => RowActions(
                onView: () => _showModule(context, ref, m),
                onEdit: canEdit
                    ? () => showModulePermissionsForm(context, module: m.module)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<UserRole> _rolesAt(ModulePermission m, PermissionLevel level) =>
    UserRole.values.where((r) => m.levelFor(r) == level).toList();

void _showModule(
  BuildContext context,
  WidgetRef ref,
  ModulePermission module,
) {
  final canEdit = ref.read(canEditProvider('Roles & Access'));

  showDetailSheet<void>(
    context,
    title: module.module,
    subtitle: 'What each role may do here',
    children: [
      Builder(builder: (context) {
        final theme = Theme.of(context);
        return Column(
          children: [
            for (final role in UserRole.values)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(role.label,
                          style: theme.textTheme.bodySmall),
                    ),
                    StatusBadge.of(module.levelFor(role), showDot: false),
                  ],
                ),
              ),
          ],
        );
      }),
    ],
    actions: (close) => [
      if (canEdit)
        FilledButton.icon(
          onPressed: () {
            close();
            showModulePermissionsForm(context, module: module.module);
          },
          icon: const Icon(Icons.edit_outlined, size: 16),
          label: const Text('Edit'),
        ),
    ],
  );
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

