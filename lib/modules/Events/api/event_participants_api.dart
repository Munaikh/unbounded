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

  Future<List<EventParticipantEntity>> getForUser({
    required String userId,
  }) async {
    try {
      final List<dynamic> response = await client
          .from(tableName)
          .select('*')
          .eq('user_id', userId);
      Logger().i('👥 User event participations: $response');
      return response
          .map<EventParticipantEntity>(
            (e) => EventParticipantEntity.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: 'Error fetching user participations: $e: $stacktrace',
      );
    }
  }

  Future<bool> isUserJoined({
    required String eventId,
    required String userId,
  }) async {
    try {
      final List<dynamic> response = await client
          .from(tableName)
          .select('id')
          .eq('event_id', eventId)
          .eq('user_id', userId)
          .limit(1);
      return response.isNotEmpty;
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: 'Error checking participation: $e: $stacktrace',
      );
    }
  }

  Future<void> joinEvent({
    required String eventId,
    required String userId,
  }) async {
    try {
      await client.from(tableName).upsert({
        'event_id': eventId,
        'user_id': userId,
      }, onConflict: 'event_id,user_id');
    } catch (e, stacktrace) {
      throw ApiError(code: 0, message: 'Error joining event: $e: $stacktrace');
    }
  }

  Future<void> leaveEvent({
    required String eventId,
    required String userId,
  }) async {
    try {
      await client
          .from(tableName)
          .delete()
          .eq('event_id', eventId)
          .eq('user_id', userId);
    } catch (e, stacktrace) {
      throw ApiError(code: 0, message: 'Error leaving event: $e: $stacktrace');
    }
  }
}

