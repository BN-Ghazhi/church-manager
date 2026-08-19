import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../config/ghana.dart';
import '../models/models.dart';
import 'form_scaffold.dart';
import '../providers/auth.dart';
import '../providers/permissions.dart';
import '../theme/app_theme.dart';
import 'feedback.dart';
import 'page_scaffold.dart';

/// Create/edit member form.
///
/// Submission is a stub until the API exists — it validates the required
/// fields, reports success and closes, and says plainly that nothing persists.
Future<void> showMemberForm(BuildContext context, {Member? member}) {
  return showDialog<void>(
    context: context,
    builder: (_) => _MemberFormDialog(member: member),
  );
}

class _MemberFormDialog extends ConsumerStatefulWidget {
  const _MemberFormDialog({this.member});

  final Member? member;

  @override
  ConsumerState<_MemberFormDialog> createState() => _MemberFormDialogState();
}

class _MemberFormDialogState extends ConsumerState<_MemberFormDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _region;
  late final TextEditingController _first;
  late final TextEditingController _last;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _address;
  late final TextEditingController _city;
  late final TextEditingController _notes;

  late Gender _gender;
  late MaritalStatus _marital;
  late MemberStatus _status;
  late DateTime _dateOfBirth;
  String? _branchId;
  late bool _baptised;
  bool _saving = false;

  bool get _isEdit => widget.member != null;

  @override
  void initState() {
    super.initState();
    _region = widget.member?.address.state;
    final m = widget.member;
    _first = TextEditingController(text: m?.firstName ?? '');
    _last = TextEditingController(text: m?.lastName ?? '');
    _email = TextEditingController(text: m?.email ?? '');
    _phone = TextEditingController(text: m?.phone ?? '');
    _address = TextEditingController(text: m?.address.line1 ?? '');
    _city = TextEditingController(text: m?.address.city ?? '');
    _notes = TextEditingController(text: m?.notes ?? '');
    _gender = m?.gender ?? Gender.female;
    _marital = m?.maritalStatus ?? MaritalStatus.single;
    _status = m?.status ?? MemberStatus.visitor;
    _dateOfBirth =
        m?.dateOfBirth ?? DateTime.utc(DateTime.now().year - 30, 1, 1);
    _baptised = m?.isBaptized ?? false;
    // New members default to the branch currently in view.
    _branchId = m?.branchId ?? ref.read(selectedBranchProvider);
  }

  @override
  void dispose() {
    for (final c in [_first, _last, _email, _phone, _address, _city, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final branchId = _branchId;
    if (branchId == null) {
      showStubMessage(context, 'Choose a branch first — every member needs one');
      return;
    }

    setState(() => _saving = true);
    final repo = ref.read(repositoryProvider);
    final name = '${_first.text.trim()} ${_last.text.trim()}';

    try {
      if (_isEdit) {
        await repo.updateMember(
          widget.member!.id,
          firstName: _first.text.trim(),
          lastName: _last.text.trim(),
          email: _email.text.trim(),
          phone: Ghana.formatPhone(_phone.text),
          branchId: branchId,
          gender: _gender,
          dateOfBirth: _dateOfBirth,
          maritalStatus: _marital,
          status: _status,
          isBaptized: _baptised,
          addressLine: _address.text.trim(),
          city: _city.text.trim(),
          state: _region ?? '',
          notes: _notes.text.trim(),
        );
      } else {
        await repo.createMember(
          firstName: _first.text.trim(),
          lastName: _last.text.trim(),
          branchId: branchId,
          gender: _gender,
          dateOfBirth: _dateOfBirth,
          maritalStatus: _marital,
          status: _status,
          isBaptized: _baptised,
          email: _email.text.trim(),
          phone: Ghana.formatPhone(_phone.text),
          addressLine: _address.text.trim(),
          city: _city.text.trim(),
          state: _region ?? '',
          notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
        );
      }

      if (!mounted) return;
      Navigator.of(context).pop();
      showLocalSuccess(
        context,
        _isEdit ? 'Saved changes to $name.' : '$name added to the directory.',
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => _saving = false);
      showStubMessage(context, 'Could not save: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEdit ? 'Edit member' : 'Add a new member'),
      content: SizedBox(
        width: 560,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isEdit
                      ? "Update this member's personal and church details."
                      : 'Capture the essentials now — you can complete the profile later.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: AppSpacing.md + 4),
                ResponsiveGrid(
                  minItemWidth: 230,
                  maxColumns: 2,
                  children: [
                    _field(
                      'First name',
                      TextFormField(
                        controller: _first,
                        decoration: const InputDecoration(hintText: 'Grace'),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'First name is required'
                            : null,
                      ),
                    ),
                    _field(
                      'Last name',
                      TextFormField(
                        controller: _last,
                        decoration: const InputDecoration(hintText: 'Mensah'),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Last name is required'
                            : null,
                      ),
                    ),
                    _field(
                      'Email',
                      TextFormField(
                        controller: _email,
                        decoration:
                            const InputDecoration(hintText: 'grace@example.com'),
                      ),
                    ),
                    _field(
                      'Phone',
                      TextFormField(
                        controller: _phone,
                        decoration: const InputDecoration(
                            hintText: '+233 24 123 4567'),
                      ),
                    ),
                    _field(
                      'Gender',
                      DropdownButtonFormField<Gender>(
                        initialValue: _gender,
                        items: [
                          for (final g in Gender.values)
                            DropdownMenuItem(value: g, child: Text(g.label)),
                        ],
                        onChanged: (v) => setState(() => _gender = v!),
                      ),
                    ),
                    _field(
                      'Marital status',
                      DropdownButtonFormField<MaritalStatus>(
                        initialValue: _marital,
                        items: [
                          for (final s in MaritalStatus.values)
                            DropdownMenuItem(value: s, child: Text(s.label)),
                        ],
                        onChanged: (v) => setState(() => _marital = v!),
                      ),
                    ),
                    _field(
                      'Membership status',
                      DropdownButtonFormField<MemberStatus>(
                        initialValue: _status,
                        items: [
                          for (final s in MemberStatus.values)
                            DropdownMenuItem(value: s, child: Text(s.label)),
                        ],
                        onChanged: (v) => setState(() => _status = v!),
                      ),
                    ),
                    _field(
                      'Home branch',
                      DropdownButtonFormField<String>(
                        initialValue: _branchId,
                        isExpanded: true,
                        hint: const Text('Choose a branch'),
                        items: [
                          for (final b in ref.watch(visibleBranchesProvider))
                            DropdownMenuItem(
                              value: b.id,
                              child:
                                  Text(b.name, overflow: TextOverflow.ellipsis),
                            ),
                        ],
                        onChanged: (v) => setState(() => _branchId = v),
                      ),
                    ),
                    _field(
                      'Date of birth',
                      InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _dateOfBirth,
                            firstDate: DateTime(1920),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() => _dateOfBirth = DateTime.utc(
                                picked.year, picked.month, picked.day));
                          }
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(),
                          child: Text(
                            '${_dateOfBirth.day}/${_dateOfBirth.month}/${_dateOfBirth.year}',
                          ),
                        ),
                      ),
                    ),
                    _field(
                      'Address',
                      TextFormField(
                        controller: _address,
                        decoration: const InputDecoration(
                            hintText: '14 Ring Road Central, Adabraka'),
                      ),
                    ),
                    _field(
                      'City or town',
                      TextFormField(
                        controller: _city,
                        decoration: const InputDecoration(hintText: 'Accra'),
                        // Fills the region from a recognised city, unless one
                        // has already been chosen.
                        onChanged: (value) {
                          if (_region != null && _region!.isNotEmpty) return;
                          final inferred = Ghana.regionForCity(value);
                          if (inferred != null) {
                            setState(() => _region = inferred);
                          }
                        },
                      ),
                    ),
                    RegionField(
                      value: _region,
                      required: false,
                      onChanged: (v) => setState(() => _region = v),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                _field(
                  'Pastoral notes',
                  TextFormField(
                    controller: _notes,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Anything the pastoral team should know…',
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SwitchListTile(
                  value: _baptised,
                  onChanged: (v) => setState(() => _baptised = v),
                  title: const Text('Baptised'),
                  subtitle: const Text('Has this member been baptised by immersion?'),
                  contentPadding: EdgeInsets.zero,
                ),
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
          onPressed: _saving ? null : _submit,
          child: _saving
              ? const SizedBox(
                  width: 16, height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : Text(_isEdit ? 'Save changes' : 'Add member'),
        ),
      ],
    );
  }

  Widget _field(String label, Widget control) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        control,
      ],
    );
  }
}
