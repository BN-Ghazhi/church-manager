import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../providers/permissions.dart';
import '../theme/app_theme.dart';

/// Branch selector for the top bar.
///
/// Only rendered for users who can see more than one branch — a Branch Pastor
/// sees a static label instead, so the UI never implies access they don't have.
class BranchSwitcher extends ConsumerWidget {
  const BranchSwitcher({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final canSwitch = ref.watch(canSwitchBranchProvider);
    final visible = ref.watch(visibleBranchesProvider);
    final selected = ref.watch(selectedBranchProvider);
    final user = ref.watch(currentUserProvider);

    // Single-branch users get a plain, non-interactive label.
    if (!canSwitch) {
      final branch = visible.isEmpty ? null : visible.first;
      return _Pill(
        icon: Icons.location_on_outlined,
        label: branch?.code ?? '—',
        tooltip: branch == null
            ? 'No branch assigned'
            : '${branch.name} · your branch',
        muted: true,
        compact: compact,
      );
    }

    final current = selected == null
        ? null
        : visible.where((b) => b.id == selected).firstOrNull;

    return PopupMenuButton<String?>(
      tooltip: 'Switch branch',
      position: PopupMenuPosition.under,
      onSelected: (value) =>
          ref.read(selectedBranchProvider.notifier).select(value),
      itemBuilder: (context) => [
        if (user.canSeeAllBranches)
          CheckedPopupMenuItem<String?>(
            value: null,
            checked: selected == null,
            child: const Text('All branches'),
          ),
        const PopupMenuDivider(),
        for (final branch in visible)
          CheckedPopupMenuItem<String?>(
            value: branch.id,
            checked: selected == branch.id,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: accentColor(branch.accent),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(branch.name, overflow: TextOverflow.ellipsis),
                ),
                if (branch.isHeadquarters)
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.sm),
                    child: Text('HQ',
                        style: theme.textTheme.labelSmall
                            ?.copyWith(color: scheme.onSurfaceVariant)),
                  ),
              ],
            ),
          ),
      ],
      child: _Pill(
        icon: current == null ? Icons.public : Icons.location_on,
        label: current?.code ?? 'All branches',
        tooltip: current == null
            ? 'Viewing every branch — click to focus one'
            : '${current.name} — click to switch',
        accent: current == null ? null : accentColor(current.accent),
        showChevron: true,
        compact: compact,
      ),
    );
  }
}

/// Shared accent resolver so branch colours are consistent everywhere.
class _Pill extends StatelessWidget {
  const _Pill({
    required this.icon,
    required this.label,
    required this.tooltip,
    this.accent,
    this.muted = false,
    this.showChevron = false,
    this.compact = false,
  });

  final IconData icon;
  final String label;
  final String tooltip;
  final Color? accent;
  final bool muted;
  final bool showChevron;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final color = accent ?? (muted ? scheme.onSurfaceVariant : scheme.onSurface);

    return Tooltip(
      message: tooltip,
      child: Container(
        height: 36,
        padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 12),
        decoration: BoxDecoration(
          color: accent?.withValues(alpha: 0.09) ??
              scheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: accent?.withValues(alpha: 0.3) ?? scheme.outlineVariant,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: color),
            if (!compact) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.labelMedium
                    ?.copyWith(color: color, fontWeight: FontWeight.w600),
              ),
            ],
            if (showChevron) ...[
              const SizedBox(width: 2),
              Icon(Icons.expand_more, size: 15, color: color),
            ],
          ],
        ),
      ),
    );
  }
}
