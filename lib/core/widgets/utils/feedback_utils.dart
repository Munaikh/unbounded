import 'package:flutter/services.dart';

class FeedbackUtils {
  FeedbackUtils._();

  static Future<void> successBasic() async {
    await HapticFeedback.mediumImpact();
  }

  static Future<void> successEnhanced() async {
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.mediumImpact();
  }

  static Future<void> successPremium() async {
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 80));
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 80));
    await HapticFeedback.heavyImpact();
  }

  static Future<void> successCelebration() async {
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 60));
    await HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 60));
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }

  static Future<void> confirmationQuick() async {
    await HapticFeedback.lightImpact();
  }
  static Future<void> error() async {
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }

  static Future<void> selection() async {
    await HapticFeedback.selectionClick();
  }
}
