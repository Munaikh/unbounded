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
      final response = await client.from(tableName).select('*').then((value) => value as List<dynamic>,);
      Logger().i('🚨 Activities: ${response}');
      return response.map<ActivityEntity>((e) => ActivityEntity.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: 'Error fetching activities: $e: $stacktrace',
      );
    }
  }
}
