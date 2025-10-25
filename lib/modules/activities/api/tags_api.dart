import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/modules/activities/entity/tag_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'tags_api.g.dart';

@riverpod
TagsApi tagsApi(Ref ref) {
  return TagsApi();
}

class TagsApi {
  final client = Supabase.instance.client;
  static const String tableName = 'tags';

  Future<List<TagEntity>> getTags() async {
    try {
      final response = await client.from(tableName).select();
      return response.map<TagEntity>((e) => TagEntity.fromJson(e)).toList();
    } catch (e, stacktrace) {
      throw ApiError(code: 0, message: 'Error fetching tags: $e: $stacktrace');
    }
  }
}
