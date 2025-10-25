import 'package:apparence_kit/core/data/api/analytics_api.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/i18n/translations.g.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart';
import 'package:apparence_kit/modules/notifications/repositories/notifications_repository.dart';
import 'package:apparence_kit/modules/onboarding/providers/onboarding_provider.dart';
import 'package:apparence_kit/modules/onboarding/ui/widgets/onboarding_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _formStep3Key = GlobalKey<FormState>();

class NotificationsPermissionStep extends ConsumerWidget {
  final String nextRoute;

  const NotificationsPermissionStep({
    super.key,
    required this.nextRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifRepository = ref.watch(notificationRepositoryProvider);
    final permissionFuture = notifRepository.getPermissionStatus();
    final state = ref.onboardingState$;
    final translations = Translations.of(context).onboarding.notifications;

    return SafeArea(
      child: FutureBuilder<NotificationPermission>(
        future: permissionFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          final permission = snapshot.data!;
          return Form(
            key: _formStep3Key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const OnboardingProgress(value: 0.9),
                const SizedBox(height: 16),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Center(
                      child: Image.asset(
                        'assets/images/onboarding/img2.jpg',
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    translations.title,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    translations.description,
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      permission
                          .maybeAsk()
                          .then(
                            (_) => ref.onboardingNotifier //
                                .setupNotifications(),
                          )
                          .then(
                            (_) => Navigator.of(context) //
                                .pushNamed(nextRoute),
                          );
                    },
                    child: Text(translations.continue_button),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: TextButton(
                    onPressed: () {
                      // save analytics event
                      ref
                          .read(analyticsApiProvider)
                          .logEvent('setup_notifications_refused', {});
                      Navigator.of(context).pushNamed(nextRoute);
                    },
                    child: Text(
                      translations.skip_button,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.kitTheme.colors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
