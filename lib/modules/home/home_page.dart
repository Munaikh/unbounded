import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/modules/notifications/api/local_notifier.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart'
    as apparence_kit; // this conflicts with material notification ()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// this homepage is for demo purpose only
/// You can delete it and start from scratch
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // you can fetch the user state like this
    // final userState = ref.watch(userStateNotifierProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Text(
              "Home page",
              style: context.textTheme.headlineLarge,
            ),
            Text(
              'Welcome on the ApparenceKit demo',
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                color: context.colors.onBackground,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 24),
            HomeCard(
              title: "Paywall",
              description: "Show the paywall page",
              onTap: () => context.push('/premium'),
              backgroundColor: context.colors.primary,
              textColor: context.colors.onPrimary,
            ),
            const SizedBox(height: 8),
            HomeCard(
              title: "Notification test",
              description:
                  "Push a local test notification (won't be added into your notifications list)",
              onTap: () {
                // this is only for showing you how to show notifcations locally manually
                // to create a push notification from server -> add a notification in the database.
                // It will be pushed to the user devices automatically
                // 🤩 the notifications pushed by the server are automatically shown you don't have to do anything
                final settings = ref.read(notificationsSettingsProvider);
                final localNotifier = ref.read(localNotifierProvider);
                final notif = apparence_kit.Notification.withData(
                  id: 'fake-id',
                  title: 'Notification test',
                  body:
                      "Push a local test notification (won't be added into your notifications list)",
                  createdAt: DateTime.now(),
                  notifier: localNotifier,
                  notifierSettings: settings,
                );
                notif.show();
              },
            ),
            const SizedBox(height: 8),
            
            const SizedBox(height: 8),
            HomeCard(
              title: "Signup",
              description:
                  "Anonymous user can signup using real email or other social login",
              onTap: () => context.push('/signup'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Here is just a simple content card
class HomeCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String description;
  final Color? textColor;
  final Color? backgroundColor;

  const HomeCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.description,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        HapticFeedback.mediumImpact();
        onTap.call();
      },
      child: Card(
        color: backgroundColor ?? context.colors.primary.withValues(alpha: .15),
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                title,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: textColor ?? context.colors.onSurface,
                ),
              ),
              Text(
                description,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: textColor ??
                      context.colors.onSurface.withValues(
                        alpha: .6,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
