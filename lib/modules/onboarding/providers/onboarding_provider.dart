import 'package:apparence_kit/core/data/api/analytics_api.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/modules/onboarding/models/user_info.dart';
import 'package:apparence_kit/modules/onboarding/providers/onboarding_model.dart';
import 'package:apparence_kit/modules/onboarding/repositories/user_infos_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_provider.g.dart';

extension OnboardingNotifierExt on WidgetRef {
  OnboardingNotifier get onboardingNotifier =>
      read(onboardingProvider.notifier);

  OnboardingState? get onboardingState$ => watch(onboardingProvider);

  OnboardingNotifier get onboardingState =>
      read(onboardingProvider.notifier);
}

@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  OnboardingState build() {
    return OnboardingState();
  }

  Future<void> onAnsweredQuestion(UserInfoDetail value) async {
    final userInfoRepository = ref.read(userInfosRepositoryProvider);
    final userState = ref.read(userStateNotifierProvider);

    await userInfoRepository.save(
      userState.user.idOrThrow,
      value,
    );
  }

  Future<void> setupNotifications() async {
    final userStateNotifier = ref.read(userStateNotifierProvider.notifier);
    // save analytics event
    await ref
        .read(analyticsApiProvider)
        .logEvent('setup_notifications_accepted', {});

    // Uncomment and create translations to schedule daily notification after user accept permissions
    // --
    // final translations = ref.read(translationsProvider);
    // await ref.read(localNotifierProvider).scheduleDailyAt(
    //       title: translations.dailyNotification.title,
    //       body: translations.dailyNotification.body,
    //       date: state.reminder!,
    //     );

    await userStateNotifier.refresh();
  }

  Future<void> onOnboardingCompleted() async {
    final userStateNotifier = ref.read(userStateNotifierProvider.notifier);

    await userStateNotifier.onOnboarded();
    await userStateNotifier.refresh();
  }
}
