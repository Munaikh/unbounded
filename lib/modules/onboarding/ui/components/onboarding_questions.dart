import 'package:apparence_kit/i18n/translations.g.dart';
import 'package:apparence_kit/modules/onboarding/models/user_info.dart';
import 'package:apparence_kit/modules/onboarding/providers/onboarding_provider.dart';
import 'package:apparence_kit/modules/onboarding/ui/widgets/onboarding_radio_question.dart';
import 'package:apparence_kit/modules/onboarding/ui/widgets/selectable_row_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//--------------------------------------------
/// Question about the user's gender
//--------------------------------------------
class UserSexeOnboardingQuestion extends ConsumerWidget {
  final String nextRoute;

  const UserSexeOnboardingQuestion({
    super.key,
    required this.nextRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = Translations.of(context).onboarding.genderQuestion;
    return OnboardingRadioQuestion(
      title: translations.title,
      description: translations.description,
      btnText: translations.action,
      progress: 0.3,
      optionIds: translations.options.keys.toList(),
      optionBuilder: (key, selected) => SelectableRowTile(
        title: translations.options[key],
        selected: selected,
      ),
      // here we can add a reassurance message when the user selects an option
      // reassuranceBuilder: (key) => CheckedReassurance(
      //   text: translations.reassurance[key]!,
      // ),
      onValidate: (key) {
        // print("Selected option: $key");
        if (key != null) {
          ref
              .read(onboardingProvider.notifier)
              .onAnsweredQuestion(UserSexeInfo.fromString(key));
        }
        Navigator.of(context).pushReplacementNamed(nextRoute);
      },
    );
  }
}

//--------------------------------------------
/// Question about the user's gender
//--------------------------------------------
class UserAgeOnboardingQuestion extends ConsumerWidget {
  final String nextRoute;

  const UserAgeOnboardingQuestion({
    super.key,
    required this.nextRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = Translations.of(context).onboarding.ageQuestion;
    return OnboardingRadioQuestion(
      title: translations.title,
      description: translations.description,
      btnText: translations.action,
      progress: 0.3,
      optionIds: translations.options.keys.toList(),
      optionBuilder: (key, selected) => SelectableRowTile(
        title: translations.options[key],
        selected: selected,
      ),
      // here we can add a reassurance message when the user selects an option
      // reassuranceBuilder: (key) => CheckedReassurance(
      //   text: translations.reassurance[key]!,
      // ),
      onValidate: (key) {
        // print("Selected option: $key");
        if (key != null) {
          ref
              .read(onboardingProvider.notifier)
              .onAnsweredQuestion(UserAgeInfo.fromString(key));
        }
        Navigator.of(context).pushReplacementNamed(nextRoute);
      },
    );
  }
}
