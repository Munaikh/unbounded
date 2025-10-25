import 'package:apparence_kit/modules/notifications/providers/models/notification.dart';

class NotificationsList {
  final List<Notification> data;
  final bool hasMore;

  NotificationsList({
    required this.data,
    required this.hasMore,
  });

  factory NotificationsList.empty() {
    return NotificationsList(
      data: [],
      hasMore: false,
    );
  }

  factory NotificationsList.from(
    List<Notification> data,
    int itemPerPage,
  ) {
    return NotificationsList(
      data: data,
      hasMore: data.length == itemPerPage,
    );
  }

  NotificationsList copyWith({
    List<Notification>? data,
    bool? hasMore,
  }) {
    return NotificationsList(
      data: data ?? this.data,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
