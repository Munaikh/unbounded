import 'package:apparence_kit/modules/activities/api/tags_api.dart';
import 'package:apparence_kit/modules/activities/entity/tag_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
Future<List<TagEntity>> allTagsProvider(Ref ref) async {
  final api = ref.read(tagsApiProvider);
  return await api.getTags();
}