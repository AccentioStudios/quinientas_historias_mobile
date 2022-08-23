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
    );

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'score': instance.score,
      'avatarUrl': instance.avatarUrl,
    };
