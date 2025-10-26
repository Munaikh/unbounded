import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/modules/events/api/event_participants_api.dart';
import 'package:apparence_kit/modules/events/api/events_api.dart';
import 'package:apparence_kit/modules/events/entities/event_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_joined_events_provider.g.dart';

@riverpod
Future<List<EventEntity>> userJoinedEvents(Ref ref) async {
  final userState = ref.watch(userStateNotifierProvider);
  final userId = userState.user.idOrThrow;

  final participantsApi = ref.watch(eventParticipantsApiProvider);
  final eventsApi = ref.watch(eventsApiProvider);

  // Get all event participations for this user
  final participations = await participantsApi.getForUser(userId: userId);

  // Get the full event details for each participation
  final events = <EventEntity>[];
  for (final participation in participations) {
    try {
      final event = await eventsApi.getEventDetails(participation.eventId);
      events.add(event);
    } catch (e) {
      // Skip events that can't be loaded
      continue;
    }
  }

  return events;
}
