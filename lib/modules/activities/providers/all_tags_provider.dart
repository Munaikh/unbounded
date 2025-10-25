import 'package:apparence_kit/modules/activities/api/tags_api.dart';
import 'package:apparence_kit/modules/activities/entity/tag_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_tags_provider.g.dart';

@riverpod
Future<List<TagEntity>> allTags(Ref ref) async {
  final api = ref.watch(tagsApiProvider);
  return await api.getTags();
}