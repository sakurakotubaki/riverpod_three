// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CachedUser _$CachedUserFromJson(Map<String, dynamic> json) => _CachedUser(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  cachedAt: DateTime.parse(json['cachedAt'] as String),
);

Map<String, dynamic> _$CachedUserToJson(_CachedUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'cachedAt': instance.cachedAt.toIso8601String(),
    };
