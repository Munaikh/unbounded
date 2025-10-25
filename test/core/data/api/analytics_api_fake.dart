import 'package:apparence_kit/core/data/api/analytics_api.dart';
import 'package:apparence_kit/core/data/models/user.dart';

class AnalyticsApiFake implements AnalyticsApi {
  String? currentUserId;

  @override
  Future<void> identify(User user) {
    currentUserId = user.idOrNull;
    return Future.value();
  }

  @override
  Future<void> init() async {}

  @override
  Future<void> logEvent(String name, Map<String, dynamic> params) {
    return Future.value();
  }

  @override
  Future<void> logSignout() {
    return Future.value();
  }
}
