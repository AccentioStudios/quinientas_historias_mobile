// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthDto _$AuthDtoFromJson(Map<String, dynamic> json) => AuthDto(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      payload: JwtPayload.fromJson(json['payload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthDtoToJson(AuthDto instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'payload': instance.payload,
    };

JwtPayload _$JwtPayloadFromJson(Map<String, dynamic> json) => JwtPayload(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      nickname: json['nickname'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      email: json['email'] as String,
      role: $enumDecodeNullable(_$RoleEnumMap, json['role']) ?? Role.public,
      active: json['active'] as bool? ?? false,
    );

Map<String, dynamic> _$JwtPayloadToJson(JwtPayload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
      'role': _$RoleEnumMap[instance.role]!,
      'active': instance.active,
    };

const _$RoleEnumMap = {
  Role.admin: 'admin',
  Role.public: 'public',
  Role.reader: 'reader',
  Role.captain: 'captain',
  Role.prof: 'prof',
  Role.jury: 'jury',
  Role.editor: 'editor',
};
