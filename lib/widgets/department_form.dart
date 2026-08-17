import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import 'feedback.dart';
import 'person_tile.dart';

/// Start a department at a branch, choosing from the shared catalogue.
Future<void> showDepartmentForm(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (_) => const _DepartmentFormDialog(),
  );
}

class _DepartmentFormDialog extends ConsumerStatefulWidget {
  const _DepartmentFormDialog();

  @override
  ConsumerState<_DepartmentFormDialog> createState() =>
      _DepartmentFormDialogState();
}

class _DepartmentFormDialogState
    extends ConsumerState<_DepartmentFormDialog> {
  String? _typeId;
  String? _branchId;
  String? _headId;
  Weekday _day = Weekday.saturday;
  String _time = '5:00 PM';

  @override
  void initState() {
    super.initState();
    // Default to the branch currently in view when one is focused.
    _branchId = ref.read(selectedBranchProvider);
  }

  @override
  Widget build(BuildContext context) {
    final types = ref.watch(departmentTypesProvider);
    final branches = ref.watch(visibleBranchesProvider);
    final existing = ref.watch(departmentsAllProvider);

    // Only offer members of the chosen branch as head — a department head must
    // belong to the branch they lead.
    final candidates = _branchId == null
        ? <Member>[]
        : ref
            .watch(membersAllProvider)
            .where((m) =>
                m.branchId == _branchId && m.ageAt(DateTime.now().toUtc()) >= 21)
            .toList()
      ..sort((a, b) => a.lastName.compareTo(b.lastName));

    // A branch runs at most one instance of each type.
    final alreadyRunning = existing
        .where((d) => d.branchId == _branchId)
        .map((d) => d.typeId)
        .toSet();

    return AlertDialog(
      title: const Text('Start a department'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Departments are created from the shared catalogue, so the same '
                'department can be compared across branches.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: AppSpacing.md + 4),

              _label(context, 'Branch'),
              DropdownButtonFormField<String>(
                initialValue: _branchId,
                isExpanded: true,
                hint: const Text('Choose a branch'),
                items: [
                  for (final b in branches)
                    DropdownMenuItem(value: b.id, child: Text(b.name)),
                ],
                onChanged: (v) => setState(() {
                  _branchId = v;
                  _headId = null; // head must belong to the new branch
                }),
              ),
              const SizedBox(height: AppSpacing.md),

              _label(context, 'Department type'),
              DropdownButtonFormField<String>(
                initialValue: _typeId,
                isExpanded: true,
                hint: const Text('Choose from the catalogue'),
                items: [
                  for (final t in types)
                    DropdownMenuItem(
                      value: t.id,
                      enabled: !alreadyRunning.contains(t.id),
                      child: Text(
                        alreadyRunning.contains(t.id)
                            ? '${t.name} — already running here'
                            : t.name,
                        style: TextStyle(
                          color: alreadyRunning.contains(t.id)
                              ? Theme.of(context).disabledColor
                              : null,
                        ),
                      ),
                    ),
                ],
                onChanged: (v) => setState(() => _typeId = v),
              ),
              const SizedBox(height: AppSpacing.md),

              _label(context, 'Department head'),
              DropdownButtonFormField<String>(
                initialValue: _headId,
                isExpanded: true,
                hint: Text(_branchId == null
                    ? 'Choose a branch first'
                    : 'Choose from this branch'),
                items: [
                  for (final m in candidates.take(60))
                    DropdownMenuItem(value: m.id, child: Text(m.fullName)),
                ],
                onChanged: _branchId == null
                    ? null
                    : (v) => setState(() => _headId = v),
              ),
              const SizedBox(height: AppSpacing.md),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label(context, 'Meeting day'),
                        DropdownButtonFormField<Weekday>(
                          initialValue: _day,
                          isExpanded: true,
                          items: [
                            for (final d in Weekday.values)
                              DropdownMenuItem(value: d, child: Text(d.label)),
                          ],
                          onChanged: (v) => setState(() => _day = v!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label(context, 'Meeting time'),
                        DropdownButtonFormField<String>(
                          initialValue: _time,
                          isExpanded: true,
                          items: [
                            for (final t in const [
                              '7:00 AM', '4:00 PM', '5:00 PM',
                              '6:00 PM', '6:30 PM',
                            ])
                              DropdownMenuItem(value: t, child: Text(t)),
                          ],
                          onChanged: (v) => setState(() => _time = v!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: (_typeId == null || _branchId == null || _headId == null)
              ? null
              : () async {
                  final name =
                      ref.read(departmentTypeByIdProvider(_typeId!))?.name;
                  final branch = ref.read(branchNameProvider(_branchId));
                  await ref.read(repositoryProvider).createDepartment(
                        typeId: _typeId!,
                        branchId: _branchId!,
                        headId: _headId!,
                        meetingDay: _day,
                        meetingTime: _time,
                      );
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                  showLocalSuccess(context, '$name started at $branch.');
                },
          child: const Text('Start department'),
        ),
      ],
    );
  }
}

/// Add a new type to the shared catalogue — an HQ-level action, because every
/// branch draws from this list.
Future<void> showDepartmentTypeForm(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (_) => const _DepartmentTypeDialog(),
  );
}

class _DepartmentTypeDialog extends ConsumerStatefulWidget {
  const _DepartmentTypeDialog();

  @override
  ConsumerState<_DepartmentTypeDialog> createState() =>
      _DepartmentTypeDialogState();
}

class _DepartmentTypeDialogState extends ConsumerState<_DepartmentTypeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  bool _isCore = false;
  bool _ageGated = false;
  RangeValues _ages = const RangeValues(13, 30);

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New department type'),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Types are church-wide. Adding one here makes it available to '
                  'every branch, which is what keeps reporting comparable.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: AppSpacing.md + 4),
                _label(context, 'Name'),
                TextFormField(
                  controller: _name,
                  decoration:
                      const InputDecoration(hintText: "e.g. Men's Fellowship"),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'A name is required' : null,
                ),
                const SizedBox(height: AppSpacing.md),
                _label(context, 'Description'),
                TextFormField(
                  controller: _description,
                  maxLines: 2,
                  decoration: const InputDecoration(
                      hintText: 'What this department does…'),
                ),
                const SizedBox(height: AppSpacing.sm),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _isCore,
                  onChanged: (v) => setState(() => _isCore = v),
                  title: const Text('Core department'),
                  subtitle:
                      const Text('Expected to run at every branch, including plants.'),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _ageGated,
                  onChanged: (v) => setState(() => _ageGated = v),
                  title: const Text('Age-restricted'),
                  subtitle: const Text(
                      'Only members in an age range may join — as with Youth and Children.'),
                ),
                if (_ageGated) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Ages ${_ages.start.round()}–${_ages.end.round()}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  RangeSlider(
                    values: _ages,
                    min: 0,
                    max: 80,
                    divisions: 80,
                    labels: RangeLabels(
                      '${_ages.start.round()}',
                      '${_ages.end.round()}',
                    ),
                    onChanged: (v) => setState(() => _ages = v),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            final name = _name.text.trim();
            await ref.read(repositoryProvider).createDepartmentType(
                  name: name,
                  description: _description.text.trim(),
                  accent: AccentToken.violet,
                  isCore: _isCore,
                  minAge: _ageGated ? _ages.start.round() : null,
                  maxAge: _ageGated ? _ages.end.round() : null,
                );
            if (!context.mounted) return;
            Navigator.of(context).pop();
            showLocalSuccess(context, '"$name" added to the catalogue.');
          },
          child: const Text('Add to catalogue'),
        ),
      ],
    );
  }
}

/// Add or remove members of a department, drawn from its own branch's roll.
Future<void> showDepartmentMemberPicker(
  BuildContext context, {
  required Department department,
  required String typeName,
}) {
  return showDialog<void>(
    context: context,
    builder: (_) => _MemberPickerDialog(
      department: department,
      typeName: typeName,
    ),
  );
}

class _MemberPickerDialog extends ConsumerStatefulWidget {
  const _MemberPickerDialog({
    required this.department,
    required this.typeName,
  });

  final Department department;
  final String typeName;

  @override
  ConsumerState<_MemberPickerDialog> createState() =>
      _MemberPickerDialogState();
}

class _MemberPickerDialogState extends ConsumerState<_MemberPickerDialog> {
  late Set<String> _selected;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _selected = widget.department.memberIds.toSet();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final type =
        ref.watch(departmentTypeByIdProvider(widget.department.typeId));
    final branch = ref.watch(branchByIdProvider(widget.department.branchId));

    // Candidates come only from this department's own branch, and must satisfy
    // any age restriction on the type.
    final needle = _query.trim().toLowerCase();
    final candidates = ref
        .watch(membersAllProvider)
        .where((m) => m.branchId == widget.department.branchId)
        .where((m) {
          if (type?.ageRange == null) return true;
          final age = m.ageAt(DateTime.now().toUtc());
          return age >= type!.ageRange!.min && age <= type.ageRange!.max;
        })
        .where((m) => needle.isEmpty || m.fullName.toLowerCase().contains(needle))
        .toList()
      ..sort((a, b) => a.lastName.compareTo(b.lastName));

    return AlertDialog(
      title: Text('${widget.typeName} members'),
      content: SizedBox(
        width: 520,
        height: 480,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type?.ageRange == null
                  ? 'Members of ${branch?.name ?? 'this branch'}.'
                  : 'Members of ${branch?.name ?? 'this branch'} aged '
                      '${type!.ageRange!.min}–${type.ageRange!.max}. '
                      'Others are not eligible and are not listed.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(
                hintText: 'Search members…',
                prefixIcon: Icon(Icons.search, size: 18),
                isDense: true,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${_selected.length} selected of ${candidates.length} eligible',
              style: theme.textTheme.labelSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: candidates.isEmpty
                  ? const EmptyState(
                      title: 'No eligible members',
                      description:
                          'Nobody at this branch matches the age range for this department.',
                      icon: Icons.person_search_outlined,
                    )
                  : ListView.builder(
                      itemCount: candidates.length,
                      itemBuilder: (context, i) {
                        final m = candidates[i];
                        return CheckboxListTile(
                          dense: true,
                          value: _selected.contains(m.id),
                          onChanged: (on) => setState(() {
                            if (on == true) {
                              _selected.add(m.id);
                            } else {
                              _selected.remove(m.id);
                            }
                          }),
                          title: Text(m.fullName,
                              style: theme.textTheme.bodyMedium),
                          subtitle: Text(
                            '${m.ageAt(DateTime.now().toUtc())} yrs · ${m.phone}',
                            style: theme.textTheme.labelSmall,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            await ref
                .read(repositoryProvider)
                .setDepartmentMembers(widget.department.id, _selected);
            if (!context.mounted) return;
            Navigator.of(context).pop();
            showLocalSuccess(
              context,
              '${_selected.length} members saved to ${widget.typeName}.',
            );
          },
          child: const Text('Save members'),
        ),
      ],
    );
  }
}

Widget _label(BuildContext context, String text) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
