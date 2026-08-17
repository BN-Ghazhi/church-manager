import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/repository.dart';
import 'form_scaffold.dart';

/// Assigns a member to a serving slot, or clears it.
///
/// Candidates come from the slot's own branch, because a rota is served by
/// people who attend that campus.
Future<void> showRotaAssignForm(
  BuildContext context, {
  required VolunteerSlot slot,
}) =>
    showDialog<void>(
      context: context,
      builder: (_) => _RotaAssignForm(slot: slot),
    );

class _RotaAssignForm extends ConsumerStatefulWidget {
  const _RotaAssignForm({required this.slot});

  final VolunteerSlot slot;

  @override
  ConsumerState<_RotaAssignForm> createState() => _RotaAssignFormState();
}

class _RotaAssignFormState extends ConsumerState<_RotaAssignForm> {
  String? _memberId;
  late SlotStatus _status;

  @override
  void initState() {
    super.initState();
    _memberId = widget.slot.memberId;
    _status = widget.slot.status;
  }

  @override
  Widget build(BuildContext context) {
    final branch = ref.watch(branchByIdProvider(widget.slot.branchId));

    return FormDialog(
      title: '${widget.slot.role.label} — ${widget.slot.serviceName}',
      description: branch == null
          ? 'Assign someone to this slot.'
          : 'Assign a member of ${branch.name} to this slot.',
      submitLabel: 'Save assignment',
      successMessage: 'Rota updated.',
      fields: [
        MemberField(
          branchId: widget.slot.branchId,
          value: _memberId,
          label: 'Volunteer',
          required: false,
          minimumAge: 13,
          onChanged: (v) => setState(() {
            _memberId = v;
            // Choosing somebody fills the slot; clearing it reopens it.
            _status = v == null ? SlotStatus.open : SlotStatus.filled;
          }),
        ),
        EnumField<SlotStatus>(
          label: 'Status',
          values: SlotStatus.values,
          value: _status,
          labelOf: (v) => v.label,
          onChanged: (v) => setState(() => _status = v),
        ),
      ],
      onSubmit: () => ref.read(repositoryProvider).assignVolunteer(
            widget.slot.id,
            _status == SlotStatus.open ? null : _memberId,
            status: _status,
          ),
    );
  }
}

/// Read-only summary of rota coverage, for the "Review rota" action.
///
/// Publishing a rota is a communication step rather than a data change, so this
/// shows what would go out and where the gaps are instead of pretending to send.
Future<void> showRotaSummary(
  BuildContext context,
  List<VolunteerSlot> slots,
) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      final byDate = <DateTime, List<VolunteerSlot>>{};
      for (final slot in slots) {
        byDate.putIfAbsent(slot.date, () => []).add(slot);
      }
      final dates = byDate.keys.toList()..sort();
      final open = slots.where((s) => s.status != SlotStatus.filled).toList();

      return AlertDialog(
        title: const Text('Rota review'),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  open.isEmpty
                      ? 'Every slot is filled. This rota is ready to publish.'
                      : '${open.length} of ${slots.length} slots still need '
                          'attention. Fill them before publishing.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 16),
                for (final date in dates) ...[
                  Text(
                    '${date.day}/${date.month}/${date.year}',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  for (final slot in byDate[date]!)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Row(
                        children: [
                          Expanded(child: Text(slot.role.label,
                              style: Theme.of(context).textTheme.bodySmall)),
                          Text(
                            slot.status == SlotStatus.filled
                                ? 'Filled'
                                : slot.status.label,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontWeight: slot.status == SlotStatus.filled
                                      ? FontWeight.w400
                                      : FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
