// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileDto _$UserProfileDtoFromJson(Map<String, dynamic> json) =>
    UserProfileDto(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      nickname: json['nickname'] as String?,
      role: $enumDecode(_$RoleEnumMap, json['role']),
      avatarUrl: json['avatarUrl'] as String?,
      email: json['email'] as String,
      favoriteStories: (json['favoriteStories'] as List<dynamic>?)
              ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
      previousTeams: (json['previousTeams'] as List<dynamic>)
          .map((e) => Team.fromJson(e as Map<String, dynamic>))
          .toList(),
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
      userReadsCount: json['userReadsCount'] as int,
      userTeamRank: json['userTeamRank'] as int,
      userTeamPoints: json['userTeamPoints'] as int,
    );

Map<String, dynamic> _$UserProfileDtoToJson(UserProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'nickname': instance.nickname,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'role': _$RoleEnumMap[instance.role]!,
      'userReadsCount': instance.userReadsCount,
      'favoriteStories': instance.favoriteStories,
      'userTeamPoints': instance.userTeamPoints,
      'userTeamRank': instance.userTeamRank,
      'team': instance.team,
      'school': instance.school,
      'previousTeams': instance.previousTeams,
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
