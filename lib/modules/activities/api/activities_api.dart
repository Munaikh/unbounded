import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/modules/activities/entity/activity_entity.dart';
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
      final response = await client.from(tableName).select('id');
      return response.map((e) => ActivityEntity.fromJson(e)).toList();
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: 'Error fetching activities: $e: $stacktrace',
      );
    }
  }
}
