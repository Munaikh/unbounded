import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/modules/events/entities/event_participant_entity.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'event_participants_api.g.dart';

@riverpod
EventParticipantsApi eventParticipantsApi(Ref ref) {
  return EventParticipantsApi();
}

class EventParticipantsApi {
  final SupabaseClient client = Supabase.instance.client;
  static const String tableName = 'event_participants';

  Future<List<EventParticipantEntity>> getForEvent({
    required String eventId,
  }) async {
    try {
      final List<dynamic> response = await client
          .from(tableName)
          .select('*')
          .eq('event_id', eventId);
      Logger().i('👥 Event participants: $response');
      return response
          .map<EventParticipantEntity>(
            (e) => EventParticipantEntity.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: 'Error fetching participants: $e: $stacktrace',
      );
    }
  }
}

