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
      role: $enumDecodeNullable(_$RoleEnumMap, json['role']) ?? Role.public,
      avatarUrl: json['avatarUrl'] as String?,
      email: json['email'] as String,
      userPoints: (json['userPoints'] as List<dynamic>?)
              ?.map((e) => UserPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      userReads: (json['userReads'] as List<dynamic>?)
              ?.map((e) => UserRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      userFavorites: (json['userFavorites'] as List<dynamic>?)
              ?.map((e) => Favorite.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      favoriteStories: (json['favoriteStories'] as List<dynamic>?)
              ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
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
      'userReads': instance.userReads,
      'userFavorites': instance.userFavorites,
      'team': instance.team,
      'school': instance.school,
      'diceCount': instance.diceCount,
      'favoriteStories': instance.favoriteStories,
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
