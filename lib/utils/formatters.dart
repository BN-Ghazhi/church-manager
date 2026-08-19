import 'package:intl/intl.dart';

/// Shared formatters. The locale is pinned so output is identical on every
/// platform the app is compiled for.
class Fmt {
  const Fmt._();

  static const locale = 'en_GH';
  static const currencySymbol = 'GH₵';

  static final _currency = NumberFormat.currency(
    locale: locale,
    symbol: currencySymbol,
    decimalDigits: 0,
  );
  static final _number = NumberFormat.decimalPattern(locale);
  static final _date = DateFormat('d MMM yyyy', locale);
  static final _dateLong = DateFormat('EEEE, d MMMM yyyy', locale);
  static final _time = DateFormat('h:mm a', locale);
  static final _monthShort = DateFormat('MMM', locale);

  static String currency(num value) => _currency.format(value);

  /// Compact currency for KPI tiles: GH₵16.2M, GH₵840K.
  static String compactCurrency(num value) {
    final abs = value.abs();
    if (abs >= 1e9) return '$currencySymbol${(value / 1e9).toStringAsFixed(1)}B';
    if (abs >= 1e6) return '$currencySymbol${(value / 1e6).toStringAsFixed(1)}M';
    if (abs >= 1e3) return '$currencySymbol${(value / 1e3).toStringAsFixed(1)}K';
    return currency(value);
  }

  static String number(num value) => _number.format(value);

  static String compactNumber(num value) {
    final abs = value.abs();
    if (abs >= 1e6) return '${(value / 1e6).toStringAsFixed(1)}M';
    if (abs >= 1e3) return '${(value / 1e3).toStringAsFixed(0)}k';
    return number(value);
  }

  /// A share of a total, as a whole percentage.
  ///
  /// Returns "—" when the total is zero rather than NaN, which is what a fresh
  /// install would otherwise show everywhere.
  static String share(num part, num total) =>
      total == 0 ? '—' : '${(part / total * 100).round()}%';

  static String percent(double value, {int digits = 1}) =>
      '${value > 0 ? '+' : ''}${value.toStringAsFixed(digits)}%';

  static String date(DateTime value) => _date.format(value);
  static String dateLong(DateTime value) => _dateLong.format(value);
  static String time(DateTime value) => _time.format(value);
  static String monthShort(DateTime value) => _monthShort.format(value);
  static String dateTime(DateTime value) => '${date(value)} · ${time(value)}';

  /// "3 days ago" / "in 2 weeks", relative to the dataset's fixed now.
  static String relative(DateTime value, DateTime now) {
    final diff = value.difference(now);
    final future = !diff.isNegative;
    final abs = diff.abs();

    String phrase(int n, String unit) {
      final plural = n == 1 ? unit : '${unit}s';
      return future ? 'in $n $plural' : '$n $plural ago';
    }

    if (abs.inDays >= 365) return phrase(abs.inDays ~/ 365, 'year');
    if (abs.inDays >= 30) return phrase(abs.inDays ~/ 30, 'month');
    if (abs.inDays >= 7) return phrase(abs.inDays ~/ 7, 'week');
    if (abs.inDays >= 1) return phrase(abs.inDays, 'day');
    if (abs.inHours >= 1) return phrase(abs.inHours, 'hour');
    if (abs.inMinutes >= 1) return phrase(abs.inMinutes, 'minute');
    return 'just now';
  }
}
