// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_progress_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryProgress _$StoryProgressFromJson(Map<String, dynamic> json) =>
    StoryProgress(
      status: $enumDecode(_$StoryStatusEnumMap, json['status']),
      progress: json['progress'] as int,
      story: Story.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoryProgressToJson(StoryProgress instance) =>
    <String, dynamic>{
      'status': _$StoryStatusEnumMap[instance.status],
      'progress': instance.progress,
      'story': instance.story,
    };

const _$StoryStatusEnumMap = {
  StoryStatus.done: 'done',
  StoryStatus.reading: 'reading',
  StoryStatus.unread: 'unread',
};
