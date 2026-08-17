import 'package:flutter/material.dart';

/// Tiny inline trend line drawn with a CustomPainter.
///
/// Deliberately not a chart-library widget: it renders inside KPI tiles where a
/// full chart would be heavy, and this keeps the tile cheap to build.
class Sparkline extends StatelessWidget {
  const Sparkline({
    super.key,
    required this.data,
    required this.color,
    this.size = const Size(80, 36),
  });

  final List<double> data;
  final Color color;
  final Size size;

  @override
  Widget build(BuildContext context) {
    if (data.length < 2) return SizedBox.fromSize(size: size);
    return CustomPaint(
      size: size,
      painter: _SparklinePainter(data: data, color: color),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.data, required this.color});

  final List<double> data;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final min = data.reduce((a, b) => a < b ? a : b);
    final max = data.reduce((a, b) => a > b ? a : b);
    final range = (max - min).abs() < 0.0001 ? 1.0 : max - min;

    final points = <Offset>[
      for (var i = 0; i < data.length; i++)
        Offset(
          i / (data.length - 1) * size.width,
          size.height - ((data[i] - min) / range) * (size.height - 4) - 2,
        ),
    ];

    final line = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      line.lineTo(p.dx, p.dy);
    }

    final fill = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fill, Paint()..color = color.withValues(alpha: 0.14));
    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.data != data || old.color != color;
}
