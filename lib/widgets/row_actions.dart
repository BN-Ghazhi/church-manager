import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// View / edit / delete buttons for a table row.
///
/// Every table needs these and they should look and behave identically
/// everywhere, so they live here rather than being rebuilt per screen. Actions
/// that are not supplied are simply left out — a table with no detail view
/// shows no eye icon rather than a disabled one.
class RowActions extends StatelessWidget {
  const RowActions({
    super.key,
    this.onView,
    this.onEdit,
    this.onDelete,
    this.deleteTooltip = 'Delete',
  });

  final VoidCallback? onView;
  final VoidCallback? onEdit;

  /// Called only after the user confirms. [RowActions] owns the confirmation,
  /// so no screen can forget to ask.
  final VoidCallback? onDelete;
  final String deleteTooltip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // The row must survive a column narrower than its natural width — a table
    // column is sized by the table, not by these buttons, and an overflow here
    // paints yellow stripes across an otherwise finished screen.
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onView != null)
            _Action(
              icon: Icons.visibility_outlined,
              tooltip: 'View',
              onPressed: onView!,
              color: scheme.onSurfaceVariant,
            ),
          if (onEdit != null)
            _Action(
              icon: Icons.edit_outlined,
              tooltip: 'Edit',
              onPressed: onEdit!,
              color: scheme.onSurfaceVariant,
            ),
          if (onDelete != null)
            _Action(
              icon: Icons.delete_outline,
              tooltip: deleteTooltip,
              onPressed: onDelete!,
              color: AppTheme.danger,
            ),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    required this.color,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 17, color: color),
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      padding: EdgeInsets.zero,
      onPressed: onPressed,
    );
  }
}

/// Asks before deleting, and says what will be lost.
///
/// Deleting a record is not something to do on a stray click, and the person
/// doing it deserves to know whether it can be undone. Returns true only on an
/// explicit confirmation.
Future<bool> confirmDelete(
  BuildContext context, {
  required String what,
  String? consequence,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: Icon(Icons.warning_amber_rounded, color: AppTheme.danger, size: 28),
      title: Text('Delete $what?'),
      content: Text(
        consequence ??
            'This removes it from the system. Records that referenced it keep '
                'their history.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppTheme.danger),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
