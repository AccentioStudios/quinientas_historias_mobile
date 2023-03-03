// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_point_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPoint _$UserPointFromJson(Map<String, dynamic> json) => UserPoint(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      points: json['points'] as int?,
      storyId: json['storyId'] as int?,
      teamId: json['teamId'] as int?,
    );

Map<String, dynamic> _$UserPointToJson(UserPoint instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'points': instance.points,
      'storyId': instance.storyId,
      'teamId': instance.teamId,
    };
