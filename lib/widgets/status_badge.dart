import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';

/// Semantic tone for a status pill.
///
/// Every module maps its own status vocabulary onto these five tones, so
/// "paid", "resolved" and "active" all look alike and two visually identical
/// statuses can never drift apart.
enum StatusTone { success, warning, danger, info, neutral }

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.tone,
    this.showDot = true,
  });

  /// Builds a badge from any domain enum, using the shared tone mapping.
  factory StatusBadge.of(Object value, {Key? key, bool showDot = true}) {
    return StatusBadge(
      key: key,
      label: labelOf(value),
      tone: toneOf(value),
      showDot: showDot,
    );
  }

  final String label;
  final StatusTone tone;
  final bool showDot;

  /// The one place that decides what colour a status is.
  static StatusTone toneOf(Object value) => switch (value) {
        MemberStatus.active => StatusTone.success,
        MemberStatus.inactive => StatusTone.neutral,
        MemberStatus.visitor => StatusTone.info,
        MemberStatus.transferred => StatusTone.warning,
        ExpenseStatus.paid => StatusTone.success,
        ExpenseStatus.approved => StatusTone.info,
        ExpenseStatus.pending => StatusTone.warning,
        ExpenseStatus.rejected => StatusTone.danger,
        CareStatus.open => StatusTone.warning,
        CareStatus.inProgress => StatusTone.info,
        CareStatus.resolved => StatusTone.success,
        CarePriority.high => StatusTone.danger,
        CarePriority.medium => StatusTone.warning,
        CarePriority.low => StatusTone.neutral,
        CampaignStatus.sent => StatusTone.success,
        CampaignStatus.scheduled => StatusTone.info,
        CampaignStatus.draft => StatusTone.neutral,
        CampaignStatus.failed => StatusTone.danger,
        SlotStatus.filled => StatusTone.success,
        SlotStatus.open => StatusTone.warning,
        SlotStatus.declined => StatusTone.danger,
        AssetCondition.brandNew => StatusTone.success,
        AssetCondition.good => StatusTone.info,
        AssetCondition.fair => StatusTone.warning,
        AssetCondition.needsRepair => StatusTone.danger,
        AccountStatus.active => StatusTone.success,
        AccountStatus.invited => StatusTone.info,
        AccountStatus.suspended => StatusTone.danger,
        PermissionLevel.full => StatusTone.success,
        PermissionLevel.read => StatusTone.info,
        PermissionLevel.none => StatusTone.neutral,
        _ => StatusTone.neutral,
      };

  /// Reads the `label` field every domain enum in this app defines.
  static String labelOf(Object value) => switch (value) {
        MemberStatus v => v.label,
        ExpenseStatus v => v.label,
        CareStatus v => v.label,
        CarePriority v => v.label,
        CampaignStatus v => v.label,
        SlotStatus v => v.label,
        AssetCondition v => v.label,
        AccountStatus v => v.label,
        PermissionLevel v => v.label,
        _ => value.toString(),
      };

  static Color colorOf(StatusTone tone, ColorScheme scheme) => switch (tone) {
        StatusTone.success => AppTheme.success,
        StatusTone.warning => AppTheme.warning,
        StatusTone.danger => AppTheme.danger,
        StatusTone.info => AppTheme.info,
        StatusTone.neutral => scheme.onSurfaceVariant,
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = colorOf(tone, scheme);
    final isNeutral = tone == StatusTone.neutral;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isNeutral ? 0.08 : 0.12),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isNeutral ? scheme.onSurfaceVariant : color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
