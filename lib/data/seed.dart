import 'dart:math' as math;

/// Deterministic pseudo-random helpers.
///
/// Mock data is generated from an integer seed rather than `Random()`, so the
/// dataset is identical on every run and on every platform. That keeps
/// screenshots, tests and demos stable.
class Seed {
  const Seed._();

  /// Stable 0..1 value for a seed.
  static double unit(int seed) {
    final x = math.sin(seed * 12.9898 + 78.233) * 43758.5453;
    return x - x.floorToDouble();
  }

  /// Stable integer in `[min, max]`.
  static int intIn(int seed, int min, int max) =>
      min + (unit(seed) * (max - min + 1)).floor();

  /// Stable element of a list.
  static T pick<T>(List<T> items, int seed) => items[seed.abs() % items.length];

  /// Zero-padded, sortable, human-readable id.
  static String id(String prefix, int index) =>
      '$prefix-${(index + 1).toString().padLeft(4, '0')}';
}

/// The dataset's fixed "today". Every relative date is derived from this so the
/// demo reads consistently no matter when it is run.
final DateTime kDemoNow = DateTime.utc(2026, 8, 14, 9);

DateTime dayOffset(int days) => kDemoNow.add(Duration(days: days));

/// A date at a specific hour, `days` from the demo's today.
DateTime atHour(int days, int hour, [int minute = 0]) {
  final d = dayOffset(days);
  return DateTime.utc(d.year, d.month, d.day, hour, minute);
}

/// Midnight `days` from the demo's today.
DateTime dayOnly(int days) {
  final d = dayOffset(days);
  return DateTime.utc(d.year, d.month, d.day);
}
