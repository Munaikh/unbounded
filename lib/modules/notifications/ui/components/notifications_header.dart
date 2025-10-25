import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsHeader extends ConsumerWidget {
  final double? paddingHeight;

  const NotificationsHeader({
    super.key,
    this.paddingHeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, paddingHeight ?? 12, 24, 16),
      child: Row(
        children: [
          Text(
            "Notifications",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );
  }
}
