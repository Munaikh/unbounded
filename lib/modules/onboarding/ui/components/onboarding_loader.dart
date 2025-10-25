import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/i18n/translations.g.dart';
import 'package:apparence_kit/modules/onboarding/providers/onboarding_provider.dart';
import 'package:apparence_kit/modules/onboarding/ui/widgets/onboarding_background.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingLoader extends ConsumerStatefulWidget {
  final VoidCallback onCompleted;

  const OnboardingLoader({
    super.key,
    required this.onCompleted,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingJournalLoaderState();
}

class _OnboardingJournalLoaderState extends ConsumerState<OnboardingLoader> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3500), () async {
      await ref.onboardingNotifier.onOnboardingCompleted();
      widget.onCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context).onboarding.loading;
    return OnboardingBackground(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                child: Text(
                  translations.title,
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineMedium?.copyWith(
                    color: context.colors.onBackground,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 16, 40, 0),
                child: Text(
                  translations.subtitle,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onBackground.withValues(alpha: .6),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 32, 100, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: LinearProgressIndicator(
                  minHeight: 12,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    context.colors.primary,
                  ),
                  backgroundColor: context.colors.primary.withValues(alpha: 0.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
