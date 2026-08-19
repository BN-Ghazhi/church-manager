import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../theme/app_theme.dart';
import 'page_scaffold.dart';

/// Remembers which collapsible sections the user has folded away.
///
/// Keyed by a stable string so the choice survives navigating away and back —
/// collapsing the stat row on Members and finding it expanded again next visit
/// would make the control feel broken.
final collapsedSectionsProvider =
    NotifierProvider<CollapsedSectionsNotifier, Set<String>>(
        CollapsedSectionsNotifier.new);

class CollapsedSectionsNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  void toggle(String key) {
    state = state.contains(key)
        ? (state.toSet()..remove(key))
        : (state.toSet()..add(key));
  }

  bool isCollapsed(String key) => state.contains(key);
}

/// A section with a header that folds its contents away.
///
/// Used for the KPI rows, which are useful at a glance but take the top third of
/// every screen; someone working through a long table wants that space back.
class CollapsibleSection extends ConsumerWidget {
  const CollapsibleSection({
    super.key,
    required this.sectionKey,
    required this.title,
    required this.child,
    this.subtitle,
    this.initiallyCollapsed = false,
  });

  /// Stable identity for remembering the folded state, e.g. 'members.stats'.
  final String sectionKey;
  final String title;
  final String? subtitle;
  final Widget child;
  final bool initiallyCollapsed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final collapsed = ref.watch(collapsedSectionsProvider).contains(sectionKey);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () =>
              ref.read(collapsedSectionsProvider.notifier).toggle(sectionKey),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(
                  collapsed ? Icons.chevron_right : Icons.expand_more,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  title,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ] else
                  const Spacer(),
                Text(
                  collapsed ? 'Show' : 'Hide',
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
        // AnimatedSize over a conditional child rather than AnimatedCrossFade:
        // the crossfade keeps both children mounted and lays the outgoing one
        // out at full height, so a "collapsed" stat row stayed exactly as tall
        // as before. Dropping the child is what actually reclaims the space.
        AnimatedSize(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          alignment: Alignment.topCenter,
          child: collapsed
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.sm + 4),
                  child: child,
                ),
        ),
      ],
    );
  }
}

/// A right-hand sheet for showing one record's details.
///
/// Preferred over a full page for "click a row to see more": the list stays
/// visible behind it, so closing the detail returns you to exactly where you
/// were in a long table rather than to the top of it.
Future<T?> showDetailSheet<T>(
  BuildContext context, {
  required String title,
  String? subtitle,
  required List<Widget> children,
  List<Widget> actions = const [],
  double width = 560,
}) {
  return showDialog<T>(
    context: context,
    builder: (context) {
      final theme = Theme.of(context);
      final scheme = theme.colorScheme;

      return Dialog(
        insetPadding: const EdgeInsets.all(AppSpacing.lg),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: width,
            maxHeight: MediaQuery.sizeOf(context).height * 0.85,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg, AppSpacing.md + 4, AppSpacing.sm, AppSpacing.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              subtitle,
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      tooltip: 'Close',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ),
                ),
              ),
              if (actions.isNotEmpty) ...[
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  // Wrap, not Row: two or three buttons with long labels do not
                  // fit a narrow sheet side by side, and a Row would overflow
                  // rather than stack them.
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: actions,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}

/// Label and value rows for a detail sheet.
class DetailRows extends StatelessWidget {
  const DetailRows({super.key, required this.entries});

  /// Blank values are skipped, so an incomplete record does not show a column
  /// of empty labels.
  final Map<String, String> entries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visible = entries.entries.where((e) => e.value.trim().isNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in visible)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 132,
                  child: Text(
                    entry.key,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(entry.value, style: theme.textTheme.bodySmall),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// The KPI row at the top of a screen, foldable.
///
/// Every screen used to open with a bare `ResponsiveGrid` of stat cards. Wrapping
/// each one by hand meant repeating the same header, key and grid settings
/// fifteen times, so this is the single widget they all use instead: pass the
/// cards, get a collapsible row with consistent spacing and a remembered state.
class StatRow extends StatelessWidget {
  const StatRow({
    super.key,
    required this.sectionKey,
    required this.children,
    this.title = 'Overview',
    this.subtitle,
    this.minItemWidth = 250,
    this.maxColumns = 4,
  });

  /// Stable identity for the folded state, conventionally .
  final String sectionKey;
  final List<Widget> children;
  final String title;
  final String? subtitle;
  final double minItemWidth;
  final int maxColumns;

  @override
  Widget build(BuildContext context) => CollapsibleSection(
        sectionKey: sectionKey,
        title: title,
        subtitle: subtitle,
        child: ResponsiveGrid(
          minItemWidth: minItemWidth,
          maxColumns: maxColumns,
          children: children,
        ),
      );
}
