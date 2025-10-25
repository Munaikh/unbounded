// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
DeviceEntity _$DeviceEntityFromJson(
  Map<String, dynamic> json
) {
    return DeviceEntityData.fromJson(
      json
    );
}

/// @nodoc
mixin _$DeviceEntity {

@JsonKey(includeIfNull: false) String? get id;@JsonKey(name: "user_id") String? get userId;@JsonKey(name: 'creation_date') DateTime get creationDate;@JsonKey(name: 'last_update_date') DateTime get lastUpdateDate;@JsonKey(name: 'installation_id') String get installationId;@JsonKey(name: 'token') String get token;@JsonKey(name: 'operatingSystem') OperatingSystem get operatingSystem;
/// Create a copy of DeviceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceEntityCopyWith<DeviceEntity> get copyWith => _$DeviceEntityCopyWithImpl<DeviceEntity>(this as DeviceEntity, _$identity);

  /// Serializes this DeviceEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate)&&(identical(other.lastUpdateDate, lastUpdateDate) || other.lastUpdateDate == lastUpdateDate)&&(identical(other.installationId, installationId) || other.installationId == installationId)&&(identical(other.token, token) || other.token == token)&&(identical(other.operatingSystem, operatingSystem) || other.operatingSystem == operatingSystem));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,creationDate,lastUpdateDate,installationId,token,operatingSystem);

@override
String toString() {
  return 'DeviceEntity(id: $id, userId: $userId, creationDate: $creationDate, lastUpdateDate: $lastUpdateDate, installationId: $installationId, token: $token, operatingSystem: $operatingSystem)';
}


}

/// @nodoc
abstract mixin class $DeviceEntityCopyWith<$Res>  {
  factory $DeviceEntityCopyWith(DeviceEntity value, $Res Function(DeviceEntity) _then) = _$DeviceEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) String? id,@JsonKey(name: "user_id") String? userId,@JsonKey(name: 'creation_date') DateTime creationDate,@JsonKey(name: 'last_update_date') DateTime lastUpdateDate,@JsonKey(name: 'installation_id') String installationId,@JsonKey(name: 'token') String token,@JsonKey(name: 'operatingSystem') OperatingSystem operatingSystem
});




}
/// @nodoc
class _$DeviceEntityCopyWithImpl<$Res>
    implements $DeviceEntityCopyWith<$Res> {
  _$DeviceEntityCopyWithImpl(this._self, this._then);

  final DeviceEntity _self;
  final $Res Function(DeviceEntity) _then;

/// Create a copy of DeviceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = freezed,Object? creationDate = null,Object? lastUpdateDate = null,Object? installationId = null,Object? token = null,Object? operatingSystem = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,creationDate: null == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastUpdateDate: null == lastUpdateDate ? _self.lastUpdateDate : lastUpdateDate // ignore: cast_nullable_to_non_nullable
as DateTime,installationId: null == installationId ? _self.installationId : installationId // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,operatingSystem: null == operatingSystem ? _self.operatingSystem : operatingSystem // ignore: cast_nullable_to_non_nullable
as OperatingSystem,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceEntity].
extension DeviceEntityPatterns on DeviceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( DeviceEntityData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case DeviceEntityData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( DeviceEntityData value)  $default,){
final _that = this;
switch (_that) {
case DeviceEntityData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( DeviceEntityData value)?  $default,){
final _that = this;
switch (_that) {
case DeviceEntityData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? id, @JsonKey(name: "user_id")  String? userId, @JsonKey(name: 'creation_date')  DateTime creationDate, @JsonKey(name: 'last_update_date')  DateTime lastUpdateDate, @JsonKey(name: 'installation_id')  String installationId, @JsonKey(name: 'token')  String token, @JsonKey(name: 'operatingSystem')  OperatingSystem operatingSystem)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case DeviceEntityData() when $default != null:
return $default(_that.id,_that.userId,_that.creationDate,_that.lastUpdateDate,_that.installationId,_that.token,_that.operatingSystem);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? id, @JsonKey(name: "user_id")  String? userId, @JsonKey(name: 'creation_date')  DateTime creationDate, @JsonKey(name: 'last_update_date')  DateTime lastUpdateDate, @JsonKey(name: 'installation_id')  String installationId, @JsonKey(name: 'token')  String token, @JsonKey(name: 'operatingSystem')  OperatingSystem operatingSystem)  $default,) {final _that = this;
switch (_that) {
case DeviceEntityData():
return $default(_that.id,_that.userId,_that.creationDate,_that.lastUpdateDate,_that.installationId,_that.token,_that.operatingSystem);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  String? id, @JsonKey(name: "user_id")  String? userId, @JsonKey(name: 'creation_date')  DateTime creationDate, @JsonKey(name: 'last_update_date')  DateTime lastUpdateDate, @JsonKey(name: 'installation_id')  String installationId, @JsonKey(name: 'token')  String token, @JsonKey(name: 'operatingSystem')  OperatingSystem operatingSystem)?  $default,) {final _that = this;
switch (_that) {
case DeviceEntityData() when $default != null:
return $default(_that.id,_that.userId,_that.creationDate,_that.lastUpdateDate,_that.installationId,_that.token,_that.operatingSystem);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class DeviceEntityData extends DeviceEntity {
  const DeviceEntityData({@JsonKey(includeIfNull: false) this.id, @JsonKey(name: "user_id") this.userId, @JsonKey(name: 'creation_date') required this.creationDate, @JsonKey(name: 'last_update_date') required this.lastUpdateDate, @JsonKey(name: 'installation_id') required this.installationId, @JsonKey(name: 'token') required this.token, @JsonKey(name: 'operatingSystem') required this.operatingSystem}): super._();
  factory DeviceEntityData.fromJson(Map<String, dynamic> json) => _$DeviceEntityDataFromJson(json);

@override@JsonKey(includeIfNull: false) final  String? id;
@override@JsonKey(name: "user_id") final  String? userId;
@override@JsonKey(name: 'creation_date') final  DateTime creationDate;
@override@JsonKey(name: 'last_update_date') final  DateTime lastUpdateDate;
@override@JsonKey(name: 'installation_id') final  String installationId;
@override@JsonKey(name: 'token') final  String token;
@override@JsonKey(name: 'operatingSystem') final  OperatingSystem operatingSystem;

/// Create a copy of DeviceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceEntityDataCopyWith<DeviceEntityData> get copyWith => _$DeviceEntityDataCopyWithImpl<DeviceEntityData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceEntityDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceEntityData&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate)&&(identical(other.lastUpdateDate, lastUpdateDate) || other.lastUpdateDate == lastUpdateDate)&&(identical(other.installationId, installationId) || other.installationId == installationId)&&(identical(other.token, token) || other.token == token)&&(identical(other.operatingSystem, operatingSystem) || other.operatingSystem == operatingSystem));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,creationDate,lastUpdateDate,installationId,token,operatingSystem);

@override
String toString() {
  return 'DeviceEntity(id: $id, userId: $userId, creationDate: $creationDate, lastUpdateDate: $lastUpdateDate, installationId: $installationId, token: $token, operatingSystem: $operatingSystem)';
}


}

/// @nodoc
abstract mixin class $DeviceEntityDataCopyWith<$Res> implements $DeviceEntityCopyWith<$Res> {
  factory $DeviceEntityDataCopyWith(DeviceEntityData value, $Res Function(DeviceEntityData) _then) = _$DeviceEntityDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) String? id,@JsonKey(name: "user_id") String? userId,@JsonKey(name: 'creation_date') DateTime creationDate,@JsonKey(name: 'last_update_date') DateTime lastUpdateDate,@JsonKey(name: 'installation_id') String installationId,@JsonKey(name: 'token') String token,@JsonKey(name: 'operatingSystem') OperatingSystem operatingSystem
});




}
/// @nodoc
class _$DeviceEntityDataCopyWithImpl<$Res>
    implements $DeviceEntityDataCopyWith<$Res> {
  _$DeviceEntityDataCopyWithImpl(this._self, this._then);

  final DeviceEntityData _self;
  final $Res Function(DeviceEntityData) _then;

/// Create a copy of DeviceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? creationDate = null,Object? lastUpdateDate = null,Object? installationId = null,Object? token = null,Object? operatingSystem = null,}) {
  return _then(DeviceEntityData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,creationDate: null == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastUpdateDate: null == lastUpdateDate ? _self.lastUpdateDate : lastUpdateDate // ignore: cast_nullable_to_non_nullable
as DateTime,installationId: null == installationId ? _self.installationId : installationId // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,operatingSystem: null == operatingSystem ? _self.operatingSystem : operatingSystem // ignore: cast_nullable_to_non_nullable
as OperatingSystem,
  ));
}


}

// dart format on
