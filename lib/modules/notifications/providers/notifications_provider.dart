import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification_list.dart';
import 'package:apparence_kit/modules/notifications/repositories/notifications_repository.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_provider.g.dart';

const itemPerPage = 10;

@Riverpod(keepAlive: true)
class NotificationsNotifier extends _$NotificationsNotifier {
  var _locked = false;

  @override
  FutureOr<NotificationsList> build() async {
    final notificationRepository = ref.read(notificationRepositoryProvider);
    final userState = ref.watch(userStateNotifierProvider);
    await Future.delayed(const Duration(milliseconds: 500));
    final res = await notificationRepository.get(
      userState.user.idOrThrow,
      pageSize: itemPerPage,
    );
    return NotificationsList.from(res, itemPerPage);
  }

  Future<void> readAll() async {
    if (!state.hasValue) {
      return;
    }
    try {
      final notificationRepository = ref.read(notificationRepositoryProvider);
      final userState = ref.watch(userStateNotifierProvider);
      final List<Notification> updatedNotifications = [];
      for (final notification in state.value!.data) {
        if (notification.seen) {
          continue;
        }
        updatedNotifications.add(
          await notificationRepository.read(
            userState.user.idOrThrow,
            notification,
          ),
        );
        await Future.delayed(const Duration(milliseconds: 100));
      }
      final List<Notification> oldNotifications = state
          .value! //
          .data
          .where((element) => element.seen)
          .toList();
      state = AsyncValue.data(
        state.value!.copyWith(
          data: [...updatedNotifications, ...oldNotifications],
        ),
      );
    } catch (e) {
      Logger().e("error $e");
    }
  }

  Future<void> refresh() async {
    if (_locked) {
      return;
    }
    _locked = true;
    state = const AsyncValue.loading();
    final notificationRepository = ref.read(notificationRepositoryProvider);
    final userState = ref.watch(userStateNotifierProvider);
    await Future.delayed(const Duration(milliseconds: 1500));
    final res = await notificationRepository.get(
      userState.user.idOrThrow,
      pageSize: itemPerPage,
    );
    state = AsyncValue.data(NotificationsList.from(res, itemPerPage));
    _locked = false;
  }

  Future<void> fetchNextPage() async {
    if (_locked) {
      return;
    }
    if (state.value == null || state.value!.hasMore == false) {
      return;
    }
    _locked = true;
    final notificationRepository = ref.read(notificationRepositoryProvider);
    final userState = ref.watch(userStateNotifierProvider);
    await Future.delayed(const Duration(milliseconds: 500));

    final nextPage = await notificationRepository.get(
      userState.user.idOrThrow,
      pageSize: itemPerPage,
      startDate: state.value!.data.last.createdAt,
    );
    state = AsyncValue.data(
      state.value!.copyWith(
        data: [...state.value!.data, ...nextPage],
        hasMore: nextPage.length == itemPerPage,
      ),
    );
    _locked = false;
  }

  /// Handle notification tap
  void onTapNotification(Notification notification) {
    notification.onTap();
  }
}
