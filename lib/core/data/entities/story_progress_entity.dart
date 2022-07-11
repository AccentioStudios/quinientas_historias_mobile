import 'package:freezed_annotation/freezed_annotation.dart';

import 'story_entity.dart';

part 'story_progress_entity.g.dart';

@JsonSerializable()
class StoryProgress {
  StoryProgress({
    required this.status,
    required this.progress,
    required this.story,
  });

  factory StoryProgress.fromJson(Map<String, dynamic> json) =>
      _$StoryProgressFromJson(json);

  final StoryStatus status;
  final int progress;
  final Story story;

  Map<String, dynamic> toJson() => _$StoryProgressToJson(this);
}

enum StoryStatus {
  @JsonValue('done')
  done,
  @JsonValue('reading')
  reading,
  @JsonValue('unread')
  unread,
}
