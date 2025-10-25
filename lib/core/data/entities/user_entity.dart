// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
sealed class UserEntity with _$UserEntity {
  const factory UserEntity({
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(name: 'creation_date') DateTime? creationDate,
    @JsonKey(name: 'last_update_date') DateTime? lastUpdateDate,
    String? email,
    String? name,
    @JsonKey(name: 'avatar_url') String? avatarPath,
    bool? onboarded,
  }) = UserEntityData;

  const UserEntity._();

  factory UserEntity.fromJson(Map<String, Object?> json) =>
      _$UserEntityFromJson(json);
}

class Credentials {
  // this is the user id
  final String id;
  // this is useless with Supabase FIXME remove it
  final String token;

  Credentials({
    required this.id,
    required this.token,
  });

  factory Credentials.fromJson(Map<String, Object?> json) {
    if (!json.containsKey('id') || !json.containsKey('token')) {
      throw Exception('Invalid credentials');
    }
    return Credentials(
      id: json['id']! as String,
      token: json['token']! as String,
    );
  }
}
