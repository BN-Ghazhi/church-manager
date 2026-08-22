import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../db/password.dart';
import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import 'form_scaffold.dart';

/// Editing an existing account: who they are, what they may do, and how far.
///
/// Separate from the invite form because the two answer different questions —
/// creating an account needs a password, editing one must never show or silently
/// reset it. Password changes go through [showPasswordResetForm].
Future<void> showUserEditForm(
  BuildContext context, {
  required StaffUser user,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _UserEditForm(user: user),
    );

class _UserEditForm extends ConsumerStatefulWidget {
  const _UserEditForm({required this.user});

  final StaffUser user;

  @override
  ConsumerState<_UserEditForm> createState() => _UserEditFormState();
}

class _UserEditFormState extends ConsumerState<_UserEditForm> {
  late final TextEditingController _name =
      TextEditingController(text: widget.user.name);
  late final TextEditingController _username =
      TextEditingController(text: widget.user.username);

  late UserRole _role = widget.user.role;
  late String? _branchId = widget.user.branchId;
  late String? _departmentId = widget.user.departmentId;
  late AccountStatus _status = widget.user.status;
  late bool _seesAllBranches = widget.user.canSeeAllBranches;

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final needsDepartment = _role.scope == RoleScope.ownDepartment;
    final departments = ref
        .watch(departmentsAllProvider)
        .where((d) => d.branchId == _branchId)
        .toList();

    // Changing your own role or access would take away the permission you are
    // using right now, and with no server there is nobody to undo it.
    final isSelf = widget.user.id == ref.watch(currentUserProvider).id;

    return FormDialog(
      title: 'Edit ${widget.user.name}',
      description: isSelf
          ? 'This is your own account, so its role and access are locked — '
              'changing them could lock you out of this screen.'
          : 'Changes take effect the next time they use the app.',
      submitLabel: 'Save changes',
      successMessage: '${_name.text.trim()} updated.',
      fields: [
        PlainTextField(
          label: 'Full name',
          controller: _name,
          required: true,
        ),
        LabelledField(
          label: 'Username',
          hint: 'What they type to sign in.',
          child: TextFormField(
            controller: _username,
            validator: (v) {
              final value = (v ?? '').trim();
              if (value.isEmpty) return 'A username is required';
              if (value.length < 3) return 'At least three characters';
              if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(value)) {
                return 'Letters, numbers, dots, dashes and underscores only';
              }
              return null;
            },
          ),
        ),
        if (!isSelf)
          EnumField<UserRole>(
            label: 'Role',
            values: UserRole.values,
            value: _role,
            labelOf: (v) => '${v.label} · ${v.scope.label}',
            onChanged: (v) => setState(() {
              _role = v;
              _departmentId = null;
              // A role that cannot hold church-wide sight must not keep it.
              if (!v.mayBeGrantedAllBranches) _seesAllBranches = false;
            }),
          ),
        BranchField(
          value: _branchId,
          onChanged: (v) => setState(() {
            _branchId = v;
            _departmentId = null;
          }),
        ),
        if (needsDepartment)
          LabelledField(
            label: 'Department',
            child: DropdownButtonFormField<String>(
              initialValue: _departmentId,
              isExpanded: true,
              hint: const Text('Choose a department'),
              items: [
                for (final d in departments)
                  DropdownMenuItem(
                    value: d.id,
                    child: Text(ref.read(departmentNameProvider(d.id))),
                  ),
              ],
              onChanged: (v) => setState(() => _departmentId = v),
              validator: (v) =>
                  v == null ? 'This role needs a department' : null,
            ),
          ),
        if (!isSelf)
          EnumField<AccountStatus>(
            label: 'Status',
            values: AccountStatus.values,
            value: _status,
            labelOf: (v) => v.label,
            onChanged: (v) => setState(() => _status = v),
          ),
        if (!isSelf && _role.mayBeGrantedAllBranches)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _seesAllBranches,
            onChanged: (v) => setState(() => _seesAllBranches = v),
            title: const Text('Can see every branch'),
            subtitle: const Text(
              'Cross-branch sight is granted per account, not by role.',
            ),
          ),
      ],
      onSubmit: () async {
        final repo = ref.read(repositoryProvider);

        final renamed = await repo.updateUserIdentity(
          widget.user.id,
          name: _name.text.trim(),
          username: _username.text.trim(),
        );
        if (!renamed) {
          throw Exception('That username is already taken.');
        }

        if (!isSelf) {
          await repo.updateUserRole(
            widget.user.id,
            role: _role,
            branchId: _branchId,
            departmentId: needsDepartment ? _departmentId : null,
            status: _status,
          );
          await repo.setBranchVisibility(
            widget.user.id,
            _role.mayBeGrantedAllBranches ? _seesAllBranches : false,
          );
        }
      },
    );
  }
}

/// Sets a new password for an account.
///
/// There is no email server to send a reset link to, so a Super Admin sets one
/// directly and tells the person what it is.
Future<void> showPasswordResetForm(
  BuildContext context, {
  required StaffUser user,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _PasswordResetForm(user: user),
    );

class _PasswordResetForm extends ConsumerStatefulWidget {
  const _PasswordResetForm({required this.user});

  final StaffUser user;

  @override
  ConsumerState<_PasswordResetForm> createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends ConsumerState<_PasswordResetForm> {
  final _password = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormDialog(
        title: 'Reset password',
        description:
            'Sets a new password for ${widget.user.name}. Tell them what it is — '
            'there is no email server to send it to.',
        submitLabel: 'Set password',
        successMessage: 'Password changed for ${widget.user.name}.',
        fields: [
          LabelledField(
            label: 'New password',
            hint: 'At least 8 characters, with a letter and a number.',
            child: TextFormField(
              controller: _password,
              validator: (v) => Password.validate(v ?? ''),
            ),
          ),
        ],
        onSubmit: () => ref
            .read(repositoryProvider)
            .changePassword(widget.user.id, _password.text),
      );
}

/// Sets what one role may do in every module, in one pass.
Future<void> showRolePermissionsForm(
  BuildContext context, {
  required UserRole role,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _RolePermissionsForm(role: role),
    );

class _RolePermissionsForm extends ConsumerStatefulWidget {
  const _RolePermissionsForm({required this.role});

  final UserRole role;

  @override
  ConsumerState<_RolePermissionsForm> createState() =>
      _RolePermissionsFormState();
}

class _RolePermissionsFormState extends ConsumerState<_RolePermissionsForm> {
  /// Module name to chosen level, seeded from the current effective matrix.
  final _levels = <String, PermissionLevel>{};

  @override
  void initState() {
    super.initState();
    for (final m in ref.read(permissionMatrixProvider)) {
      _levels[m.module] = m.levelFor(widget.role);
    }
  }

  @override
  Widget build(BuildContext context) => FormDialog(
        title: '${widget.role.label} permissions',
        description:
            'What this role may do in each module. This is what they can do; '
            'how far it reaches is their scope — ${widget.role.scope.label}.',
        submitLabel: 'Save permissions',
        successMessage: '${widget.role.label} permissions updated.',
        width: 560,
        fields: [
          for (final module in _levels.keys)
            _LevelPicker(
              label: module,
              value: _levels[module]!,
              onChanged: (v) => setState(() => _levels[module] = v),
            ),
        ],
        onSubmit: () async {
          final repo = ref.read(repositoryProvider);
          for (final entry in _levels.entries) {
            await repo.setPermission(
              module: entry.key,
              role: widget.role,
              level: entry.value,
            );
          }
        },
      );
}

/// Sets what every role may do in one module.
Future<void> showModulePermissionsForm(
  BuildContext context, {
  required String module,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _ModulePermissionsForm(module: module),
    );

class _ModulePermissionsForm extends ConsumerStatefulWidget {
  const _ModulePermissionsForm({required this.module});

  final String module;

  @override
  ConsumerState<_ModulePermissionsForm> createState() =>
      _ModulePermissionsFormState();
}

class _ModulePermissionsFormState
    extends ConsumerState<_ModulePermissionsForm> {
  final _levels = <UserRole, PermissionLevel>{};

  @override
  void initState() {
    super.initState();
    final row = ref
        .read(permissionMatrixProvider)
        .where((m) => m.module == widget.module)
        .firstOrNull;
    for (final role in UserRole.values) {
      _levels[role] = row?.levelFor(role) ?? PermissionLevel.none;
    }
  }

  @override
  Widget build(BuildContext context) => FormDialog(
        title: widget.module,
        description:
            'What each role may do in this module. Super Admin is fixed at full '
            'access — it is the account that fixes everyone else\'s.',
        submitLabel: 'Save permissions',
        successMessage: '${widget.module} permissions updated.',
        width: 560,
        fields: [
          for (final role in UserRole.values)
            if (role == UserRole.superAdmin)
              _LevelPicker(
                label: role.label,
                value: PermissionLevel.full,
                onChanged: null,
              )
            else
              _LevelPicker(
                label: role.label,
                value: _levels[role]!,
                onChanged: (v) => setState(() => _levels[role] = v),
              ),
        ],
        onSubmit: () async {
          final repo = ref.read(repositoryProvider);
          for (final entry in _levels.entries) {
            await repo.setPermission(
              module: widget.module,
              role: entry.key,
              level: entry.value,
            );
          }
        },
      );
}

/// A labelled row of None / Read / Full buttons.
///
/// A segmented control rather than a dropdown because there are only three
/// choices and a permission form has a dozen rows — one tap each beats a dozen
/// menus, and all three options stay visible for comparison.
class _LevelPicker extends StatelessWidget {
  const _LevelPicker({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final PermissionLevel value;
  final ValueChanged<PermissionLevel>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: onChanged == null
                    ? theme.colorScheme.onSurfaceVariant
                    : null,
              ),
            ),
          ),
          SegmentedButton<PermissionLevel>(
            showSelectedIcon: false,
            style: const ButtonStyle(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            segments: [
              for (final level in PermissionLevel.values)
                ButtonSegment(
                  value: level,
                  label: Text(
                    level.label,
                    style: theme.textTheme.labelSmall,
                  ),
                ),
            ],
            selected: {value},
            onSelectionChanged:
                onChanged == null ? null : (s) => onChanged!(s.first),
          ),
        ],
      ),
    );
  }
}

/// Changes your own password.
///
/// Asks for the current one, unlike the administrator's reset. Anyone can reach
/// this from the account menu, including from a machine someone left signed in —
/// so proving you know the existing password is what stops a passer-by locking
/// the real user out.
Future<void> showOwnPasswordForm(BuildContext context) => showDialog<void>(
      context: context,
      builder: (_) => const _OwnPasswordForm(),
    );

class _OwnPasswordForm extends ConsumerStatefulWidget {
  const _OwnPasswordForm();

  @override
  ConsumerState<_OwnPasswordForm> createState() => _OwnPasswordFormState();
}

class _OwnPasswordFormState extends ConsumerState<_OwnPasswordForm> {
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    for (final c in [_current, _next, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    return FormDialog(
      title: 'Change your password',
      description: 'Signed in as ${user.username}.',
      submitLabel: 'Change password',
      successMessage: 'Your password has been changed.',
      fields: [
        LabelledField(
          label: 'Current password',
          child: TextFormField(
            controller: _current,
            obscureText: true,
            validator: (v) => (v ?? '').isEmpty
                ? 'Enter your current password'
                : null,
          ),
        ),
        LabelledField(
          label: 'New password',
          hint: 'At least 8 characters, with a letter and a number.',
          child: TextFormField(
            controller: _next,
            obscureText: true,
            validator: (v) => Password.validate(v ?? ''),
          ),
        ),
        LabelledField(
          label: 'Confirm new password',
          child: TextFormField(
            controller: _confirm,
            obscureText: true,
            // Typed twice because it is obscured: a typo here would lock the
            // user out of the only account that can fix it.
            validator: (v) =>
                v == _next.text ? null : 'The two passwords do not match',
          ),
        ),
      ],
      onSubmit: () async {
        final changed = await ref.read(repositoryProvider).changeOwnPassword(
              userId: user.id,
              currentPassword: _current.text,
              newPassword: _next.text,
            );
        if (!changed) {
          throw Exception('That is not your current password.');
        }
      },
    );
  }
}
