

import 'package:apparence_kit/modules/activities/api/activities_api.dart';
import 'package:apparence_kit/modules/activities/entity/activity_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
Future<List<ActivityEntity>> getAllActivities(Ref ref) async {
  final api = ref.watch(activitiesApiProvider);
  return await api.getActivities();
}