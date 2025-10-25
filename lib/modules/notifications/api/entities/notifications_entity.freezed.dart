// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
NotificationEntity _$NotificationEntityFromJson(
  Map<String, dynamic> json
) {
    return NotificationData.fromJson(
      json
    );
}

/// @nodoc
mixin _$NotificationEntity {

 String? get id;@JsonKey(name: 'user_id') String? get userId;@JsonKey(name: 'title') String get title;@JsonKey(name: 'creation_date') DateTime get creationDate;@JsonKey(name: 'body') String get body;@JsonKey(name: 'read_date') DateTime? get readDate;@JsonKey(name: 'type') NotificationTypes? get type;@JsonKey(name: 'data') Map<String, dynamic>? get data;
/// Create a copy of NotificationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationEntityCopyWith<NotificationEntity> get copyWith => _$NotificationEntityCopyWithImpl<NotificationEntity>(this as NotificationEntity, _$identity);

  /// Serializes this NotificationEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate)&&(identical(other.body, body) || other.body == body)&&(identical(other.readDate, readDate) || other.readDate == readDate)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,creationDate,body,readDate,type,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'NotificationEntity(id: $id, userId: $userId, title: $title, creationDate: $creationDate, body: $body, readDate: $readDate, type: $type, data: $data)';
}


}

/// @nodoc
abstract mixin class $NotificationEntityCopyWith<$Res>  {
  factory $NotificationEntityCopyWith(NotificationEntity value, $Res Function(NotificationEntity) _then) = _$NotificationEntityCopyWithImpl;
@useResult
$Res call({
 String? id,@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'title') String title,@JsonKey(name: 'creation_date') DateTime creationDate,@JsonKey(name: 'body') String body,@JsonKey(name: 'read_date') DateTime? readDate,@JsonKey(name: 'type') NotificationTypes? type,@JsonKey(name: 'data') Map<String, dynamic>? data
});




}
/// @nodoc
class _$NotificationEntityCopyWithImpl<$Res>
    implements $NotificationEntityCopyWith<$Res> {
  _$NotificationEntityCopyWithImpl(this._self, this._then);

  final NotificationEntity _self;
  final $Res Function(NotificationEntity) _then;

/// Create a copy of NotificationEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = freezed,Object? title = null,Object? creationDate = null,Object? body = null,Object? readDate = freezed,Object? type = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,creationDate: null == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,readDate: freezed == readDate ? _self.readDate : readDate // ignore: cast_nullable_to_non_nullable
as DateTime?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationTypes?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationEntity].
extension NotificationEntityPatterns on NotificationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( NotificationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( NotificationData value)  $default,){
final _that = this;
switch (_that) {
case NotificationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( NotificationData value)?  $default,){
final _that = this;
switch (_that) {
case NotificationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'title')  String title, @JsonKey(name: 'creation_date')  DateTime creationDate, @JsonKey(name: 'body')  String body, @JsonKey(name: 'read_date')  DateTime? readDate, @JsonKey(name: 'type')  NotificationTypes? type, @JsonKey(name: 'data')  Map<String, dynamic>? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationData() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.creationDate,_that.body,_that.readDate,_that.type,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'title')  String title, @JsonKey(name: 'creation_date')  DateTime creationDate, @JsonKey(name: 'body')  String body, @JsonKey(name: 'read_date')  DateTime? readDate, @JsonKey(name: 'type')  NotificationTypes? type, @JsonKey(name: 'data')  Map<String, dynamic>? data)  $default,) {final _that = this;
switch (_that) {
case NotificationData():
return $default(_that.id,_that.userId,_that.title,_that.creationDate,_that.body,_that.readDate,_that.type,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'title')  String title, @JsonKey(name: 'creation_date')  DateTime creationDate, @JsonKey(name: 'body')  String body, @JsonKey(name: 'read_date')  DateTime? readDate, @JsonKey(name: 'type')  NotificationTypes? type, @JsonKey(name: 'data')  Map<String, dynamic>? data)?  $default,) {final _that = this;
switch (_that) {
case NotificationData() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.creationDate,_that.body,_that.readDate,_that.type,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class NotificationData implements NotificationEntity {
  const NotificationData({this.id, @JsonKey(name: 'user_id') this.userId, @JsonKey(name: 'title') required this.title, @JsonKey(name: 'creation_date') required this.creationDate, @JsonKey(name: 'body') required this.body, @JsonKey(name: 'read_date') this.readDate, @JsonKey(name: 'type') this.type, @JsonKey(name: 'data') final  Map<String, dynamic>? data}): _data = data;
  factory NotificationData.fromJson(Map<String, dynamic> json) => _$NotificationDataFromJson(json);

@override final  String? id;
@override@JsonKey(name: 'user_id') final  String? userId;
@override@JsonKey(name: 'title') final  String title;
@override@JsonKey(name: 'creation_date') final  DateTime creationDate;
@override@JsonKey(name: 'body') final  String body;
@override@JsonKey(name: 'read_date') final  DateTime? readDate;
@override@JsonKey(name: 'type') final  NotificationTypes? type;
 final  Map<String, dynamic>? _data;
@override@JsonKey(name: 'data') Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of NotificationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDataCopyWith<NotificationData> get copyWith => _$NotificationDataCopyWithImpl<NotificationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationData&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate)&&(identical(other.body, body) || other.body == body)&&(identical(other.readDate, readDate) || other.readDate == readDate)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,creationDate,body,readDate,type,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'NotificationEntity(id: $id, userId: $userId, title: $title, creationDate: $creationDate, body: $body, readDate: $readDate, type: $type, data: $data)';
}


}

/// @nodoc
abstract mixin class $NotificationDataCopyWith<$Res> implements $NotificationEntityCopyWith<$Res> {
  factory $NotificationDataCopyWith(NotificationData value, $Res Function(NotificationData) _then) = _$NotificationDataCopyWithImpl;
@override @useResult
$Res call({
 String? id,@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'title') String title,@JsonKey(name: 'creation_date') DateTime creationDate,@JsonKey(name: 'body') String body,@JsonKey(name: 'read_date') DateTime? readDate,@JsonKey(name: 'type') NotificationTypes? type,@JsonKey(name: 'data') Map<String, dynamic>? data
});




}
/// @nodoc
class _$NotificationDataCopyWithImpl<$Res>
    implements $NotificationDataCopyWith<$Res> {
  _$NotificationDataCopyWithImpl(this._self, this._then);

  final NotificationData _self;
  final $Res Function(NotificationData) _then;

/// Create a copy of NotificationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? title = null,Object? creationDate = null,Object? body = null,Object? readDate = freezed,Object? type = freezed,Object? data = freezed,}) {
  return _then(NotificationData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,creationDate: null == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,readDate: freezed == readDate ? _self.readDate : readDate // ignore: cast_nullable_to_non_nullable
as DateTime?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationTypes?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
