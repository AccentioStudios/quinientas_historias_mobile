// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

School _$SchoolFromJson(Map<String, dynamic> json) => School(
      id: json['id'] as int,
      name: json['name'] as String,
      score: json['score'] as int?,
      avatarUrl: json['avatarUrl'] as String?,
      readings: json['readings'] as int?,
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) => LeaderboardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'score': instance.score,
      'avatarUrl': instance.avatarUrl,
      'readings': instance.readings,
      'teams': instance.teams,
    };
