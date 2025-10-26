import 'package:apparence_kit/core/data/api/user_api.dart';
import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_creator_provider.g.dart';

@riverpod
Future<UserEntity?> eventCreator(Ref ref, String userId) async {
  final userApi = ref.read(userApiProvider);
  return await userApi.get(userId);
}
