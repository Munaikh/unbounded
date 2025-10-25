import 'package:apparence_kit/modules/activities/entity/activity_entity.dart';
import 'package:apparence_kit/modules/activities/providers/all_activities_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtered_activities_provider.g.dart';

@riverpod
Future<List<ActivityEntity>> filteredActivities(Ref ref) async {
  final allActivities = await ref.watch(allActivitiesProvider.future);

  // For now, just return all activities since we're not saving preferences
  return allActivities;
}
