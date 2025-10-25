import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/theme/texts.dart';
import 'package:apparence_kit/core/theme/theme_data/theme_data.dart';
import 'package:universal_io/io.dart';

/// This is the the base theme for the app
/// It is used to generate the light and dark themes
sealed class ApparenceKitTheme {
  const ApparenceKitTheme();

  ApparenceKitColors get colors;

  ApparenceKitTextTheme get textTheme;

  ApparenceKitThemeData get data;
}

class ApparenceKitThemeUniform extends ApparenceKitTheme {
  const ApparenceKitThemeUniform(this.data);

  @override
  final ApparenceKitThemeData data;

  @override
  ApparenceKitColors get colors => data.colors;

  @override
  ApparenceKitTextTheme get textTheme => data.defaultTextTheme;
}

/// If you want to have different
/// themes for different platforms
class ApparenceKitThemeAdaptive extends ApparenceKitTheme {
  final ApparenceKitThemeData? ios;
  final ApparenceKitThemeData? android;
  final ApparenceKitThemeData? web;

  const ApparenceKitThemeAdaptive({
    this.ios,
    this.android,
    this.web,
  });

  @override
  ApparenceKitColors get colors {
    if (Platform.isIOS) {
      return ios!.colors;
    } else if (Platform.isAndroid) {
      return android!.colors;
    } else {
      return web!.colors;
    }
  }

  @override
  ApparenceKitTextTheme get textTheme {
    if (Platform.isIOS) {
      return ios!.defaultTextTheme;
    } else if (Platform.isAndroid) {
      return android!.defaultTextTheme;
    } else {
      return web!.defaultTextTheme;
    }
  }

  @override
  ApparenceKitThemeData get data {
    if (Platform.isIOS) {
      return ios!;
    } else if (Platform.isAndroid) {
      return android!;
    } else {
      return web!;
    }
  }
}
