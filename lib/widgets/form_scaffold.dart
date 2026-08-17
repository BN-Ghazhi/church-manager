import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../models/models.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import 'feedback.dart';

/// Shared plumbing for every create/edit dialog.
///
/// Handles the parts that were being repeated in each form: validation gating,
/// a busy state so a slow write cannot be double-submitted, error reporting
/// that shows what actually failed, and closing on success. A form supplies its
/// fields and an `onSubmit`; everything else is here.
class FormDialog extends StatefulWidget {
  const FormDialog({
    super.key,
    required this.title,
    required this.fields,
    required this.onSubmit,
    required this.successMessage,
    this.description,
    this.submitLabel = 'Save',
    this.width = 520,
  });

  final String title;
  final String? description;

  /// Built inside a [Form]; the dialog owns the key and validates for you.
  final List<Widget> fields;

  /// Performs the write. Throwing surfaces the message to the user rather than
  /// failing silently.
  final Future<void> Function() onSubmit;

  /// Shown after a successful write. Receives nothing — build it from the
  /// values the caller already has.
  final String successMessage;
  final String submitLabel;
  final double width;

  @override
  State<FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _busy = false;
  String? _error;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _busy = true;
      _error = null;
    });

    try {
      await widget.onSubmit();
      if (!mounted) return;
      Navigator.of(context).pop();
      showLocalSuccess(context, widget.successMessage);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = '$error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: widget.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.description != null) ...[
                  Text(
                    widget.description!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md + 4),
                ],
                ...widget.fields,
                if (_error != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm + 4),
                    decoration: BoxDecoration(
                      color: AppTheme.danger.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: AppTheme.danger.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.error_outline,
                            size: 16, color: AppTheme.danger),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'Could not save. $_error',
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: AppTheme.danger),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _busy ? null : _submit,
          child: _busy
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(widget.submitLabel),
        ),
      ],
    );
  }
}

/// Labelled field wrapper, so every form lays out identically.
class LabelledField extends StatelessWidget {
  const LabelledField({
    super.key,
    required this.label,
    required this.child,
    this.hint,
  });

  final String label;
  final Widget child;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
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
          child,
          if (hint != null) ...[
            const SizedBox(height: 4),
            Text(
              hint!,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Branch picker limited to what the signed-in user may write to.
///
/// Every record belongs to a branch, and a user must not be able to file one
/// against a branch they cannot see — so the options come from their own scope
/// rather than the full list.
class BranchField extends ConsumerWidget {
  const BranchField({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Branch',
  });

  final String? value;
  final ValueChanged<String?> onChanged;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branches = ref.watch(visibleBranchesProvider);

    // With one branch in scope there is no decision to make; show it as a fact.
    if (branches.length == 1) {
      return LabelledField(
        label: label,
        child: InputDecorator(
          decoration: const InputDecoration(),
          child: Text(branches.first.name),
        ),
      );
    }

    return LabelledField(
      label: label,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        hint: const Text('Choose a branch'),
        items: [
          for (final b in branches)
            DropdownMenuItem(value: b.id, child: Text(b.name)),
        ],
        onChanged: onChanged,
        validator: (v) => v == null ? 'Choose a branch' : null,
      ),
    );
  }
}

/// Member picker scoped to one branch.
class MemberField extends ConsumerWidget {
  const MemberField({
    super.key,
    required this.branchId,
    required this.value,
    required this.onChanged,
    this.label = 'Member',
    this.required = true,
    this.minimumAge,
  });

  final String? branchId;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String label;
  final bool required;

  /// Restricts the list, e.g. so only adults can be named as an approver.
  final int? minimumAge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now().toUtc();
    final candidates = ref
        .watch(membersAllProvider)
        .where((m) => branchId == null || m.branchId == branchId)
        .where((m) => minimumAge == null || m.ageAt(now) >= minimumAge!)
        .toList()
      ..sort((a, b) => a.lastName.compareTo(b.lastName));

    return LabelledField(
      label: label,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        hint: Text(branchId == null ? 'Choose a branch first' : 'Choose a member'),
        items: [
          if (!required)
            const DropdownMenuItem<String>(value: null, child: Text('None')),
          for (final m in candidates.take(300))
            DropdownMenuItem(value: m.id, child: Text(m.fullName)),
        ],
        onChanged: branchId == null ? null : onChanged,
        validator: required && branchId != null
            ? (v) => v == null ? 'Choose a $label'.toLowerCase() : null
            : null,
      ),
    );
  }
}

/// Date picker rendered as a form field.
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return LabelledField(
      label: label,
      child: InkWell(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: value,
            firstDate: firstDate ?? DateTime(2000),
            lastDate: lastDate ?? DateTime(2100),
          );
          if (picked != null) {
            onChanged(DateTime.utc(picked.year, picked.month, picked.day));
          }
        },
        child: InputDecorator(
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.calendar_today_outlined, size: 17),
          ),
          child: Text('${value.day}/${value.month}/${value.year}'),
        ),
      ),
    );
  }
}

/// Money input that validates and parses to a double.
class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.controller,
    this.label = 'Amount',
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return LabelledField(
      label: label,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixText: '${Fmt.currencySymbol} ',
          hintText: '50000',
        ),
        validator: (v) {
          final parsed = double.tryParse((v ?? '').replaceAll(',', '').trim());
          if (parsed == null) return 'Enter an amount';
          if (parsed <= 0) return 'Amount must be greater than zero';
          return null;
        },
      ),
    );
  }
}

/// Dropdown over any enum that exposes a `label`.
class EnumField<T> extends StatelessWidget {
  const EnumField({
    super.key,
    required this.label,
    required this.values,
    required this.value,
    required this.labelOf,
    required this.onChanged,
  });

  final String label;
  final List<T> values;
  final T value;
  final String Function(T) labelOf;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return LabelledField(
      label: label,
      child: DropdownButtonFormField<T>(
        initialValue: value,
        isExpanded: true,
        items: [
          for (final v in values)
            DropdownMenuItem(value: v, child: Text(labelOf(v))),
        ],
        onChanged: (v) => v == null ? null : onChanged(v),
      ),
    );
  }
}

/// Plain text field with optional required validation.
class PlainTextField extends StatelessWidget {
  const PlainTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.required = false,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final bool required;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return LabelledField(
      label: label,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(hintText: hint),
        validator: required
            ? (v) => (v == null || v.trim().isEmpty) ? '$label is required' : null
            : null,
      ),
    );
  }
}

/// Resolves the branch a new record should default to.
///
/// The focused branch when one is selected, otherwise the user's only branch —
/// so single-branch users never have to pick.
String? defaultBranchId(WidgetRef ref) {
  final selected = ref.read(selectedBranchProvider);
  if (selected != null) return selected;
  final visible = ref.read(visibleBranchesProvider);
  return visible.length == 1 ? visible.first.id : null;
}

/// Enum label helpers, so call sites stay short.
String enumLabel(Object value) => switch (value) {
      GivingFund v => v.label,
      PaymentMethod v => v.label,
      ExpenseStatus v => v.label,
      CareType v => v.label,
      CarePriority v => v.label,
      EventCategory v => v.label,
      AssetCondition v => v.label,
      ServingRole v => v.label,
      Weekday v => v.label,
      BranchStatus v => v.label,
      UserRole v => v.label,
      MemberStatus v => v.label,
      _ => value.toString(),
    };
