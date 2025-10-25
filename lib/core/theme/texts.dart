import 'package:flutter/material.dart';

class ApparenceKitTextTheme extends ThemeExtension<ApparenceKitTextTheme> {
  final TextStyle primary;

  const ApparenceKitTextTheme({
    required this.primary,
  });

  factory ApparenceKitTextTheme.build() => const ApparenceKitTextTheme(
        primary: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
      );

  @override
  ThemeExtension<ApparenceKitTextTheme> copyWith({
    TextStyle? primary,
  }) {
    return ApparenceKitTextTheme(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<ApparenceKitTextTheme> lerp(
    covariant ThemeExtension<ApparenceKitTextTheme>? other,
    double t,
  ) {
    if (other is! ApparenceKitTextTheme) {
      return this;
    }
    return ApparenceKitTextTheme(
      primary: TextStyle.lerp(primary, other.primary, t)!,
    );
  }
}
