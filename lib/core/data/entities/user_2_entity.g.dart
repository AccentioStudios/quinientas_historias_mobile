// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_2_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User2 _$User2FromJson(Map<String, dynamic> json) => User2(
      id: json['id'] as int?,
      name: json['name'] as String?,
      givenName: json['givenName'] as String?,
      familyName: json['familyName'] as String?,
      middleName: json['middleName'] as String?,
      nickname: json['nickname'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$User2ToJson(User2 instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'givenName': instance.givenName,
      'familyName': instance.familyName,
      'middleName': instance.middleName,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
    };
