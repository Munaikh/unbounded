import 'package:apparence_kit/core/guards/guard.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfosGuard extends ConsumerWidget {
  final Widget child;
  final String fallbackRoute;

  const UserInfosGuard({
    super.key,
    required this.child,
    required this.fallbackRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(userStateNotifierProvider);
    if (authState.user.isLoading) {
      return const Material(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return Guard(
      canActivate: Future.value(authState.user.isOnboarded),
      fallbackRoute: fallbackRoute,
      child: child,
    );
  }
}
