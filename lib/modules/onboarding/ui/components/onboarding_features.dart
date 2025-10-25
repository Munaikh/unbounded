import 'package:apparence_kit/i18n/translations.g.dart';
import 'package:apparence_kit/modules/onboarding/ui/widgets/onboarding_feature.dart';
import 'package:flutter/material.dart';

class OnboardingFeatureOne extends StatelessWidget {
  final String nextRoute;

  const OnboardingFeatureOne({
    super.key,
    required this.nextRoute,
  });

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context).onboarding.feature_1;
    return OnboardingStep(
      title: translations.title,
      description: translations.description,
      btnText: translations.action,
      nextRoute: nextRoute,
      imgPath: 'assets/images/onboarding/purchase.png',
      withBg: true,
      progress: 0.1,
    );
  }
}

class OnboardingFeatureTwo extends StatelessWidget {
  final String nextRoute;

  const OnboardingFeatureTwo({
    super.key,
    required this.nextRoute,
  });

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context).onboarding.feature_2;
    return OnboardingStep(
      title: translations.title,
      description: translations.description,
      btnText: translations.action,
      nextRoute: nextRoute,
      imgPath: 'assets/images/onboarding/authentication-login-template.jpg',
      withBg: true,
      progress: 0.2,
    );
  }
}

class OnboardingFeatureThree extends StatelessWidget {
  final String nextRoute;

  const OnboardingFeatureThree({
    super.key,
    required this.nextRoute,
  });

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context).onboarding.feature_3;
    return OnboardingStep(
      title: translations.title,
      description: translations.description,
      btnText: translations.action,
      nextRoute: nextRoute,
      imgPath: 'assets/images/onboarding/notifications.png',
      withBg: true,
      progress: 0.3,
    );
  }
}
