import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_entity.freezed.dart';
part 'tag_entity.g.dart';


@freezed
abstract class TagEntity with _$TagEntity {
 factory TagEntity({
    required int id,
    required DateTime createdAt,
    required String name,
  }) = _TagEntity;

 factory TagEntity.fromJson(Map<String, dynamic> json) => _$TagEntityFromJson(json);
}