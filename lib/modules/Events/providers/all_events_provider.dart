import 'package:apparence_kit/modules/Events/api/events_api.dart';
import 'package:apparence_kit/modules/Events/entities/event_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_events_provider.g.dart';

@riverpod
Future<List<EventEntity>> allEvents(Ref ref) async {
  final api = ref.watch(eventsApiProvider);
  return await api.getEvents();
}

