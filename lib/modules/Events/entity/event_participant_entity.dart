import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_participant_entity.freezed.dart';
part 'event_participant_entity.g.dart';

@freezed
abstract class EventParticipantEntity with _$EventParticipantEntity {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory EventParticipantEntity({
    required String id,
    required DateTime createdAt,
    required String eventId,
    required String userId,
  }) = _EventParticipantEntity;

  factory EventParticipantEntity.fromJson(Map<String, dynamic> json) => _$EventParticipantEntityFromJson(json);
}


