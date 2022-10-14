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
      readed: json['readed'] as int?,
      canEdit: json['canEdit'] as bool?,
      leaderboard: (json['leaderboard'] as List<dynamic>?)
          ?.map((e) => LeaderboardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'score': instance.score,
      'avatarUrl': instance.avatarUrl,
      'readed': instance.readed,
      'canEdit': instance.canEdit,
      'leaderboard': instance.leaderboard,
    };
