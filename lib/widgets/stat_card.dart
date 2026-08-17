import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import 'sparkline.dart';

/// A single KPI tile: label, big number, trend pill and optional sparkline.
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
  });

  /// Builds a tile straight from a [KpiStat].
  StatCard.fromStat(KpiStat stat, {Key? key, IconData? icon})
      : this(
          key: key,
          label: stat.label,
          value: stat.value,
          delta: stat.delta,
          hint: stat.hint,
          spark: stat.spark,
          invertDelta: stat.invertDelta,
          icon: icon,
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final isFlat = delta == null || delta!.abs() < 0.05;
    final isGood = delta == null ? true : (invertDelta ? delta! < 0 : delta! > 0);
    final trendColor =
        isFlat ? scheme.onSurfaceVariant : (isGood ? AppTheme.success : AppTheme.danger);

    return Card(
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
                      color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(icon, size: 17, color: scheme.onSurfaceVariant),
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
    );
  }
}
