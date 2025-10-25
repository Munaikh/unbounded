import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/i18n/translations.g.dart';
import 'package:apparence_kit/modules/notifications/api/local_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef FutureCallback = Future<void> Function();

/// A Page to ask the user to accept or refuse a permission before showing the real permission dialog
/// - ex : ask for notification permission. If the user accept, we show the real permission dialog
/// On iOS you can't ask more than once for it
///
/// TIPS: use this on onboarding to ask for permissions
/// You can also use the same logic to ask for location permission, camera permission, etc.
class RequestNotificationPermission extends ConsumerWidget {
  final FutureCallback? onAccept;
  final FutureCallback? onRefuse;

  const RequestNotificationPermission({
    super.key,
    this.onAccept,
    this.onRefuse,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = Translations.of(context) //
        .request_notification_permission;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 21.0),
            child: Icon(
              Icons.notifications_outlined,
              size: 40,
              color: context.colors.primary,
            ),
          ),
          Text(
            translations.title,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            translations.description,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(notificationsSettingsProvider)
                  .askPermission()
                  .then((accepted) => switch (accepted) {
                        true => onAccept?.call(),
                        false => onRefuse?.call(),
                      });
            },
            child: Text(translations.continue_button),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              onRefuse?.call();
            },
            child: Text(translations.skip_button),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
