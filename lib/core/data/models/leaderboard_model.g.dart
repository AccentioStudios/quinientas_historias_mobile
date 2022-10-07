// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
      changePosition: json['changePosition'] == null
          ? null
          : LeaderboardChangePosition.fromJson(
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
      'type': _$LeaderboardChangePositionTypeEnumMap[instance.type]!,
    };

const _$LeaderboardChangePositionTypeEnumMap = {
  LeaderboardChangePositionType.positive: 'positive',
  LeaderboardChangePositionType.negative: 'negative',
  LeaderboardChangePositionType.neutral: 'neutral',
};
