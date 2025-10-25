import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum RouterType {
  goRouter,
  normal,
}

class Guard extends StatelessWidget {
  final Future<bool> canActivate;
  final Widget child;
  final Widget? loading;
  final String fallbackRoute;
  final RouterType routerType;
  final VoidCallback? onRedirect;

  const Guard({
    super.key,
    required this.canActivate,
    required this.child,
    required this.fallbackRoute,
    this.loading,
    this.routerType = RouterType.goRouter,
    this.onRedirect,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: canActivate,
      builder: (_, result) {
        if (!result.hasData || result.hasError) {
          return Container();
        }
        final bool canActivate = result.data!;
        if (canActivate) {
          return child;
        }
        redirect(context);
        return loading ?? Container();
      },
    );
  }

  void redirect(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      switch (routerType) {
        case RouterType.goRouter:
          final currentRoute = GoRouter.of(context)
              .routerDelegate //
              .currentConfiguration
              .fullPath;
          debugPrint(
            "...current page is $currentRoute ==> redirecting to $fallbackRoute",
          );
          if (currentRoute == fallbackRoute) {
            debugPrint("Already on the fallback route, skipping redirect");
            return;
          }
          onRedirect?.call();
          context.pushReplacement(fallbackRoute);
        case RouterType.normal:
          Navigator.of(context).pushReplacementNamed(fallbackRoute);
      }
    });
  }
}
