import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:go_router/go_router.dart';

import '../providers/permissions.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import 'sparkline.dart';

/// A single KPI tile: label, big number, trend pill and optional sparkline.
///
/// Two things are optional and go together. [accent] tints the card, and
/// [onTap] makes it open something. They are deliberately not automatic: a
/// screen of six identically-coloured cards is just louder, not clearer, and a
/// card that looks pressable but goes nowhere is worse than a plain one. Colour
/// is for the cards worth leading with, and it doubles as the hint that the
/// card does something.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.delta,
    this.hint,
    this.icon,
    this.spark,
    this.invertDelta = false,
    this.accent,
    this.onTap,
    this.tooltip,
  });

  /// Builds a tile straight from a [KpiStat].
  StatCard.fromStat(
    KpiStat stat, {
    Key? key,
    IconData? icon,
    Color? accent,
    VoidCallback? onTap,
    String? tooltip,
  }) : this(
          key: key,
          label: stat.label,
          value: stat.value,
          delta: stat.delta,
          hint: stat.hint,
          spark: stat.spark,
          invertDelta: stat.invertDelta,
          icon: icon,
          accent: accent,
          onTap: onTap,
          tooltip: tooltip,
        );

  final String label;
  final String value;

  /// Percent change vs. the previous period. Null hides the trend pill.
  final double? delta;
  final String? hint;
  final IconData? icon;
  final List<double>? spark;

  /// Set when a *decrease* is the good outcome (e.g. open care requests).
  final bool invertDelta;

  /// Tints the card and its icon. Null leaves it plain.
  final Color? accent;

  /// Makes the whole card a target. Null leaves it inert, with no hover or
  /// ripple, so a card that does nothing does not pretend otherwise.
  final VoidCallback? onTap;

  /// Says where a tap goes, e.g. "Open the member directory".
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final isFlat = delta == null || delta!.abs() < 0.05;
    final isGood = delta == null ? true : (invertDelta ? delta! < 0 : delta! > 0);
    final trendColor =
        isFlat ? scheme.onSurfaceVariant : (isGood ? AppTheme.success : AppTheme.danger);

    final accent = this.accent;

    final card = Card(
      // A tinted card carries its own border in the same hue, otherwise the
      // wash reads as a rendering artefact rather than a deliberate choice.
      color: accent?.withValues(alpha: 0.08),
      shape: accent == null
          ? null
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              side: BorderSide(color: accent.withValues(alpha: 0.28)),
            ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        // Hover and splash only exist when there is somewhere to go.
        hoverColor: onTap == null
            ? Colors.transparent
            : (accent ?? scheme.primary).withValues(alpha: 0.06),
        splashColor: onTap == null
            ? Colors.transparent
            : (accent ?? scheme.primary).withValues(alpha: 0.10),
        child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md + 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (icon != null)
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: accent == null
                          ? scheme.surfaceContainerHighest
                              .withValues(alpha: 0.6)
                          : accent.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(
                      icon,
                      size: 17,
                      color: accent ?? scheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        value,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (delta != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: trendColor.withValues(alpha: 0.12),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.sm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isFlat
                                        ? Icons.remove
                                        : (delta! > 0
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward),
                                    size: 11,
                                    color: trendColor,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    isFlat ? '0%' : Fmt.percent(delta!),
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: trendColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (hint != null) ...[
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                hint!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                if (spark != null && spark!.isNotEmpty) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Sparkline(
                    data: spark!,
                    color: isGood ? AppTheme.success : AppTheme.danger,
                    size: const Size(72, 34),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
      ),
    );

    if (onTap == null || tooltip == null) return card;
    return Tooltip(message: tooltip!, child: card);
  }
}

/// A [StatCard] that navigates, but only when the destination is actually open
/// to the signed-in user.
///
/// Wraps the check every caller would otherwise repeat: a card pointing at a
/// switched-off module, or one the role cannot read, renders as a plain inert
/// tile instead of a link that leads to a redirect. The colour is part of the
/// same decision — a tinted card is the signal that it does something.
class LinkedStatCard extends ConsumerWidget {
  const LinkedStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.route,
    required this.module,
    required this.tooltip,
    this.hint,
    this.icon,
    this.accent,
  });

  final String label;
  final String value;

  /// Where a tap goes, e.g. '/members'.
  final String route;

  /// The module that must be readable for the tap to be offered.
  final String module;
  final String tooltip;
  final String? hint;
  final IconData? icon;
  final Color? accent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final open = ref.watch(canViewProvider(module));

    return StatCard(
      label: label,
      value: value,
      hint: hint,
      icon: icon,
      accent: open ? accent : null,
      onTap: open ? () => context.go(route) : null,
      tooltip: open ? tooltip : null,
    );
  }
}
