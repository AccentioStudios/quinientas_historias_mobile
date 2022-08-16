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
      recomendedStories: (json['recomendedStories'] as List<dynamic>?)
          ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$SetStoryProgressResponseToJson(
        SetStoryProgressResponse instance) =>
    <String, dynamic>{
      'saved': instance.saved,
      'points': instance.points,
      'recomendedStories': instance.recomendedStories,
      'errorMessage': instance.errorMessage,
    };
