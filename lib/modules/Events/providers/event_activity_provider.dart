import 'package:apparence_kit/modules/activities/api/activities_api.dart';
import 'package:apparence_kit/modules/activities/entity/activity_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_activity_provider.g.dart';

@riverpod
Future<ActivityEntity?> eventActivity(Ref ref, int activityId) async {
  final activitiesApi = ref.read(activitiesApiProvider);
  final activities = await activitiesApi.getActivities();

  for (final activity in activities) {
    if (activity.id == activityId) {
      return activity;
    }
  }

  return null;
}
