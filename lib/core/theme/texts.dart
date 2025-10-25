import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApparenceKitTextTheme extends ThemeExtension<ApparenceKitTextTheme> {
  final TextStyle primary;

  const ApparenceKitTextTheme({
    required this.primary,
  });

  factory ApparenceKitTextTheme.build() =>  ApparenceKitTextTheme(
        primary: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w400),
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
