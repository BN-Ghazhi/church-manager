import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../models/models.dart';
import '../providers/auth.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import 'feedback.dart';

/// Compose a campaign to a saved or ad-hoc audience.
///
/// Nothing is actually delivered — the dialog validates and reports, and says
/// so plainly, until a messaging provider is connected.
Future<void> showComposeForm(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (_) => const _ComposeDialog(),
  );
}

class _ComposeDialog extends ConsumerStatefulWidget {
  const _ComposeDialog();

  @override
  ConsumerState<_ComposeDialog> createState() => _ComposeDialogState();
}

class _ComposeDialogState extends ConsumerState<_ComposeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _subject = TextEditingController();
  final _body = TextEditingController();

  CampaignChannel _channel = CampaignChannel.email;
  String _audience = 'All members';

  @override
  void dispose() {
    _subject.dispose();
    _body.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final subject = _subject.text.trim();

    final branchId = ref.read(selectedBranchProvider) ??
        ref.read(visibleBranchesProvider).firstOrNull?.id;
    if (branchId == null) return;

    final recipients = ref.read(membersProvider).length;

    await ref.read(repositoryProvider).queueCampaign(
          branchId: branchId,
          subject: subject,
          body: _body.text.trim(),
          channel: _channel,
          audience: _audience,
          recipients: recipients,
        );

    if (!mounted) return;
    Navigator.of(context).pop();
    // The record is saved; delivery is not, and the message says so.
    showLocalSuccess(
      context,
      'Queued "$subject" for $recipients recipients. '
      'Saved to the database — nothing is transmitted until a provider is connected.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final audiences = <String>{
      'All members',
      'Active members only',
      'Visitors (last 30 days)',
      'Leaders',
      for (final d in ref.watch(departmentsProvider))
        ref.watch(departmentTypeByIdProvider(d.typeId))?.name ?? 'Department',
    }.toList();

    return AlertDialog(
      title: const Text('Compose a message'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pick a channel and an audience, then write your message.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: AppSpacing.md + 4),
                Text('Channel',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                SegmentedButton<CampaignChannel>(
                  segments: [
                    for (final c in CampaignChannel.values)
                      ButtonSegment(value: c, label: Text(c.label)),
                  ],
                  selected: {_channel},
                  showSelectedIcon: false,
                  onSelectionChanged: (s) => setState(() => _channel = s.first),
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Audience',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _audience,
                  isExpanded: true,
                  items: [
                    for (final a in audiences)
                      DropdownMenuItem(
                        value: a,
                        child: Text(a, overflow: TextOverflow.ellipsis),
                      ),
                  ],
                  onChanged: (v) => setState(() => _audience = v!),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  _channel == CampaignChannel.email ? 'Subject' : 'Title',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _subject,
                  decoration: const InputDecoration(
                      hintText: 'Sunday service reminder'),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'A subject is required'
                      : null,
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Message',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _body,
                  maxLines: 5,
                  decoration:
                      const InputDecoration(hintText: 'Dear church family, …'),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'A message body is required'
                      : null,
                ),
                const SizedBox(height: 6),
                Text(
                  _channel == CampaignChannel.sms
                      ? 'SMS is billed per 160 characters.'
                      : 'Plain text for now; rich formatting comes with the editor.',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
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
        FilledButton.icon(
          onPressed: _submit,
          icon: const Icon(Icons.send, size: 16),
          label: const Text('Send now'),
        ),
      ],
    );
  }
}
