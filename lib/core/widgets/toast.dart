import 'package:another_flushbar/flushbar.dart';
import 'package:apparence_kit/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_io/io.dart';

final toastProvider = Provider<ToastBuilder>((ref) => ToastBuilder());

class ToastBuilder {
  void success({
    required String title,
    required String text,
    Duration duration = const Duration(seconds: 3),
  }) {
    showSuccessToast(
      context: navigatorKey.currentContext!,
      title: title,
      text: text,
      duration: duration,
    );
  }

  void error({
    required String title,
    required String text,
    Duration duration = const Duration(seconds: 3),
    String? reason,
  }) {
    showErrorToast(
      context: navigatorKey.currentContext!,
      title: title,
      text: text,
      duration: duration,
      reason: reason,
    );
  }

  void alert({
    required String title,
    required String text,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return;
    }
    if (navigatorKey.currentContext == null ||
        !navigatorKey.currentContext!.mounted) {
      return;
    }
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: title,
      message: text,
      titleSize: 21,
      messageSize: 16,
      duration: duration,
      leftBarIndicatorColor: Colors.orange,
    ).show(navigatorKey.currentContext!);
  }
}

void showSuccessToast({
  required BuildContext context,
  required String title,
  required String text,
  Duration duration = const Duration(seconds: 3),
}) {
  // This is a hack to prevent the toast from showing during tests
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return;
  }
  if (!context.mounted) {
    return;
  }
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    title: title,
    message: text,
    titleSize: 24,
    messageSize: 14,
    duration: duration,
    barBlur: 8,
    backgroundColor: Colors.black45,
    titleColor: Colors.white,
    messageColor: Colors.white,
    // leftBarIndicatorColor: Colors.greenAccent,
    borderRadius: BorderRadius.circular(16),
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    icon: const Icon(
      Icons.check,
      color: Colors.white,
      size: 32,
    ),
    shouldIconPulse: false,
  ).show(context);
}

void showErrorToast({
  required BuildContext context,
  required String title,
  required String text,
  Duration duration = const Duration(seconds: 3),
  String? reason,
}) {
  // This is a hack to prevent the toast from showing during tests
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return;
  }
  if (!context.mounted) {
    return;
  }
  Flushbar(
    // flushbarPosition: FlushbarPosition.TOP,
    // title: title,
    // message: text,
    // titleSize: 21,
    // messageSize: 16,
    // duration: duration,
    // backgroundColor: Colors.redAccent,
    // icon: const Icon(
    //   Icons.error,
    //   color: Colors.white,
    // ),
    flushbarPosition: FlushbarPosition.TOP,
    title: title,
    message: text,
    titleSize: 24,
    messageSize: 14,
    duration: duration,
    barBlur: 8,
    backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
    titleColor: Colors.white,
    messageColor: Colors.white,
    // leftBarIndicatorColor: Colors.greenAccent,
    borderRadius: BorderRadius.circular(16),
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    icon: const Icon(
      Icons.error,
      color: Colors.white,
    ),
    shouldIconPulse: false,
  ).show(context);
}
