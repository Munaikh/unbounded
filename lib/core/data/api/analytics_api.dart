import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/initializer/onstart_service.dart';
import 'package:apparence_kit/environnements.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

final analyticsApiProvider = Provider<AnalyticsApi>(
  (ref) => MixpanelAnalyticsApi.instance(),
  
);

abstract class AnalyticsApi implements OnStartService {
  /// Log an event to your analytics platform
  Future<void> logEvent(String name, Map<String, dynamic> params);

  /// Log a signout event to your analytics platform
  Future<void> logSignout();

  /// Identify a user to your analytics platform
  Future<void> identify(User user);
}


class MixpanelAnalyticsApi implements AnalyticsApi {
  final Environment environment;
  Mixpanel? mixpanel;
  MixpanelAnalyticsApi._({
    required this.environment,
  });

  static MixpanelAnalyticsApi? _instance;

  factory MixpanelAnalyticsApi.instance() {
    return _instance ??= MixpanelAnalyticsApi._(
      environment: Environment.fromEnv(),
    );
  }

  @override
  Future<void> init() async {
    if (environment.mixpanelToken == null ||
        environment.mixpanelToken!.isEmpty) {
      return;
    }
    try {
      mixpanel = await Mixpanel.init(
        environment.mixpanelToken!,
        trackAutomaticEvents: true,
      );
    } catch (e, s) {
      debugPrint('Error initializing Mixpanel: $e\n$s');
    }
  }

  @override
  Future<void> logEvent(String name, Map<String, dynamic> params) async {
    mixpanel?.track(name, properties: params);
  }

  @override
  Future<void> logSignout() async {
    mixpanel?.reset();
    mixpanel?.track('logout');
  }

  @override
  Future<void> identify(User user) async {
    mixpanel?.track('login');
    final userId = user.idOrNull;
    if (userId != null) {
      mixpanel?.identify(userId);
    }
  }
}




class AnalyticsObserver extends RouteObserver<ModalRoute<dynamic>> {
  final AnalyticsApi analyticsApi;
  final String? prefix;

  AnalyticsObserver({
    required this.analyticsApi,
    this.prefix,
  });

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // debugPrint('didPush $prefix${route.settings.name} ');
    if (route.settings.name != null && prefix != null) {
      analyticsApi.logEvent('$prefix${route.settings.name}', {});
    } else if (route.settings.name != null && prefix == null) {
      analyticsApi.logEvent('${route.settings.name}', {});
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    // debugPrint('didReplace ${newRoute?.settings.name}');
    if (newRoute?.settings.name != null && prefix != null) {
      analyticsApi.logEvent('$prefix${newRoute!.settings.name!}', {});
    } else if (newRoute?.settings.name != null && prefix == null) {
      analyticsApi.logEvent(newRoute!.settings.name!, {});
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {}

  @override
  void didStopUserGesture() {}
}

