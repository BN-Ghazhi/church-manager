import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Standard scroll container and max-width for every screen's body.
///
/// Keeps content from stretching uncomfortably wide on a large desktop window
/// while staying edge-to-edge on a phone.
class PageBody extends StatelessWidget {
  const PageBody({super.key, required this.children, this.maxWidth = 1360});

  final List<Widget> children;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final pad = AppBreakpoints.isCompact(width) ? AppSpacing.md : AppSpacing.lg;

    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const SizedBox(height: AppSpacing.md + 4),
                children[i],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Responsive grid that reflows its children into as many equal columns as fit.
///
/// This is the layout workhorse: KPI rows, card grids and two-column sections
/// all use it instead of hand-written breakpoint logic.
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.minItemWidth = 260,
    this.spacing = AppSpacing.md,
    this.maxColumns,
  });

  final List<Widget> children;
  final double minItemWidth;
  final double spacing;
  final int? maxColumns;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        var columns = (constraints.maxWidth / minItemWidth).floor();
        columns = columns.clamp(1, maxColumns ?? children.length);
        if (columns < 1) columns = 1;

        final itemWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}

/// Two panels side by side on wide windows, stacked on narrow ones, with the
/// primary panel given proportionally more room.
class SplitRow extends StatelessWidget {
  const SplitRow({
    super.key,
    required this.primary,
    required this.secondary,
    this.primaryFlex = 2,
    this.secondaryFlex = 1,
    this.breakpoint = AppBreakpoints.medium,
  });

  final Widget primary;
  final Widget secondary;
  final int primaryFlex;
  final int secondaryFlex;
  final double breakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              primary,
              const SizedBox(height: AppSpacing.md + 4),
              secondary,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: primaryFlex, child: primary),
            const SizedBox(width: AppSpacing.md + 4),
            Expanded(flex: secondaryFlex, child: secondary),
          ],
        );
      },
    );
  }
}
