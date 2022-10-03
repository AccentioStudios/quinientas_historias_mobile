// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_ratings_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryRatings _$StoryRatingsFromJson(Map<String, dynamic> json) => StoryRatings(
      id: json['id'] as int,
      storyId: json['storyId'] as int,
      userId: json['userId'] as int,
      niceRating: json['niceRating'] as int,
      qualityRating: json['qualityRating'] as int?,
      veracityRating: json['veracityRating'] as int?,
      originalityRating: json['originalityRating'] as int?,
      educationalRating: json['educationalRating'] as int?,
      story: json['story'] == null
          ? null
          : Story.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoryRatingsToJson(StoryRatings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storyId': instance.storyId,
      'userId': instance.userId,
      'niceRating': instance.niceRating,
      'qualityRating': instance.qualityRating,
      'veracityRating': instance.veracityRating,
      'originalityRating': instance.originalityRating,
      'educationalRating': instance.educationalRating,
      'story': instance.story,
    };
