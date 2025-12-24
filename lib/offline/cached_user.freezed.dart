// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cached_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CachedUser {

 int get id; String get name; String get email;/// キャッシュされた日時
 DateTime get cachedAt;
/// Create a copy of CachedUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CachedUserCopyWith<CachedUser> get copyWith => _$CachedUserCopyWithImpl<CachedUser>(this as CachedUser, _$identity);

  /// Serializes this CachedUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CachedUser&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,cachedAt);

@override
String toString() {
  return 'CachedUser(id: $id, name: $name, email: $email, cachedAt: $cachedAt)';
}


}

/// @nodoc
abstract mixin class $CachedUserCopyWith<$Res>  {
  factory $CachedUserCopyWith(CachedUser value, $Res Function(CachedUser) _then) = _$CachedUserCopyWithImpl;
@useResult
$Res call({
 int id, String name, String email, DateTime cachedAt
});




}
/// @nodoc
class _$CachedUserCopyWithImpl<$Res>
    implements $CachedUserCopyWith<$Res> {
  _$CachedUserCopyWithImpl(this._self, this._then);

  final CachedUser _self;
  final $Res Function(CachedUser) _then;

/// Create a copy of CachedUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? cachedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,cachedAt: null == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CachedUser].
extension CachedUserPatterns on CachedUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CachedUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CachedUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CachedUser value)  $default,){
final _that = this;
switch (_that) {
case _CachedUser():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CachedUser value)?  $default,){
final _that = this;
switch (_that) {
case _CachedUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String email,  DateTime cachedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CachedUser() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.cachedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String email,  DateTime cachedAt)  $default,) {final _that = this;
switch (_that) {
case _CachedUser():
return $default(_that.id,_that.name,_that.email,_that.cachedAt);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String email,  DateTime cachedAt)?  $default,) {final _that = this;
switch (_that) {
case _CachedUser() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.cachedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CachedUser implements CachedUser {
  const _CachedUser({required this.id, required this.name, required this.email, required this.cachedAt});
  factory _CachedUser.fromJson(Map<String, dynamic> json) => _$CachedUserFromJson(json);

@override final  int id;
@override final  String name;
@override final  String email;
/// キャッシュされた日時
@override final  DateTime cachedAt;

/// Create a copy of CachedUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CachedUserCopyWith<_CachedUser> get copyWith => __$CachedUserCopyWithImpl<_CachedUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CachedUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CachedUser&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.cachedAt, cachedAt) || other.cachedAt == cachedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,cachedAt);

@override
String toString() {
  return 'CachedUser(id: $id, name: $name, email: $email, cachedAt: $cachedAt)';
}


}

/// @nodoc
abstract mixin class _$CachedUserCopyWith<$Res> implements $CachedUserCopyWith<$Res> {
  factory _$CachedUserCopyWith(_CachedUser value, $Res Function(_CachedUser) _then) = __$CachedUserCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String email, DateTime cachedAt
});




}
/// @nodoc
class __$CachedUserCopyWithImpl<$Res>
    implements _$CachedUserCopyWith<$Res> {
  __$CachedUserCopyWithImpl(this._self, this._then);

  final _CachedUser _self;
  final $Res Function(_CachedUser) _then;

/// Create a copy of CachedUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? cachedAt = null,}) {
  return _then(_CachedUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,cachedAt: null == cachedAt ? _self.cachedAt : cachedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
