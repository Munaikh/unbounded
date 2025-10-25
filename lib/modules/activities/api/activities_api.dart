import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/modules/activities/entity/activity_entity.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'activities_api.g.dart';

@riverpod
ActivitiesApi activitiesApi(Ref ref) {
  return ActivitiesApi();
}

class ActivitiesApi {
  final client = Supabase.instance.client;
  static const String tableName = 'activities';

  Future<List<ActivityEntity>> getActivities() async {
    try {
      // Fetch activities with their tags using a LEFT JOIN through activity_tags
      // This ensures we get all activities, even those without tags
      final response = await client
          .from(tableName)
          .select('''
            *,
            activity_tags(
              tags(*)
            )
          ''')
          .then((value) => value as List<dynamic>);

      Logger().i('🚨 Activities response: $response');

      // Transform the response to include tags
      return response.map<ActivityEntity>((activityData) {
        final Map<String, dynamic> activity = Map<String, dynamic>.from(
          activityData as Map<String, dynamic>,
        );

        // Extract tags from the nested structure
        final List<Map<String, dynamic>> tagsList = [];
        if (activity['activity_tags'] != null) {
          final activityTagsList = activity['activity_tags'] as List<dynamic>;
          for (final activityTag in activityTagsList) {
            if (activityTag != null && activityTag['tags'] != null) {
              tagsList.add(activityTag['tags'] as Map<String, dynamic>);
            }
          }
        }

        // Remove the nested activity_tags structure and add tags as a flat list
        activity.remove('activity_tags');
        activity['tags'] = tagsList;

        Logger().i('🚨 Transformed activity: $activity');
        return ActivityEntity.fromJson(activity);
      }).toList();
    } catch (e, stacktrace) {
      Logger().e('🚨 Error fetching activities: $e');
      Logger().e('🚨 Stacktrace: $stacktrace');
      throw ApiError(code: 0, message: 'Error fetching activities: $e: $stacktrace');
    }
  }
}
