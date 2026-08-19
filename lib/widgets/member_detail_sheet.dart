import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:go_router/go_router.dart';

import '../models/models.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../utils/clock.dart';
import '../utils/formatters.dart';
import 'collapsible.dart';
import 'member_form.dart';

/// Shows one member in a modal, including whether they have been present.
///
/// The attendance block is the reason this exists: a headcount tells you how
/// many came, but not *who*, and the question a pastor actually asks is whether
/// a particular person has been in church lately.
void showMemberDetail(BuildContext context, WidgetRef ref, Member member) {
  showDetailSheet<void>(
    context,
    title: member.fullName,
    subtitle: [
      member.status.label,
      ref.read(branchNameProvider(member.branchId)),
      if (member.phone.isNotEmpty) member.phone,
    ].join(' · '),
    children: [
      DetailRows(entries: {
        'Phone': member.phone,
        'Email': member.email,
        'Gender': member.gender.label,
        'Age': '${member.ageAt(appNow())}',
        'Date of birth': Fmt.date(member.dateOfBirth),
        'Marital status': member.maritalStatus.label,
        'Joined': Fmt.date(member.joinedAt),
        'Baptised': member.isBaptized ? 'Yes' : 'No',
        'Address': member.address.full,
        'Departments': _departments(ref, member),
        'Tags': member.tags.join(', '),
      }),
      const SizedBox(height: AppSpacing.lg),
      _AttendanceBlock(member: member),
    ],
    actions: [
      if (ref.read(canEditProvider('Members')))
        OutlinedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
            showMemberForm(context, member: member);
          },
          icon: const Icon(Icons.edit_outlined, size: 16),
          label: const Text('Edit'),
        ),
      FilledButton.icon(
        onPressed: () {
          Navigator.of(context).pop();
          context.go('/members/${member.id}');
        },
        icon: const Icon(Icons.open_in_new, size: 16),
        label: const Text('Full profile'),
      ),
    ],
  );
}

String _departments(WidgetRef ref, Member member) => ref
    .read(departmentsProvider)
    .where((d) => d.memberIds.contains(member.id))
    .map((d) => ref.read(departmentNameProvider(d.id)))
    .join(', ');

/// Was this member present? Answered as a rate, then service by service.
class _AttendanceBlock extends ConsumerWidget {
  const _AttendanceBlock({required this.member});

  final Member member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final rate = ref.watch(memberAttendanceRateProvider(member));
    final history = ref.watch(memberAttendanceProvider(member.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Attendance', style: theme.textTheme.titleSmall),
            const SizedBox(width: AppSpacing.sm),
            // Expanded, because the rate sentence is long and the sheet is
            // narrow — without it the row overflows on a modest window.
            Expanded(
              child: rate.when(
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
                data: (r) => Text(
                  r.total == 0
                      ? 'no services recorded yet'
                      : '${r.attended} of the last ${r.total} services'
                          ' · ${Fmt.share(r.attended, r.total)}',
                  maxLines: 2,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        history.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
          error: (e, _) => Text('Could not load attendance: $e',
              style: theme.textTheme.bodySmall),
          data: (records) {
            if (records.isEmpty) {
              return Text(
                'Never checked in. Use Attendance → Member check-in to mark '
                'them present at a service.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              );
            }
            return Column(
              children: [
                for (final r in records.take(10))
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle,
                            size: 15, color: theme.colorScheme.primary),
                        const SizedBox(width: AppSpacing.sm),
                        SizedBox(
                          width: 96,
                          child: Text(Fmt.date(r.date),
                              style: theme.textTheme.bodySmall),
                        ),
                        Expanded(
                          child: Text(r.serviceName,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              )),
                        ),
                      ],
                    ),
                  ),
                if (records.length > 10)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '+ ${records.length - 10} earlier services',
                        style: theme.textTheme.labelSmall,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
