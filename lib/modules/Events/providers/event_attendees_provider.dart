import 'package:apparence_kit/core/data/api/user_api.dart';
import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:apparence_kit/modules/events/api/event_participants_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_attendees_provider.g.dart';

@Riverpod(keepAlive: false)
Future<List<UserEntity>> eventAttendees(Ref ref, String eventId) async {
  final participantsApi = ref.read(eventParticipantsApiProvider);
  final userApi = ref.read(userApiProvider);
  final participants = await participantsApi.getForEvent(eventId: eventId);
  if (participants.isEmpty) {
    return [];
  }
  final List<String> userIds = participants.map((p) => p.userId).toList();
  final users = await userApi.getManyByIds(userIds);
  return users;
}
