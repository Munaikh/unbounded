import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart'
    as app;
import 'package:apparence_kit/modules/notifications/ui/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationTileComponent extends StatelessWidget {
  final app.Notification notification;
  final OnTapNotification? onTap;
  final int index;

  const NotificationTileComponent({
    super.key,
    required this.notification,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        FadeEffect(
          duration: Duration(milliseconds: 200),
        ),
        ScaleEffect(
          duration: Duration(milliseconds: 200),
          begin: Offset(1.2, 1.2),
        ),
        MoveEffect(
          duration: Duration(milliseconds: 150),
          begin: Offset(0, -50),
        ),
      ],
      delay: index < 6 ? Duration(milliseconds: 100 * index) : Duration.zero,
      onComplete: (controller) => controller.stop(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap?.call(notification),
          splashColor: context.colors.primary.withOpacity(.1),
          child: Ink(
            color: Colors.transparent,
            child: NotificationTile.from(
              key: ValueKey("notification_${notification.id}"),
              context,
              notification,
            ),
          ),
        ),
      ),
    );
  }
}
