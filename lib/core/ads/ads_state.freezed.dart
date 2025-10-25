// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ads_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdState {

 DateTime? get lastAdShown;
/// Create a copy of AdState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdStateCopyWith<AdState> get copyWith => _$AdStateCopyWithImpl<AdState>(this as AdState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdState&&(identical(other.lastAdShown, lastAdShown) || other.lastAdShown == lastAdShown));
}


@override
int get hashCode => Object.hash(runtimeType,lastAdShown);

@override
String toString() {
  return 'AdState(lastAdShown: $lastAdShown)';
}


}

/// @nodoc
abstract mixin class $AdStateCopyWith<$Res>  {
  factory $AdStateCopyWith(AdState value, $Res Function(AdState) _then) = _$AdStateCopyWithImpl;
@useResult
$Res call({
 DateTime? lastAdShown
});




}
/// @nodoc
class _$AdStateCopyWithImpl<$Res>
    implements $AdStateCopyWith<$Res> {
  _$AdStateCopyWithImpl(this._self, this._then);

  final AdState _self;
  final $Res Function(AdState) _then;

/// Create a copy of AdState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastAdShown = freezed,}) {
  return _then(_self.copyWith(
lastAdShown: freezed == lastAdShown ? _self.lastAdShown : lastAdShown // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdState].
extension AdStatePatterns on AdState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdState value)  $default,){
final _that = this;
switch (_that) {
case _AdState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdState value)?  $default,){
final _that = this;
switch (_that) {
case _AdState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? lastAdShown)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdState() when $default != null:
return $default(_that.lastAdShown);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? lastAdShown)  $default,) {final _that = this;
switch (_that) {
case _AdState():
return $default(_that.lastAdShown);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? lastAdShown)?  $default,) {final _that = this;
switch (_that) {
case _AdState() when $default != null:
return $default(_that.lastAdShown);case _:
  return null;

}
}

}

/// @nodoc


class _AdState extends AdState {
  const _AdState({this.lastAdShown}): super._();
  

@override final  DateTime? lastAdShown;

/// Create a copy of AdState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdStateCopyWith<_AdState> get copyWith => __$AdStateCopyWithImpl<_AdState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdState&&(identical(other.lastAdShown, lastAdShown) || other.lastAdShown == lastAdShown));
}


@override
int get hashCode => Object.hash(runtimeType,lastAdShown);

@override
String toString() {
  return 'AdState(lastAdShown: $lastAdShown)';
}


}

/// @nodoc
abstract mixin class _$AdStateCopyWith<$Res> implements $AdStateCopyWith<$Res> {
  factory _$AdStateCopyWith(_AdState value, $Res Function(_AdState) _then) = __$AdStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime? lastAdShown
});




}
/// @nodoc
class __$AdStateCopyWithImpl<$Res>
    implements _$AdStateCopyWith<$Res> {
  __$AdStateCopyWithImpl(this._self, this._then);

  final _AdState _self;
  final $Res Function(_AdState) _then;

/// Create a copy of AdState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastAdShown = freezed,}) {
  return _then(_AdState(
lastAdShown: freezed == lastAdShown ? _self.lastAdShown : lastAdShown // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
