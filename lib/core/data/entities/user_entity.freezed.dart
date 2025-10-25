// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
UserEntity _$UserEntityFromJson(
  Map<String, dynamic> json
) {
    return UserEntityData.fromJson(
      json
    );
}

/// @nodoc
mixin _$UserEntity {

@JsonKey(includeIfNull: false) String? get id;@JsonKey(name: 'creation_date') DateTime? get creationDate;@JsonKey(name: 'last_update_date') DateTime? get lastUpdateDate; String? get email; String? get name;@JsonKey(name: 'avatar_url') String? get avatarPath; bool? get onboarded;
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityCopyWith<UserEntity> get copyWith => _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);

  /// Serializes this UserEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate)&&(identical(other.lastUpdateDate, lastUpdateDate) || other.lastUpdateDate == lastUpdateDate)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarPath, avatarPath) || other.avatarPath == avatarPath)&&(identical(other.onboarded, onboarded) || other.onboarded == onboarded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,creationDate,lastUpdateDate,email,name,avatarPath,onboarded);

@override
String toString() {
  return 'UserEntity(id: $id, creationDate: $creationDate, lastUpdateDate: $lastUpdateDate, email: $email, name: $name, avatarPath: $avatarPath, onboarded: $onboarded)';
}


}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res>  {
  factory $UserEntityCopyWith(UserEntity value, $Res Function(UserEntity) _then) = _$UserEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) String? id,@JsonKey(name: 'creation_date') DateTime? creationDate,@JsonKey(name: 'last_update_date') DateTime? lastUpdateDate, String? email, String? name,@JsonKey(name: 'avatar_url') String? avatarPath, bool? onboarded
});




}
/// @nodoc
class _$UserEntityCopyWithImpl<$Res>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? creationDate = freezed,Object? lastUpdateDate = freezed,Object? email = freezed,Object? name = freezed,Object? avatarPath = freezed,Object? onboarded = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,creationDate: freezed == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdateDate: freezed == lastUpdateDate ? _self.lastUpdateDate : lastUpdateDate // ignore: cast_nullable_to_non_nullable
as DateTime?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,avatarPath: freezed == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String?,onboarded: freezed == onboarded ? _self.onboarded : onboarded // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserEntity].
extension UserEntityPatterns on UserEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( UserEntityData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserEntityData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( UserEntityData value)  $default,){
final _that = this;
switch (_that) {
case UserEntityData():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( UserEntityData value)?  $default,){
final _that = this;
switch (_that) {
case UserEntityData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? id, @JsonKey(name: 'creation_date')  DateTime? creationDate, @JsonKey(name: 'last_update_date')  DateTime? lastUpdateDate,  String? email,  String? name, @JsonKey(name: 'avatar_url')  String? avatarPath,  bool? onboarded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserEntityData() when $default != null:
return $default(_that.id,_that.creationDate,_that.lastUpdateDate,_that.email,_that.name,_that.avatarPath,_that.onboarded);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? id, @JsonKey(name: 'creation_date')  DateTime? creationDate, @JsonKey(name: 'last_update_date')  DateTime? lastUpdateDate,  String? email,  String? name, @JsonKey(name: 'avatar_url')  String? avatarPath,  bool? onboarded)  $default,) {final _that = this;
switch (_that) {
case UserEntityData():
return $default(_that.id,_that.creationDate,_that.lastUpdateDate,_that.email,_that.name,_that.avatarPath,_that.onboarded);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  String? id, @JsonKey(name: 'creation_date')  DateTime? creationDate, @JsonKey(name: 'last_update_date')  DateTime? lastUpdateDate,  String? email,  String? name, @JsonKey(name: 'avatar_url')  String? avatarPath,  bool? onboarded)?  $default,) {final _that = this;
switch (_that) {
case UserEntityData() when $default != null:
return $default(_that.id,_that.creationDate,_that.lastUpdateDate,_that.email,_that.name,_that.avatarPath,_that.onboarded);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class UserEntityData extends UserEntity {
  const UserEntityData({@JsonKey(includeIfNull: false) this.id, @JsonKey(name: 'creation_date') this.creationDate, @JsonKey(name: 'last_update_date') this.lastUpdateDate, this.email, this.name, @JsonKey(name: 'avatar_url') this.avatarPath, this.onboarded}): super._();
  factory UserEntityData.fromJson(Map<String, dynamic> json) => _$UserEntityDataFromJson(json);

@override@JsonKey(includeIfNull: false) final  String? id;
@override@JsonKey(name: 'creation_date') final  DateTime? creationDate;
@override@JsonKey(name: 'last_update_date') final  DateTime? lastUpdateDate;
@override final  String? email;
@override final  String? name;
@override@JsonKey(name: 'avatar_url') final  String? avatarPath;
@override final  bool? onboarded;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityDataCopyWith<UserEntityData> get copyWith => _$UserEntityDataCopyWithImpl<UserEntityData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserEntityDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntityData&&(identical(other.id, id) || other.id == id)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate)&&(identical(other.lastUpdateDate, lastUpdateDate) || other.lastUpdateDate == lastUpdateDate)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarPath, avatarPath) || other.avatarPath == avatarPath)&&(identical(other.onboarded, onboarded) || other.onboarded == onboarded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,creationDate,lastUpdateDate,email,name,avatarPath,onboarded);

@override
String toString() {
  return 'UserEntity(id: $id, creationDate: $creationDate, lastUpdateDate: $lastUpdateDate, email: $email, name: $name, avatarPath: $avatarPath, onboarded: $onboarded)';
}


}

/// @nodoc
abstract mixin class $UserEntityDataCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory $UserEntityDataCopyWith(UserEntityData value, $Res Function(UserEntityData) _then) = _$UserEntityDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) String? id,@JsonKey(name: 'creation_date') DateTime? creationDate,@JsonKey(name: 'last_update_date') DateTime? lastUpdateDate, String? email, String? name,@JsonKey(name: 'avatar_url') String? avatarPath, bool? onboarded
});




}
/// @nodoc
class _$UserEntityDataCopyWithImpl<$Res>
    implements $UserEntityDataCopyWith<$Res> {
  _$UserEntityDataCopyWithImpl(this._self, this._then);

  final UserEntityData _self;
  final $Res Function(UserEntityData) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? creationDate = freezed,Object? lastUpdateDate = freezed,Object? email = freezed,Object? name = freezed,Object? avatarPath = freezed,Object? onboarded = freezed,}) {
  return _then(UserEntityData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,creationDate: freezed == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdateDate: freezed == lastUpdateDate ? _self.lastUpdateDate : lastUpdateDate // ignore: cast_nullable_to_non_nullable
as DateTime?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,avatarPath: freezed == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String?,onboarded: freezed == onboarded ? _self.onboarded : onboarded // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
