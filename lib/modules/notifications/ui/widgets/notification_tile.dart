import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/modules/notifications/providers/models/notification.dart'
    as app;
import 'package:better_skeleton/better_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

typedef OnTapNotification = void Function(app.Notification notification);

/// A tile for the [NotificationsPage] widget.
class NotificationTile extends StatefulWidget {
  final double bgOpacity;
  final double titleOpacity;
  final Color titleColor;
  final Color descriptionColor;
  final Color dateColor;
  final Widget icon;
  final DateTime date;
  final String title;
  final String description;
  final OnTapNotification? onTap;

  const NotificationTile({
    super.key,
    required this.bgOpacity,
    required this.titleOpacity,
    required this.icon,
    required this.date,
    required this.title,
    required this.description,
    required this.titleColor,
    required this.descriptionColor,
    required this.dateColor,
    this.onTap,
  });

  factory NotificationTile.active({
    required DateTime date,
    required String title,
    required String description,
    required BuildContext context,
    OnTapNotification? onTap,
    Key? key,
  }) =>
      NotificationTile(
        key: key,
        bgOpacity: .8,
        titleOpacity: 1,
        icon: const TileNotificationIcon(active: true),
        date: date,
        title: title,
        description: description,
        titleColor: context.colors.onPrimary,
        descriptionColor: context.colors.onPrimary,
        dateColor: context.colors.grey1,
        onTap: onTap,
      );

  factory NotificationTile.old({
    required DateTime date,
    required String title,
    required String description,
    required BuildContext context,
    OnTapNotification? onTap,
    Key? key,
  }) =>
      NotificationTile(
        key: key,
        bgOpacity: .1,
        titleOpacity: .6,
        icon: const TileNotificationIcon(active: false),
        date: date,
        title: title,
        description: description,
        titleColor: context.colors.onSurface,
        descriptionColor: context.colors.onSurface,
        dateColor: context.colors.grey3,
        onTap: onTap,
      );

  factory NotificationTile.from(
    BuildContext context,
    app.Notification notification, {
    Key? key,
    OnTapNotification? onTap,
  }) =>
      notification.seen
          ? NotificationTile.old(
              key: key,
              date: notification.createdAt,
              title: notification.title,
              description: notification.body,
              context: context,
              onTap: onTap,
            )
          : NotificationTile.active(
              key: key,
              date: notification.createdAt,
              title: notification.title,
              description: notification.body,
              context: context,
              onTap: onTap,
            );

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _opacityAnimation = Tween(
      begin: 0.0,
      end: widget.bgOpacity,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant NotificationTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bgOpacity != widget.bgOpacity) {
      _opacityAnimation = Tween(
        begin: oldWidget.bgOpacity,
        end: widget.bgOpacity,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.ease),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color:
                  context.colors.primary.withValues(alpha:_opacityAnimation.value),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        );
      },
      child: Row(
        children: [
          widget.icon,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 0,
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: widget.titleColor,
                        ),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  flex: 0,
                  child: Text(
                    widget.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: widget.descriptionColor),
                    overflow: TextOverflow.ellipsis,
                    // softWrap: true,
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 12),
                Flexible(
                  flex: 0,
                  child: Text(
                    Jiffy.parseFromDateTime(widget.date).fromNow(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: widget.dateColor,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A small circle icon for the [NotificationTile] widget.
class TileNotificationIcon extends StatelessWidget {
  final bool active;

  const TileNotificationIcon({
    super.key,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Theme.of(context).primaryColor : Colors.black87,
      ),
      child: Icon(
        active ? Icons.notifications_active : Icons.notifications,
        size: 16,
        color: Colors.white,
      ),
    );
  }
}

/// A skeleton for the [NotificationTile] widget.
class NotificationSkeletonTile extends StatefulWidget {
  const NotificationSkeletonTile({super.key});

  @override
  State<NotificationSkeletonTile> createState() =>
      _NotificationSkeletonTileState();
}

class _NotificationSkeletonTileState extends State<NotificationSkeletonTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();
  }

  @override
  void deactivate() {
    animationController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: AnimatedSkeleton(
        listenable: animationController,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
