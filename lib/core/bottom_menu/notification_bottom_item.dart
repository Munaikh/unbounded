import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/modules/notifications/repositories/notifications_repository.dart';
import 'package:bart/bart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationBottomItem extends ConsumerWidget {
  final bool isActive;

  const NotificationBottomItem({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    final authState = ref.watch(userStateNotifierProvider);
    final userId = authState.user.idOrNull;

    if (userId == null) {
      return const SizedBox();
    }
    final count$ = notificationRepository //
        .listenToUnreadNotificationsCount(userId);

    return BottomBarIcon.builder(
      icon: Icon(
        Icons.notifications,
        size: 28,
        color: isActive ? context.colors.primary : Colors.grey,
      ),
      notificationBuilder: (context) => StreamBuilder<int>(
        key: const ValueKey("notification-count"),
        stream: count$,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != 0) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: Text(
                snapshot.data.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class BottomItemNotification extends ConsumerStatefulWidget {
  const BottomItemNotification({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomItemNotificationState();
}

class _BottomItemNotificationState
    extends ConsumerState<BottomItemNotification> {
  Stream<int>? count$;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (count$ == null) {
      final notificationRepository = ref.watch(notificationRepositoryProvider);
      final authState = ref.watch(userStateNotifierProvider);
      count$ = notificationRepository
          .listenToUnreadNotificationsCount(authState.user.idOrThrow);
    }
    return BottomBarIcon.builder(
      icon: const Icon(Icons.notifications),
      notificationBuilder: (context) => StreamBuilder<int>(
        key: const ValueKey("notification-count"),
        stream: count$,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != 0) {
            debugPrint("rebuild notification count");
            return Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: Text(
                snapshot.data.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
