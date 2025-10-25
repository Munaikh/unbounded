// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signin_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SigninState {

 Email get email; Password get password;
/// Create a copy of SigninState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SigninStateCopyWith<SigninState> get copyWith => _$SigninStateCopyWithImpl<SigninState>(this as SigninState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SigninState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'SigninState(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $SigninStateCopyWith<$Res>  {
  factory $SigninStateCopyWith(SigninState value, $Res Function(SigninState) _then) = _$SigninStateCopyWithImpl;
@useResult
$Res call({
 Email email, Password password
});




}
/// @nodoc
class _$SigninStateCopyWithImpl<$Res>
    implements $SigninStateCopyWith<$Res> {
  _$SigninStateCopyWithImpl(this._self, this._then);

  final SigninState _self;
  final $Res Function(SigninState) _then;

/// Create a copy of SigninState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as Password,
  ));
}

}


/// Adds pattern-matching-related methods to [SigninState].
extension SigninStatePatterns on SigninState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( SigninStateData value)?  $default,{TResult Function( SigninStateSending value)?  sending,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SigninStateData() when $default != null:
return $default(_that);case SigninStateSending() when sending != null:
return sending(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( SigninStateData value)  $default,{required TResult Function( SigninStateSending value)  sending,}){
final _that = this;
switch (_that) {
case SigninStateData():
return $default(_that);case SigninStateSending():
return sending(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( SigninStateData value)?  $default,{TResult? Function( SigninStateSending value)?  sending,}){
final _that = this;
switch (_that) {
case SigninStateData() when $default != null:
return $default(_that);case SigninStateSending() when sending != null:
return sending(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Email email,  Password password)?  $default,{TResult Function( Email email,  Password password)?  sending,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SigninStateData() when $default != null:
return $default(_that.email,_that.password);case SigninStateSending() when sending != null:
return sending(_that.email,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Email email,  Password password)  $default,{required TResult Function( Email email,  Password password)  sending,}) {final _that = this;
switch (_that) {
case SigninStateData():
return $default(_that.email,_that.password);case SigninStateSending():
return sending(_that.email,_that.password);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Email email,  Password password)?  $default,{TResult? Function( Email email,  Password password)?  sending,}) {final _that = this;
switch (_that) {
case SigninStateData() when $default != null:
return $default(_that.email,_that.password);case SigninStateSending() when sending != null:
return sending(_that.email,_that.password);case _:
  return null;

}
}

}

/// @nodoc


class SigninStateData extends SigninState {
  const SigninStateData({required this.email, required this.password}): super._();
  

@override final  Email email;
@override final  Password password;

/// Create a copy of SigninState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SigninStateDataCopyWith<SigninStateData> get copyWith => _$SigninStateDataCopyWithImpl<SigninStateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SigninStateData&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'SigninState(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $SigninStateDataCopyWith<$Res> implements $SigninStateCopyWith<$Res> {
  factory $SigninStateDataCopyWith(SigninStateData value, $Res Function(SigninStateData) _then) = _$SigninStateDataCopyWithImpl;
@override @useResult
$Res call({
 Email email, Password password
});




}
/// @nodoc
class _$SigninStateDataCopyWithImpl<$Res>
    implements $SigninStateDataCopyWith<$Res> {
  _$SigninStateDataCopyWithImpl(this._self, this._then);

  final SigninStateData _self;
  final $Res Function(SigninStateData) _then;

/// Create a copy of SigninState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(SigninStateData(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as Password,
  ));
}


}

/// @nodoc


class SigninStateSending extends SigninState {
  const SigninStateSending({required this.email, required this.password}): super._();
  

@override final  Email email;
@override final  Password password;

/// Create a copy of SigninState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SigninStateSendingCopyWith<SigninStateSending> get copyWith => _$SigninStateSendingCopyWithImpl<SigninStateSending>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SigninStateSending&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'SigninState.sending(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $SigninStateSendingCopyWith<$Res> implements $SigninStateCopyWith<$Res> {
  factory $SigninStateSendingCopyWith(SigninStateSending value, $Res Function(SigninStateSending) _then) = _$SigninStateSendingCopyWithImpl;
@override @useResult
$Res call({
 Email email, Password password
});




}
/// @nodoc
class _$SigninStateSendingCopyWithImpl<$Res>
    implements $SigninStateSendingCopyWith<$Res> {
  _$SigninStateSendingCopyWithImpl(this._self, this._then);

  final SigninStateSending _self;
  final $Res Function(SigninStateSending) _then;

/// Create a copy of SigninState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(SigninStateSending(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as Email,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as Password,
  ));
}


}

// dart format on
