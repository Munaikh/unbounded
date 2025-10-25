// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Notification _$NotificationFromJson(
  Map<String, dynamic> json
) {
    return NotificationData.fromJson(
      json
    );
}

/// @nodoc
mixin _$Notification {

 String? get id; String get title; String get body; DateTime get createdAt; DateTime? get readAt;@JsonKey(includeFromJson: false, includeToJson: false) LocalNotifier? get notifier;@JsonKey(includeFromJson: false, includeToJson: false) NotificationSettings? get notifierSettings; NotificationTypes? get type; Map<String, dynamic>? get data;
/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationCopyWith<Notification> get copyWith => _$NotificationCopyWithImpl<Notification>(this as Notification, _$identity);

  /// Serializes this Notification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Notification&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.notifier, notifier) || other.notifier == notifier)&&(identical(other.notifierSettings, notifierSettings) || other.notifierSettings == notifierSettings)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,createdAt,readAt,notifier,notifierSettings,type,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'Notification(id: $id, title: $title, body: $body, createdAt: $createdAt, readAt: $readAt, notifier: $notifier, notifierSettings: $notifierSettings, type: $type, data: $data)';
}


}

/// @nodoc
abstract mixin class $NotificationCopyWith<$Res>  {
  factory $NotificationCopyWith(Notification value, $Res Function(Notification) _then) = _$NotificationCopyWithImpl;
@useResult
$Res call({
 String? id, String title, String body, DateTime createdAt, DateTime? readAt,@JsonKey(includeFromJson: false, includeToJson: false) LocalNotifier? notifier,@JsonKey(includeFromJson: false, includeToJson: false) NotificationSettings? notifierSettings, NotificationTypes? type, Map<String, dynamic>? data
});




}
/// @nodoc
class _$NotificationCopyWithImpl<$Res>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._self, this._then);

  final Notification _self;
  final $Res Function(Notification) _then;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? body = null,Object? createdAt = null,Object? readAt = freezed,Object? notifier = freezed,Object? notifierSettings = freezed,Object? type = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,notifier: freezed == notifier ? _self.notifier : notifier // ignore: cast_nullable_to_non_nullable
as LocalNotifier?,notifierSettings: freezed == notifierSettings ? _self.notifierSettings : notifierSettings // ignore: cast_nullable_to_non_nullable
as NotificationSettings?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationTypes?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Notification].
extension NotificationPatterns on Notification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationData value)?  withData,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationData() when withData != null:
return withData(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationData value)  withData,}){
final _that = this;
switch (_that) {
case NotificationData():
return withData(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationData value)?  withData,}){
final _that = this;
switch (_that) {
case NotificationData() when withData != null:
return withData(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? id,  String title,  String body,  DateTime createdAt,  DateTime? readAt, @JsonKey(includeFromJson: false, includeToJson: false)  LocalNotifier? notifier, @JsonKey(includeFromJson: false, includeToJson: false)  NotificationSettings? notifierSettings,  NotificationTypes? type,  Map<String, dynamic>? data)?  withData,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationData() when withData != null:
return withData(_that.id,_that.title,_that.body,_that.createdAt,_that.readAt,_that.notifier,_that.notifierSettings,_that.type,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? id,  String title,  String body,  DateTime createdAt,  DateTime? readAt, @JsonKey(includeFromJson: false, includeToJson: false)  LocalNotifier? notifier, @JsonKey(includeFromJson: false, includeToJson: false)  NotificationSettings? notifierSettings,  NotificationTypes? type,  Map<String, dynamic>? data)  withData,}) {final _that = this;
switch (_that) {
case NotificationData():
return withData(_that.id,_that.title,_that.body,_that.createdAt,_that.readAt,_that.notifier,_that.notifierSettings,_that.type,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? id,  String title,  String body,  DateTime createdAt,  DateTime? readAt, @JsonKey(includeFromJson: false, includeToJson: false)  LocalNotifier? notifier, @JsonKey(includeFromJson: false, includeToJson: false)  NotificationSettings? notifierSettings,  NotificationTypes? type,  Map<String, dynamic>? data)?  withData,}) {final _that = this;
switch (_that) {
case NotificationData() when withData != null:
return withData(_that.id,_that.title,_that.body,_that.createdAt,_that.readAt,_that.notifier,_that.notifierSettings,_that.type,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class NotificationData extends Notification {
  const NotificationData({this.id, required this.title, required this.body, required this.createdAt, this.readAt, @JsonKey(includeFromJson: false, includeToJson: false) this.notifier, @JsonKey(includeFromJson: false, includeToJson: false) this.notifierSettings, this.type, final  Map<String, dynamic>? data}): _data = data,super._();
  factory NotificationData.fromJson(Map<String, dynamic> json) => _$NotificationDataFromJson(json);

@override final  String? id;
@override final  String title;
@override final  String body;
@override final  DateTime createdAt;
@override final  DateTime? readAt;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  LocalNotifier? notifier;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  NotificationSettings? notifierSettings;
@override final  NotificationTypes? type;
 final  Map<String, dynamic>? _data;
@override Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Notification
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationData&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.notifier, notifier) || other.notifier == notifier)&&(identical(other.notifierSettings, notifierSettings) || other.notifierSettings == notifierSettings)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,createdAt,readAt,notifier,notifierSettings,type,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'Notification.withData(id: $id, title: $title, body: $body, createdAt: $createdAt, readAt: $readAt, notifier: $notifier, notifierSettings: $notifierSettings, type: $type, data: $data)';
}


}

/// @nodoc
abstract mixin class $NotificationDataCopyWith<$Res> implements $NotificationCopyWith<$Res> {
  factory $NotificationDataCopyWith(NotificationData value, $Res Function(NotificationData) _then) = _$NotificationDataCopyWithImpl;
@override @useResult
$Res call({
 String? id, String title, String body, DateTime createdAt, DateTime? readAt,@JsonKey(includeFromJson: false, includeToJson: false) LocalNotifier? notifier,@JsonKey(includeFromJson: false, includeToJson: false) NotificationSettings? notifierSettings, NotificationTypes? type, Map<String, dynamic>? data
});




}
/// @nodoc
class _$NotificationDataCopyWithImpl<$Res>
    implements $NotificationDataCopyWith<$Res> {
  _$NotificationDataCopyWithImpl(this._self, this._then);

  final NotificationData _self;
  final $Res Function(NotificationData) _then;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? body = null,Object? createdAt = null,Object? readAt = freezed,Object? notifier = freezed,Object? notifierSettings = freezed,Object? type = freezed,Object? data = freezed,}) {
  return _then(NotificationData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,notifier: freezed == notifier ? _self.notifier : notifier // ignore: cast_nullable_to_non_nullable
as LocalNotifier?,notifierSettings: freezed == notifierSettings ? _self.notifierSettings : notifierSettings // ignore: cast_nullable_to_non_nullable
as NotificationSettings?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationTypes?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
