// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$User {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'User()';
}


}

/// @nodoc
class $UserCopyWith<$Res>  {
$UserCopyWith(User _, $Res Function(User) __);
}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthenticatedUserData value)?  authenticated,TResult Function( AnonymousUserData value)?  anonymous,TResult Function( LoadingUserData value)?  loading,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthenticatedUserData() when authenticated != null:
return authenticated(_that);case AnonymousUserData() when anonymous != null:
return anonymous(_that);case LoadingUserData() when loading != null:
return loading(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthenticatedUserData value)  authenticated,required TResult Function( AnonymousUserData value)  anonymous,required TResult Function( LoadingUserData value)  loading,}){
final _that = this;
switch (_that) {
case AuthenticatedUserData():
return authenticated(_that);case AnonymousUserData():
return anonymous(_that);case LoadingUserData():
return loading(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthenticatedUserData value)?  authenticated,TResult? Function( AnonymousUserData value)?  anonymous,TResult? Function( LoadingUserData value)?  loading,}){
final _that = this;
switch (_that) {
case AuthenticatedUserData() when authenticated != null:
return authenticated(_that);case AnonymousUserData() when anonymous != null:
return anonymous(_that);case LoadingUserData() when loading != null:
return loading(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email,  String? name,  String? id,  DateTime? creationDate,  DateTime? lastUpdateDate,  String? avatarPath,  bool onboarded,  Subscription? subscription)?  authenticated,TResult Function( String? id,  bool? onboarded,  Subscription? subscription,  DateTime? creationDate,  DateTime? lastUpdateDate)?  anonymous,TResult Function()?  loading,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthenticatedUserData() when authenticated != null:
return authenticated(_that.email,_that.name,_that.id,_that.creationDate,_that.lastUpdateDate,_that.avatarPath,_that.onboarded,_that.subscription);case AnonymousUserData() when anonymous != null:
return anonymous(_that.id,_that.onboarded,_that.subscription,_that.creationDate,_that.lastUpdateDate);case LoadingUserData() when loading != null:
return loading();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email,  String? name,  String? id,  DateTime? creationDate,  DateTime? lastUpdateDate,  String? avatarPath,  bool onboarded,  Subscription? subscription)  authenticated,required TResult Function( String? id,  bool? onboarded,  Subscription? subscription,  DateTime? creationDate,  DateTime? lastUpdateDate)  anonymous,required TResult Function()  loading,}) {final _that = this;
switch (_that) {
case AuthenticatedUserData():
return authenticated(_that.email,_that.name,_that.id,_that.creationDate,_that.lastUpdateDate,_that.avatarPath,_that.onboarded,_that.subscription);case AnonymousUserData():
return anonymous(_that.id,_that.onboarded,_that.subscription,_that.creationDate,_that.lastUpdateDate);case LoadingUserData():
return loading();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email,  String? name,  String? id,  DateTime? creationDate,  DateTime? lastUpdateDate,  String? avatarPath,  bool onboarded,  Subscription? subscription)?  authenticated,TResult? Function( String? id,  bool? onboarded,  Subscription? subscription,  DateTime? creationDate,  DateTime? lastUpdateDate)?  anonymous,TResult? Function()?  loading,}) {final _that = this;
switch (_that) {
case AuthenticatedUserData() when authenticated != null:
return authenticated(_that.email,_that.name,_that.id,_that.creationDate,_that.lastUpdateDate,_that.avatarPath,_that.onboarded,_that.subscription);case AnonymousUserData() when anonymous != null:
return anonymous(_that.id,_that.onboarded,_that.subscription,_that.creationDate,_that.lastUpdateDate);case LoadingUserData() when loading != null:
return loading();case _:
  return null;

}
}

}

/// @nodoc


class AuthenticatedUserData extends User {
  const AuthenticatedUserData({required this.email, this.name, this.id, this.creationDate, this.lastUpdateDate, this.avatarPath, required this.onboarded, this.subscription}): super._();
  

 final  String email;
 final  String? name;
 final  String? id;
 final  DateTime? creationDate;
 final  DateTime? lastUpdateDate;
 final  String? avatarPath;
 final  bool onboarded;
// this will be empty only if you don't use the Subscription module
 final  Subscription? subscription;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticatedUserDataCopyWith<AuthenticatedUserData> get copyWith => _$AuthenticatedUserDataCopyWithImpl<AuthenticatedUserData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticatedUserData&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate)&&(identical(other.lastUpdateDate, lastUpdateDate) || other.lastUpdateDate == lastUpdateDate)&&(identical(other.avatarPath, avatarPath) || other.avatarPath == avatarPath)&&(identical(other.onboarded, onboarded) || other.onboarded == onboarded)&&(identical(other.subscription, subscription) || other.subscription == subscription));
}


@override
int get hashCode => Object.hash(runtimeType,email,name,id,creationDate,lastUpdateDate,avatarPath,onboarded,subscription);

@override
String toString() {
  return 'User.authenticated(email: $email, name: $name, id: $id, creationDate: $creationDate, lastUpdateDate: $lastUpdateDate, avatarPath: $avatarPath, onboarded: $onboarded, subscription: $subscription)';
}


}

/// @nodoc
abstract mixin class $AuthenticatedUserDataCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory $AuthenticatedUserDataCopyWith(AuthenticatedUserData value, $Res Function(AuthenticatedUserData) _then) = _$AuthenticatedUserDataCopyWithImpl;
@useResult
$Res call({
 String email, String? name, String? id, DateTime? creationDate, DateTime? lastUpdateDate, String? avatarPath, bool onboarded, Subscription? subscription
});




}
/// @nodoc
class _$AuthenticatedUserDataCopyWithImpl<$Res>
    implements $AuthenticatedUserDataCopyWith<$Res> {
  _$AuthenticatedUserDataCopyWithImpl(this._self, this._then);

  final AuthenticatedUserData _self;
  final $Res Function(AuthenticatedUserData) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? name = freezed,Object? id = freezed,Object? creationDate = freezed,Object? lastUpdateDate = freezed,Object? avatarPath = freezed,Object? onboarded = null,Object? subscription = freezed,}) {
  return _then(AuthenticatedUserData(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,creationDate: freezed == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdateDate: freezed == lastUpdateDate ? _self.lastUpdateDate : lastUpdateDate // ignore: cast_nullable_to_non_nullable
as DateTime?,avatarPath: freezed == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String?,onboarded: null == onboarded ? _self.onboarded : onboarded // ignore: cast_nullable_to_non_nullable
as bool,subscription: freezed == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as Subscription?,
  ));
}


}

/// @nodoc


class AnonymousUserData extends User {
  const AnonymousUserData({this.id, this.onboarded, this.subscription, this.creationDate, this.lastUpdateDate}): super._();
  

 final  String? id;
 final  bool? onboarded;
 final  Subscription? subscription;
 final  DateTime? creationDate;
 final  DateTime? lastUpdateDate;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnonymousUserDataCopyWith<AnonymousUserData> get copyWith => _$AnonymousUserDataCopyWithImpl<AnonymousUserData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnonymousUserData&&(identical(other.id, id) || other.id == id)&&(identical(other.onboarded, onboarded) || other.onboarded == onboarded)&&(identical(other.subscription, subscription) || other.subscription == subscription)&&(identical(other.creationDate, creationDate) || other.creationDate == creationDate)&&(identical(other.lastUpdateDate, lastUpdateDate) || other.lastUpdateDate == lastUpdateDate));
}


@override
int get hashCode => Object.hash(runtimeType,id,onboarded,subscription,creationDate,lastUpdateDate);

@override
String toString() {
  return 'User.anonymous(id: $id, onboarded: $onboarded, subscription: $subscription, creationDate: $creationDate, lastUpdateDate: $lastUpdateDate)';
}


}

/// @nodoc
abstract mixin class $AnonymousUserDataCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory $AnonymousUserDataCopyWith(AnonymousUserData value, $Res Function(AnonymousUserData) _then) = _$AnonymousUserDataCopyWithImpl;
@useResult
$Res call({
 String? id, bool? onboarded, Subscription? subscription, DateTime? creationDate, DateTime? lastUpdateDate
});




}
/// @nodoc
class _$AnonymousUserDataCopyWithImpl<$Res>
    implements $AnonymousUserDataCopyWith<$Res> {
  _$AnonymousUserDataCopyWithImpl(this._self, this._then);

  final AnonymousUserData _self;
  final $Res Function(AnonymousUserData) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? onboarded = freezed,Object? subscription = freezed,Object? creationDate = freezed,Object? lastUpdateDate = freezed,}) {
  return _then(AnonymousUserData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,onboarded: freezed == onboarded ? _self.onboarded : onboarded // ignore: cast_nullable_to_non_nullable
as bool?,subscription: freezed == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as Subscription?,creationDate: freezed == creationDate ? _self.creationDate : creationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdateDate: freezed == lastUpdateDate ? _self.lastUpdateDate : lastUpdateDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class LoadingUserData extends User {
  const LoadingUserData(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingUserData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'User.loading()';
}


}




// dart format on
