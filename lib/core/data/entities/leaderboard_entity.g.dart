// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leaderboard _$LeaderboardFromJson(Map<String, dynamic> json) => Leaderboard(
      rankPlace: json['rankPlace'] as int,
      userPoints: json['userPoints'] as int,
      userReads: json['userReads'] as int,
      userDivision: json['userDivision'] == null
          ? null
          : UserDivision.fromJson(json['userDivision'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LeaderboardToJson(Leaderboard instance) =>
    <String, dynamic>{
      'rankPlace': instance.rankPlace,
      'userPoints': instance.userPoints,
      'userReads': instance.userReads,
      'userDivision': instance.userDivision,
      'user': instance.user,
      'team': instance.team,
      'school': instance.school,
    };
