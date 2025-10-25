import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/modules/events/entities/event_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'events_api.g.dart';

@riverpod
EventsApi eventsApi(Ref ref) {
  return EventsApi();
}

class EventsApi {
  final client = Supabase.instance.client;
  static const String tableName = 'events';
  Future<List<EventEntity>> getEvents() async {
    try {
      final response = await client
          .from(tableName)
          .select()
          .then((value) => value as List<dynamic>);
      return response
          .map<EventEntity>(
            (e) => EventEntity.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: 'Error fetching events: $e: $stacktrace',
      );
    }
  }

  Future<EventEntity> getEventDetails(String eventId) async {
    try {
      final response = await client
          .from(tableName)
          .select()
          .eq('id', eventId)
          .single();
      return EventEntity.fromJson(response);
    } catch (e, stacktrace) {
      throw ApiError(
        code: 0,
        message: 'Error fetching event details: $e: $stacktrace',
      );
    }
  }

  Future<EventEntity> createEvent({
    required String title,
    required String description,
    DateTime? date,
    String? location,
    String? bgUrl,
  }) async {
    try {
      final response = await client
          .from(tableName)
          .insert({
            'title': title,
            'description': description,
            'date': date?.toIso8601String(),
            'location': location,
            'bg_url': bgUrl,
          })
          .select()
          .single();
      return EventEntity.fromJson(response);
    } catch (e, stacktrace) {
      throw ApiError(code: 0, message: 'Error creating event: $e: $stacktrace');
    }
  }
}
