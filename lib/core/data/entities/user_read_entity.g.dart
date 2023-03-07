// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_read_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRead _$UserReadFromJson(Map<String, dynamic> json) => UserRead(
      userId: json['userId'] as int,
      storyId: json['storyId'] as int,
      teamId: json['teamId'] as int?,
    );

Map<String, dynamic> _$UserReadToJson(UserRead instance) => <String, dynamic>{
      'userId': instance.userId,
      'storyId': instance.storyId,
      'teamId': instance.teamId,
    };
