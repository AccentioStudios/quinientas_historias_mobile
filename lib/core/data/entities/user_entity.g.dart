// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      nickname: json['nickname'] as String?,
      active: json['active'] as bool? ?? false,
      role: $enumDecode(_$RoleEnumMap, json['role']),
      avatarUrl: json['avatarUrl'] as String?,
      email: json['email'] as String,
      userPoints: (json['userPoints'] as List<dynamic>?)
          ?.map((e) => UserPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      userDivisions: (json['userDivisions'] as List<dynamic>?)
          ?.map((e) => UserDivision.fromJson(e as Map<String, dynamic>))
          .toList(),
      favoriteStories: (json['favoriteStories'] as List<dynamic>?)
          ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) => Team.fromJson(e as Map<String, dynamic>))
          .toList(),
      schools: (json['schools'] as List<dynamic>?)
          ?.map((e) => School.fromJson(e as Map<String, dynamic>))
          .toList(),
      diceCount: json['diceCount'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
      'active': instance.active,
      'role': _$RoleEnumMap[instance.role]!,
      'userPoints': instance.userPoints,
      'favoriteStories': instance.favoriteStories,
      'teams': instance.teams,
      'schools': instance.schools,
      'userDivisions': instance.userDivisions,
      'diceCount': instance.diceCount,
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
