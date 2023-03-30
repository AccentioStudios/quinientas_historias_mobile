// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolProfileDto _$SchoolProfileDtoFromJson(Map<String, dynamic> json) =>
    SchoolProfileDto(
      id: json['id'] as int,
      name: json['name'] as String,
      active: json['active'] as bool,
      schoolPoints: json['schoolPoints'] as int,
      schoolReads: json['schoolReads'] as int,
      avatarUrl: json['avatarUrl'] as String?,
      canEdit: json['canEdit'] as bool?,
      leaderboard: (json['leaderboard'] as List<dynamic>?)
          ?.map((e) => Leaderboard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SchoolProfileDtoToJson(SchoolProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'active': instance.active,
      'canEdit': instance.canEdit,
      'schoolPoints': instance.schoolPoints,
      'schoolReads': instance.schoolReads,
      'leaderboard': instance.leaderboard,
    };
