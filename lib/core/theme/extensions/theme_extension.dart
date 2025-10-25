import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/theme/providers/theme_provider.dart';
import 'package:apparence_kit/core/theme/theme_data/theme_data.dart';
import 'package:flutter/material.dart';

/// This is a convenience extension to access the theme
/// from the BuildContext
/// Instead of calling Theme.of(context) everywhere
/// You can just call context.theme or context.colors...
extension ApparenceKitThemeExt on BuildContext {
  ApparenceKitColors get colors =>
      Theme.of(this).extension<ApparenceKitColors>()!;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  Brightness get brightness => Theme.of(this).brightness;

  ApparenceKitThemeData get kitTheme => ThemeProvider.of(this).current.data;
}
