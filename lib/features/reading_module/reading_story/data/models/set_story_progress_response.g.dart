// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_story_progress_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetStoryProgressResponse _$SetStoryProgressResponseFromJson(
        Map<String, dynamic> json) =>
    SetStoryProgressResponse(
      saved: json['saved'] as bool,
      points: json['points'] as int?,
      dailyChallenge: json['dailyChallenge'] == null
          ? null
          : DailyChallenge.fromJson(
              json['dailyChallenge'] as Map<String, dynamic>),
      recomended: (json['recomended'] as List<dynamic>?)
          ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$SetStoryProgressResponseToJson(
        SetStoryProgressResponse instance) =>
    <String, dynamic>{
      'saved': instance.saved,
      'points': instance.points,
      'dailyChallenge': instance.dailyChallenge,
      'recomended': instance.recomended,
      'errorMessage': instance.errorMessage,
    };
