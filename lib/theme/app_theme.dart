import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens for the whole app.
///
/// Flutter has no Tailwind, so this file plays the role `globals.css` plays in a
/// web build: one place that defines colour, radius, spacing and type. Widgets
/// read from `Theme.of(context)` or from [AppSpacing] / [AppRadius] rather than
/// hard-coding values, so a change here reaches every screen.
class AppTheme {
  const AppTheme._();

  static const seed = Color(0xFF1A1A1A);

  /// Semantic accents used by status pills, charts and ministry cards. These sit
  /// outside the Material colour scheme because they carry meaning, not brand.
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFF43F5E);
  static const info = Color(0xFF3B82F6);
  static const violet = Color(0xFF8B5CF6);
  static const cyan = Color(0xFF06B6D4);

  /// Ordered palette for chart series. Legible on both light and dark surfaces.
  static const chartColors = <Color>[
    info,
    success,
    warning,
    violet,
    danger,
    cyan,
    Color(0xFF84CC16),
  ];

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
      surface: isDark ? const Color(0xFF0A0A0A) : Colors.white,
    ).copyWith(
      primary: isDark ? Colors.white : const Color(0xFF171717),
      onPrimary: isDark ? const Color(0xFF0A0A0A) : Colors.white,
      error: danger,
    );

    final textTheme = GoogleFonts.interTextTheme(
      ThemeData(brightness: brightness).textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: isDark
          ? const Color(0xFF0A0A0A)
          : const Color(0xFFFAFAFA),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant.withValues(alpha: 0.6),
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.7),
          ),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.02),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        border: _inputBorder(scheme.outlineVariant),
        enabledBorder: _inputBorder(scheme.outlineVariant),
        focusedBorder: _inputBorder(scheme.primary, width: 1.6),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 4,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          side: BorderSide(color: scheme.outlineVariant),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 4,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primary.withValues(alpha: 0.1),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        side: BorderSide.none,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF262626) : const Color(0xFF171717),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        textStyle: textTheme.bodySmall?.copyWith(color: Colors.white),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: BorderSide(color: color, width: width),
      );
}

/// Spacing scale. Using named steps instead of raw numbers keeps rhythm
/// consistent across screens the same way a utility scale does on the web.
class AppSpacing {
  const AppSpacing._();

  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

class AppRadius {
  const AppRadius._();

  static const sm = 6.0;
  static const md = 10.0;
  static const lg = 14.0;
  static const xl = 20.0;
}

/// Layout breakpoints. The shell switches between a drawer, a rail and a full
/// sidebar at these widths — the desktop/mobile equivalent of `md:` / `lg:`.
/// The colour behind an [AccentToken].
///
/// Lives here rather than beside any one screen: branches, departments and
/// ministries all colour themselves from the same six tokens, and three private
/// copies of this switch had already started to drift.
Color accentColor(AccentToken token) => switch (token) {
      AccentToken.blue => AppTheme.info,
      AccentToken.emerald => AppTheme.success,
      AccentToken.amber => AppTheme.warning,
      AccentToken.violet => AppTheme.violet,
      AccentToken.rose => AppTheme.danger,
      AccentToken.cyan => AppTheme.cyan,
    };

/// Heights that must agree across the shell.
///
/// The sidebar header and the top bar each carry a bottom border, and they sit
/// side by side — so if their heights differ by even a few pixels the two rules
/// do not meet and the seam is visible across the top of the window. Both read
/// this constant rather than each hard-coding a number that later drifts.
class AppMetrics {
  const AppMetrics._();

  static const headerHeight = 60.0;
}

class AppBreakpoints {
  const AppBreakpoints._();

  static const compact = 700.0;
  static const medium = 1100.0;

  static bool isCompact(double width) => width < compact;
  static bool isMedium(double width) => width >= compact && width < medium;
  static bool isExpanded(double width) => width >= medium;
}
