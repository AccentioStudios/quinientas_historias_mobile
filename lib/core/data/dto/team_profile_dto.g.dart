// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamProfileDto _$TeamProfileDtoFromJson(Map<String, dynamic> json) =>
    TeamProfileDto(
      id: json['id'] as int,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      active: json['active'] as bool,
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
      tournament:
          Tournament.fromJson(json['tournament'] as Map<String, dynamic>),
      canEdit: json['canEdit'] as bool?,
      teamPoints: json['teamPoints'] as int,
      teamReads: json['teamReads'] as int,
      leaderboard: (json['leaderboard'] as List<dynamic>?)
          ?.map((e) => Leaderboard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeamProfileDtoToJson(TeamProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'active': instance.active,
      'school': instance.school,
      'tournament': instance.tournament,
      'canEdit': instance.canEdit,
      'teamPoints': instance.teamPoints,
      'teamReads': instance.teamReads,
      'leaderboard': instance.leaderboard,
    };
