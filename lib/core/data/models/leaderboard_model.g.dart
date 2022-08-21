// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardFilterModel _$LeaderboardFilterModelFromJson(
        Map<String, dynamic> json) =>
    LeaderboardFilterModel(
      tournament:
          Tournament.fromJson(json['tournament'] as Map<String, dynamic>),
      leaderboard: (json['leaderboard'] as List<dynamic>)
          .map((e) => LeaderboardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeaderboardFilterModelToJson(
        LeaderboardFilterModel instance) =>
    <String, dynamic>{
      'tournament': instance.tournament,
      'leaderboard': instance.leaderboard,
    };

LeaderboardModel _$LeaderboardModelFromJson(Map<String, dynamic> json) =>
    LeaderboardModel(
      position: json['position'] as int,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
      changePosition: LeaderboardChangePosition.fromJson(
          json['changePosition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LeaderboardModelToJson(LeaderboardModel instance) =>
    <String, dynamic>{
      'position': instance.position,
      'user': instance.user,
      'team': instance.team,
      'school': instance.school,
      'changePosition': instance.changePosition,
    };

LeaderboardChangePosition _$LeaderboardChangePositionFromJson(
        Map<String, dynamic> json) =>
    LeaderboardChangePosition(
      number: json['number'] as int,
      type: $enumDecode(_$LeaderboardChangePositionTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$LeaderboardChangePositionToJson(
        LeaderboardChangePosition instance) =>
    <String, dynamic>{
      'number': instance.number,
      'type': _$LeaderboardChangePositionTypeEnumMap[instance.type],
    };

const _$LeaderboardChangePositionTypeEnumMap = {
  LeaderboardChangePositionType.positive: 'positive',
  LeaderboardChangePositionType.negative: 'negative',
  LeaderboardChangePositionType.neutral: 'neutral',
};
