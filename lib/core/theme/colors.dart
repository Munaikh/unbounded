import 'package:flutter/material.dart';

/// Extension to add utility methods to Color class
extension ColorExtension on Color {
  /// Returns a new color with the specified alpha value
  Color withCustomOpacity(double opacity) {
    return withAlpha((opacity * 255).toInt());
  }
}

class ApparenceKitColors extends ThemeExtension<ApparenceKitColors> {
  // Primary colors
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  // Secondary colors
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;

  // Tertiary colors (accent)
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;

  // Background colors
  final Color background;
  final Color onBackground;

  // Surface colors
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;

  // Error colors
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;

  // Neutral colors (replacing grey1, grey2, grey3)
  final Color neutral100;
  final Color neutral200;
  final Color neutral300;

  // Outline and shadow
  final Color outline;
  final Color outlineVariant;
  final Color shadow;

  // Inverse colors
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color inversePrimary;

  // App logo colors
  final Color appLogoContainer;
  final Color appLogo;

  // Success colors
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;

  // Warning colors
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color favoriteHeart;

  const ApparenceKitColors({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.neutral100,
    required this.neutral200,
    required this.neutral300,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.appLogoContainer,
    required this.appLogo,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.favoriteHeart,
  });

  factory ApparenceKitColors.light() => const ApparenceKitColors(
    // Primary colors
    primary: Color(0xFFEB4335),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFDAD4),
    onPrimaryContainer: Color(0xFF410000),

    // Secondary colors
    secondary: Color(0xFFEF6C5A),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFE0DB),
    onSecondaryContainer: Color(0xFF410000),

    // Tertiary colors (accent)
    tertiary: Color(0xFFFF8A80),
    onTertiary: Color(0xFF410000),
    tertiaryContainer: Color(0xFFFFEDEB),
    onTertiaryContainer: Color(0xFF410000),

    // Background colors
    background: Color(0xFFF7F7F7),
    onBackground: Color(0xFF1A1A1A),

    // Surface colors
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1A1A1A),
    surfaceVariant: Color(0xFFE8E8EC),
    onSurfaceVariant: Color(0xFF45464F),

    // Error colors
    favoriteHeart: Color(0xFFBA1A1A),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    // Neutral colors
    neutral100: Color(0xFFE2E2E6),
    neutral200: Color(0xFFC5C5CD),
    neutral300: Color(0xFF9696A0),

    // Outline and shadow
    outline: Color(0xFF757680),
    outlineVariant: Color(0xFFC5C5CD),
    shadow: Color(0xFF000000),

    // Inverse colors
    inverseSurface: Color(0xFF303030),
    onInverseSurface: Color(0xFFEFEFEF),
    inversePrimary: Color(0xFFFFB4A9),

    // App logo colors
    appLogoContainer: Color(0xFFEB4335),
    appLogo: Color(0xFFFFFFFF),

    // Success colors
    success: Color(0xFF28A745),
    onSuccess: Color(0xFFFFFFFF),
    successContainer: Color(0xFFD4EDDA),
    onSuccessContainer: Color(0xFF155724),

    // Warning colors
    warning: Color(0xFFFFC107),
    onWarning: Color(0xFF212529),
    warningContainer: Color(0xFFFFF3CD),
    onWarningContainer: Color(0xFF856404),
  );

  factory ApparenceKitColors.dark() => const ApparenceKitColors(
    // Primary colors
    primary: Color(0xFFEB4335),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF93000A),
    onPrimaryContainer: Color(0xFFFFDAD4),

    // Secondary colors
    secondary: Color(0xFFFF7B66),
    onSecondary: Color(0xFF410000),
    secondaryContainer: Color(0xFF93000A),
    onSecondaryContainer: Color(0xFFFFDAD4),

    // Tertiary colors (accent)
    tertiary: Color(0xFFFFB4A9),
    onTertiary: Color(0xFF410000),
    tertiaryContainer: Color(0xFF690005),
    onTertiaryContainer: Color(0xFFFFDAD4),

    // Background colors
    background: Color(0xFF121212),
    onBackground: Color(0xFFE6E6E6),

    // Surface colors
    surface: Color(0xFF1E1E1E),
    onSurface: Color(0xFFE6E6E6),
    surfaceVariant: Color(0xFF303033),
    onSurfaceVariant: Color(0xFFC9C9D3),

    // Error colors
    favoriteHeart: Color(0xFFBA1A1A),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    // Neutral colors
    neutral100: Color(0xFF3A3A40),
    neutral200: Color(0xFF5C5C65),
    neutral300: Color(0xFF7E7E8C),

    // Outline and shadow
    outline: Color(0xFF9293A0),
    outlineVariant: Color(0xFF45464F),
    shadow: Color(0xFF000000),

    // Inverse colors
    inverseSurface: Color(0xFFE6E6E6),
    onInverseSurface: Color(0xFF1A1A1A),
    inversePrimary: Color(0xFFFFB4A9),

    // App logo colors
    appLogoContainer: Color(0xFFFFFFFF),
    appLogo: Color(0xFFEB4335),

    // Success colors
    success: Color(0xFF2AAA8A),
    onSuccess: Color(0xFFFFFFFF),
    successContainer: Color(0xFF1E4620),
    onSuccessContainer: Color(0xFFD4EDDA),

    // Warning colors
    warning: Color(0xFFFFD700),
    onWarning: Color(0xFF212529),
    warningContainer: Color(0xFF4D3800),
    onWarningContainer: Color(0xFFFFF3CD),
  );

  @override
  ThemeExtension<ApparenceKitColors> copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? neutral100,
    Color? neutral200,
    Color? neutral300,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? appLogoContainer,
    Color? appLogo,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? favoriteHeart,
  }) {
    return ApparenceKitColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      neutral100: neutral100 ?? this.neutral100,
      neutral200: neutral200 ?? this.neutral200,
      neutral300: neutral300 ?? this.neutral300,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      shadow: shadow ?? this.shadow,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      appLogoContainer: appLogoContainer ?? this.appLogoContainer,
      appLogo: appLogo ?? this.appLogo,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      favoriteHeart: favoriteHeart ?? this.favoriteHeart,
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
      primaryContainer: Color.lerp(
        primaryContainer,
        other.primaryContainer,
        t,
      )!,
      onPrimaryContainer: Color.lerp(
        onPrimaryContainer,
        other.onPrimaryContainer,
        t,
      )!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer: Color.lerp(
        secondaryContainer,
        other.secondaryContainer,
        t,
      )!,
      onSecondaryContainer: Color.lerp(
        onSecondaryContainer,
        other.onSecondaryContainer,
        t,
      )!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      tertiaryContainer: Color.lerp(
        tertiaryContainer,
        other.tertiaryContainer,
        t,
      )!,
      onTertiaryContainer: Color.lerp(
        onTertiaryContainer,
        other.onTertiaryContainer,
        t,
      )!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      onSurfaceVariant: Color.lerp(
        onSurfaceVariant,
        other.onSurfaceVariant,
        t,
      )!,
      favoriteHeart: Color.lerp(error, other.favoriteHeart, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      onErrorContainer: Color.lerp(
        onErrorContainer,
        other.onErrorContainer,
        t,
      )!,
      neutral100: Color.lerp(neutral100, other.neutral100, t)!,
      neutral200: Color.lerp(neutral200, other.neutral200, t)!,
      neutral300: Color.lerp(neutral300, other.neutral300, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      inverseSurface: Color.lerp(inverseSurface, other.inverseSurface, t)!,
      onInverseSurface: Color.lerp(
        onInverseSurface,
        other.onInverseSurface,
        t,
      )!,
      inversePrimary: Color.lerp(inversePrimary, other.inversePrimary, t)!,
      appLogoContainer: Color.lerp(
        appLogoContainer,
        other.appLogoContainer,
        t,
      )!,
      appLogo: Color.lerp(appLogo, other.appLogo, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successContainer: Color.lerp(
        successContainer,
        other.successContainer,
        t,
      )!,
      onSuccessContainer: Color.lerp(
        onSuccessContainer,
        other.onSuccessContainer,
        t,
      )!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningContainer: Color.lerp(
        warningContainer,
        other.warningContainer,
        t,
      )!,
      onWarningContainer: Color.lerp(
        onWarningContainer,
        other.onWarningContainer,
        t,
      )!,
    );
  }
}
