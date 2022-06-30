// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_progress_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryProgress _$StoryProgressFromJson(Map<String, dynamic> json) =>
    StoryProgress(
      state: $enumDecode(_$ReadingBookStateEnumMap, json['state']),
      progress: json['progress'] as int,
      story: Story.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoryProgressToJson(StoryProgress instance) =>
    <String, dynamic>{
      'state': _$ReadingBookStateEnumMap[instance.state],
      'progress': instance.progress,
      'story': instance.story,
    };

const _$ReadingBookStateEnumMap = {
  ReadingBookState.done: 'done',
  ReadingBookState.reading: 'reading',
  ReadingBookState.unread: 'unread',
};
