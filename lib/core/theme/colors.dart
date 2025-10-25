import 'package:flutter/material.dart';

class ApparenceKitColors extends ThemeExtension<ApparenceKitColors> {
  final Color primary;
  final Color onPrimary;

  final Color background;
  final Color onBackground;

  final Color surface;
  final Color onSurface;

  final Color grey1;
  final Color grey2;
  final Color grey3;
  final Color error;

  const ApparenceKitColors({
    required this.primary,
    required this.onPrimary,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.error,
    required this.grey1,
    required this.grey2,
    required this.grey3,
  });

  factory ApparenceKitColors.light() => const ApparenceKitColors(
        primary: Color(0xFF1E88E5),
        onPrimary: Color(0xFFFFFFFF),
        background: Color(0xFFFFFFFF),
        onBackground: Color(0xFF000000),
        surface: Color(0xFFFAFAFA),
        onSurface: Color(0xFF000000),
        error: Color(0xFFB00020),
        grey1: Color(0xFFBEC1C3),
        grey2: Color(0xFF7D8488),
        grey3: Color(0xFF263238),
      );

  factory ApparenceKitColors.dark() => const ApparenceKitColors(
        primary: Color(0xFF1E88E5),
        onPrimary: Color(0xFFFFFFFF),
        background: Color(0xFF0A0A0A),
        onBackground: Color(0xFFFAFAFA),
        surface: Color(0xFF161616),
        onSurface: Color(0xFFFFFFFF),
        error: Color(0xFFCF6679),
        grey1: Color(0xFF263238),
        grey2: Color(0xFF7D8488),
        grey3: Color(0xFFBEC1C3),
      );

  @override
  ThemeExtension<ApparenceKitColors> copyWith({
    Color? primary,
    Color? onPrimary,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? error,
    Color? grey1,
    Color? grey2,
    Color? grey3,
  }) {
    return ApparenceKitColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      error: error ?? this.error,
      grey1: grey1 ?? this.grey1,
      grey2: grey2 ?? this.grey2,
      grey3: grey3 ?? this.grey3,
    );
  }

  @override
  ThemeExtension<ApparenceKitColors> lerp(
    covariant ThemeExtension<ApparenceKitColors>? other,
    double t,
  ) {
    if (other == null || other is! ApparenceKitColors) return this;

    return ApparenceKitColors(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      error: Color.lerp(error, other.error, t)!,
      grey1: Color.lerp(grey1, other.grey1, t)!,
      grey2: Color.lerp(grey2, other.grey2, t)!,
      grey3: Color.lerp(grey3, other.grey3, t)!,
    );
  }
}
