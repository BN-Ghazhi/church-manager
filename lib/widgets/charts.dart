import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';

/// How a chart should format its values in axes and tooltips.
enum ValueFormat { number, currency, percent }

String _format(ValueFormat format, double value) => switch (format) {
      ValueFormat.number => Fmt.compactNumber(value),
      ValueFormat.currency => Fmt.compactCurrency(value),
      ValueFormat.percent => '${value.toStringAsFixed(1)}%',
    };

/// Two-series area chart — attendance, giving, any time series.
class TrendChart extends StatelessWidget {
  const TrendChart({
    super.key,
    required this.data,
    required this.valueLabel,
    this.compareLabel,
    this.format = ValueFormat.number,
    this.height = 260,
  });

  final List<TrendPoint> data;
  final String valueLabel;

  /// Label for the second series; null draws a single line.
  final String? compareLabel;
  final ValueFormat format;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return SizedBox(height: height);

    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final hasCompare = compareLabel != null;

    final maxValue = data
        .map((p) => [p.value, p.compare ?? 0].reduce((a, b) => a > b ? a : b))
        .reduce((a, b) => a > b ? a : b);
    final top = maxValue * 1.15;

    return Column(
      children: [
        SizedBox(
          height: height,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: top,
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => scheme.inverseSurface,
                  getTooltipItems: (spots) => spots
                      .map((s) => LineTooltipItem(
                            _format(format, s.y),
                            text.labelSmall!.copyWith(
                              color: scheme.onInverseSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                      .toList(),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (_) => FlLine(
                  color: scheme.outlineVariant.withValues(alpha: 0.5),
                  strokeWidth: 1,
                  dashArray: const [4, 4],
                ),
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 46,
                    getTitlesWidget: (value, meta) {
                      if (value == meta.max) return const SizedBox.shrink();
                      return Text(
                        _format(format, value),
                        style: text.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 26,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final i = value.toInt();
                      if (i < 0 || i >= data.length) {
                        return const SizedBox.shrink();
                      }
                      // Thin out labels so they never collide.
                      final step = (data.length / 6).ceil();
                      if (i % step != 0) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          data[i].label,
                          style: text.labelSmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            fontSize: 10,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              lineBarsData: [
                _series(
                  [for (var i = 0; i < data.length; i++) FlSpot(i.toDouble(), data[i].value)],
                  AppTheme.chartColors[0],
                ),
                if (hasCompare)
                  _series(
                    [
                      for (var i = 0; i < data.length; i++)
                        FlSpot(i.toDouble(), data[i].compare ?? 0)
                    ],
                    AppTheme.chartColors[1],
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm + 4),
        ChartLegend(
          entries: [
            (valueLabel, AppTheme.chartColors[0]),
            if (hasCompare) (compareLabel!, AppTheme.chartColors[1]),
          ],
        ),
      ],
    );
  }

  LineChartBarData _series(List<FlSpot> spots, Color color) => LineChartBarData(
        spots: spots,
        isCurved: true,
        curveSmoothness: 0.28,
        preventCurveOverShooting: true,
        color: color,
        barWidth: 2.4,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color.withValues(alpha: 0.28),
              color.withValues(alpha: 0.02),
            ],
          ),
        ),
      );
}

/// Single-series bar chart for distributions and category comparisons.
class CategoryBarChart extends StatelessWidget {
  const CategoryBarChart({
    super.key,
    required this.data,
    this.format = ValueFormat.number,
    this.horizontal = false,
    this.height = 260,
  });

  final List<CategoryPoint> data;
  final ValueFormat format;

  /// Draws bars left-to-right, which suits long category labels.
  final bool horizontal;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return SizedBox(height: height);

    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final maxValue = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: height,
      child: BarChart(
        BarChartData(
          maxY: maxValue * 1.18,
          alignment: BarChartAlignment.spaceAround,
          rotationQuarterTurns: horizontal ? 1 : 0,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => scheme.inverseSurface,
              getTooltipItem: (group, _, rod, _) => BarTooltipItem(
                '${data[group.x].label}\n',
                text.labelSmall!.copyWith(color: scheme.onInverseSurface),
                children: [
                  TextSpan(
                    text: _format(format, rod.toY),
                    style: text.labelSmall!.copyWith(
                      color: scheme.onInverseSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => FlLine(
              color: scheme.outlineVariant.withValues(alpha: 0.5),
              strokeWidth: 1,
              dashArray: const [4, 4],
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: !horizontal,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  if (value == meta.max) return const SizedBox.shrink();
                  return Text(
                    _format(format, value),
                    style: text.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: horizontal ? 158 : 30,
                getTitlesWidget: (value, meta) {
                  final i = value.toInt();
                  if (i < 0 || i >= data.length) {
                    return const SizedBox.shrink();
                  }
                  final label = Text(
                    data[i].label,
                    textAlign: horizontal ? TextAlign.right : TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontSize: 10,
                      height: 1.15,
                    ),
                  );

                  // The whole chart is rotated a quarter turn to lay bars out
                  // horizontally, which rotates axis text with it. Counter-
                  // rotating just the label puts it back upright and readable.
                  return Padding(
                    padding: EdgeInsets.only(
                      top: horizontal ? 0 : 6,
                      right: horizontal ? 10 : 0,
                    ),
                    child: horizontal
                        ? RotatedBox(
                            quarterTurns: 3,
                            child: SizedBox(width: 150, child: label),
                          )
                        : label,
                  );
                },
              ),
            ),
          ),
          barGroups: [
            for (var i = 0; i < data.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: data[i].value,
                    color: AppTheme.chartColors[i % AppTheme.chartColors.length],
                    width: horizontal ? 14 : 20,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// Donut for part-to-whole splits — funds, gender, channel mix.
class DonutChart extends StatelessWidget {
  const DonutChart({
    super.key,
    required this.data,
    this.format = ValueFormat.number,
    this.height = 240,
  });

  final List<CategoryPoint> data;
  final ValueFormat format;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return SizedBox(height: height);

    final total = data.fold(0.0, (sum, d) => sum + d.value);

    return Column(
      children: [
        SizedBox(
          height: height,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: double.infinity,
              startDegreeOffset: -90,
              sections: [
                for (var i = 0; i < data.length; i++)
                  PieChartSectionData(
                    value: data[i].value,
                    color:
                        AppTheme.chartColors[i % AppTheme.chartColors.length],
                    radius: 26,
                    showTitle: false,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ChartLegend(
          entries: [
            for (var i = 0; i < data.length; i++)
              (
                '${data[i].label} · ${total == 0 ? 0 : (data[i].value / total * 100).round()}%',
                AppTheme.chartColors[i % AppTheme.chartColors.length],
              ),
          ],
        ),
      ],
    );
  }
}

/// Shared legend so every chart labels its series the same way.
class ChartLegend extends StatelessWidget {
  const ChartLegend({super.key, required this.entries});

  final List<(String, Color)> entries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: [
        for (final (label, color) in entries)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
