import 'package:apparence_kit/modules/Events/api/event_participants_api.dart';
import 'package:apparence_kit/modules/Events/entity/event_participant_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_participants_by_event_provider.g.dart';

@riverpod
Future<List<EventParticipantEntity>> eventParticipantsByEvent(
  Ref ref, {
  required String eventId,
}) async {
  final api = ref.watch(eventParticipantsApiProvider);
  return await api.getForEvent(eventId: eventId);
}
