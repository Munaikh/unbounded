// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
UserInfoEntity _$UserInfoEntityFromJson(
  Map<String, dynamic> json
) {
    return SubscriptionEntityData.fromJson(
      json
    );
}

/// @nodoc
mixin _$UserInfoEntity {

@JsonKey(includeIfNull: false) String? get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'info_key') String get key;@JsonKey(name: 'info_value') String get value;
/// Create a copy of UserInfoEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInfoEntityCopyWith<UserInfoEntity> get copyWith => _$UserInfoEntityCopyWithImpl<UserInfoEntity>(this as UserInfoEntity, _$identity);

  /// Serializes this UserInfoEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInfoEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,key,value);

@override
String toString() {
  return 'UserInfoEntity(id: $id, userId: $userId, key: $key, value: $value)';
}


}

/// @nodoc
abstract mixin class $UserInfoEntityCopyWith<$Res>  {
  factory $UserInfoEntityCopyWith(UserInfoEntity value, $Res Function(UserInfoEntity) _then) = _$UserInfoEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) String? id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'info_key') String key,@JsonKey(name: 'info_value') String value
});




}
/// @nodoc
class _$UserInfoEntityCopyWithImpl<$Res>
    implements $UserInfoEntityCopyWith<$Res> {
  _$UserInfoEntityCopyWithImpl(this._self, this._then);

  final UserInfoEntity _self;
  final $Res Function(UserInfoEntity) _then;

/// Create a copy of UserInfoEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = null,Object? key = null,Object? value = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInfoEntity].
extension UserInfoEntityPatterns on UserInfoEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( SubscriptionEntityData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case SubscriptionEntityData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( SubscriptionEntityData value)  $default,){
final _that = this;
switch (_that) {
case SubscriptionEntityData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( SubscriptionEntityData value)?  $default,){
final _that = this;
switch (_that) {
case SubscriptionEntityData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'info_key')  String key, @JsonKey(name: 'info_value')  String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case SubscriptionEntityData() when $default != null:
return $default(_that.id,_that.userId,_that.key,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'info_key')  String key, @JsonKey(name: 'info_value')  String value)  $default,) {final _that = this;
switch (_that) {
case SubscriptionEntityData():
return $default(_that.id,_that.userId,_that.key,_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  String? id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'info_key')  String key, @JsonKey(name: 'info_value')  String value)?  $default,) {final _that = this;
switch (_that) {
case SubscriptionEntityData() when $default != null:
return $default(_that.id,_that.userId,_that.key,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class SubscriptionEntityData implements UserInfoEntity {
  const SubscriptionEntityData({@JsonKey(includeIfNull: false) this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'info_key') required this.key, @JsonKey(name: 'info_value') required this.value});
  factory SubscriptionEntityData.fromJson(Map<String, dynamic> json) => _$SubscriptionEntityDataFromJson(json);

@override@JsonKey(includeIfNull: false) final  String? id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'info_key') final  String key;
@override@JsonKey(name: 'info_value') final  String value;

/// Create a copy of UserInfoEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionEntityDataCopyWith<SubscriptionEntityData> get copyWith => _$SubscriptionEntityDataCopyWithImpl<SubscriptionEntityData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionEntityDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionEntityData&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,key,value);

@override
String toString() {
  return 'UserInfoEntity(id: $id, userId: $userId, key: $key, value: $value)';
}


}

/// @nodoc
abstract mixin class $SubscriptionEntityDataCopyWith<$Res> implements $UserInfoEntityCopyWith<$Res> {
  factory $SubscriptionEntityDataCopyWith(SubscriptionEntityData value, $Res Function(SubscriptionEntityData) _then) = _$SubscriptionEntityDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) String? id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'info_key') String key,@JsonKey(name: 'info_value') String value
});




}
/// @nodoc
class _$SubscriptionEntityDataCopyWithImpl<$Res>
    implements $SubscriptionEntityDataCopyWith<$Res> {
  _$SubscriptionEntityDataCopyWithImpl(this._self, this._then);

  final SubscriptionEntityData _self;
  final $Res Function(SubscriptionEntityData) _then;

/// Create a copy of UserInfoEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = null,Object? key = null,Object? value = null,}) {
  return _then(SubscriptionEntityData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
