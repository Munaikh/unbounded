// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recover_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecoverState {

 Email get email;
/// Create a copy of RecoverState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecoverStateCopyWith<RecoverState> get copyWith => _$RecoverStateCopyWithImpl<RecoverState>(this as RecoverState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoverState&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'RecoverState(email: $email)';
}


}

/// @nodoc
abstract mixin class $RecoverStateCopyWith<$Res>  {
  factory $RecoverStateCopyWith(RecoverState value, $Res Function(RecoverState) _then) = _$RecoverStateCopyWithImpl;
@useResult
$Res call({
 Email email
});




}
/// @nodoc
class _$RecoverStateCopyWithImpl<$Res>
    implements $RecoverStateCopyWith<$Res> {
  _$RecoverStateCopyWithImpl(this._self, this._then);

  final RecoverState _self;
  final $Res Function(RecoverState) _then;

/// Create a copy of RecoverState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}

}


/// Adds pattern-matching-related methods to [RecoverState].
extension RecoverStatePatterns on RecoverState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( RecoverStateData value)?  $default,{TResult Function( RecoverStateSending value)?  sending,TResult Function( RecoverStateSent value)?  sent,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecoverStateData() when $default != null:
return $default(_that);case RecoverStateSending() when sending != null:
return sending(_that);case RecoverStateSent() when sent != null:
return sent(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( RecoverStateData value)  $default,{required TResult Function( RecoverStateSending value)  sending,required TResult Function( RecoverStateSent value)  sent,}){
final _that = this;
switch (_that) {
case RecoverStateData():
return $default(_that);case RecoverStateSending():
return sending(_that);case RecoverStateSent():
return sent(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( RecoverStateData value)?  $default,{TResult? Function( RecoverStateSending value)?  sending,TResult? Function( RecoverStateSent value)?  sent,}){
final _that = this;
switch (_that) {
case RecoverStateData() when $default != null:
return $default(_that);case RecoverStateSending() when sending != null:
return sending(_that);case RecoverStateSent() when sent != null:
return sent(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Email email)?  $default,{TResult Function( Email email)?  sending,TResult Function( Email email)?  sent,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecoverStateData() when $default != null:
return $default(_that.email);case RecoverStateSending() when sending != null:
return sending(_that.email);case RecoverStateSent() when sent != null:
return sent(_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Email email)  $default,{required TResult Function( Email email)  sending,required TResult Function( Email email)  sent,}) {final _that = this;
switch (_that) {
case RecoverStateData():
return $default(_that.email);case RecoverStateSending():
return sending(_that.email);case RecoverStateSent():
return sent(_that.email);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Email email)?  $default,{TResult? Function( Email email)?  sending,TResult? Function( Email email)?  sent,}) {final _that = this;
switch (_that) {
case RecoverStateData() when $default != null:
return $default(_that.email);case RecoverStateSending() when sending != null:
return sending(_that.email);case RecoverStateSent() when sent != null:
return sent(_that.email);case _:
  return null;

}
}

}

/// @nodoc


class RecoverStateData extends RecoverState {
  const RecoverStateData({required this.email}): super._();
  

@override final  Email email;

/// Create a copy of RecoverState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecoverStateDataCopyWith<RecoverStateData> get copyWith => _$RecoverStateDataCopyWithImpl<RecoverStateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoverStateData&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'RecoverState(email: $email)';
}


}

/// @nodoc
abstract mixin class $RecoverStateDataCopyWith<$Res> implements $RecoverStateCopyWith<$Res> {
  factory $RecoverStateDataCopyWith(RecoverStateData value, $Res Function(RecoverStateData) _then) = _$RecoverStateDataCopyWithImpl;
@override @useResult
$Res call({
 Email email
});




}
/// @nodoc
class _$RecoverStateDataCopyWithImpl<$Res>
    implements $RecoverStateDataCopyWith<$Res> {
  _$RecoverStateDataCopyWithImpl(this._self, this._then);

  final RecoverStateData _self;
  final $Res Function(RecoverStateData) _then;

/// Create a copy of RecoverState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(RecoverStateData(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}


}

/// @nodoc


class RecoverStateSending extends RecoverState {
  const RecoverStateSending({required this.email}): super._();
  

@override final  Email email;

/// Create a copy of RecoverState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecoverStateSendingCopyWith<RecoverStateSending> get copyWith => _$RecoverStateSendingCopyWithImpl<RecoverStateSending>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoverStateSending&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'RecoverState.sending(email: $email)';
}


}

/// @nodoc
abstract mixin class $RecoverStateSendingCopyWith<$Res> implements $RecoverStateCopyWith<$Res> {
  factory $RecoverStateSendingCopyWith(RecoverStateSending value, $Res Function(RecoverStateSending) _then) = _$RecoverStateSendingCopyWithImpl;
@override @useResult
$Res call({
 Email email
});




}
/// @nodoc
class _$RecoverStateSendingCopyWithImpl<$Res>
    implements $RecoverStateSendingCopyWith<$Res> {
  _$RecoverStateSendingCopyWithImpl(this._self, this._then);

  final RecoverStateSending _self;
  final $Res Function(RecoverStateSending) _then;

/// Create a copy of RecoverState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(RecoverStateSending(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}


}

/// @nodoc


class RecoverStateSent extends RecoverState {
  const RecoverStateSent({required this.email}): super._();
  

@override final  Email email;

/// Create a copy of RecoverState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecoverStateSentCopyWith<RecoverStateSent> get copyWith => _$RecoverStateSentCopyWithImpl<RecoverStateSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoverStateSent&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'RecoverState.sent(email: $email)';
}


}

/// @nodoc
abstract mixin class $RecoverStateSentCopyWith<$Res> implements $RecoverStateCopyWith<$Res> {
  factory $RecoverStateSentCopyWith(RecoverStateSent value, $Res Function(RecoverStateSent) _then) = _$RecoverStateSentCopyWithImpl;
@override @useResult
$Res call({
 Email email
});




}
/// @nodoc
class _$RecoverStateSentCopyWithImpl<$Res>
    implements $RecoverStateSentCopyWith<$Res> {
  _$RecoverStateSentCopyWithImpl(this._self, this._then);

  final RecoverStateSent _self;
  final $Res Function(RecoverStateSent) _then;

/// Create a copy of RecoverState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(RecoverStateSent(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,
  ));
}


}

// dart format on
