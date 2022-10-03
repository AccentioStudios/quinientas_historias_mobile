import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/story_ratings_entity.dart';

import 'story_entity.dart';

part 'story_progress_entity.g.dart';

@JsonSerializable()
class StoryProgress {
  StoryProgress({
    required this.status,
    required this.progress,
    required this.story,
    this.myRating,
  });

  factory StoryProgress.fromJson(Map<String, dynamic> json) =>
      _$StoryProgressFromJson(json);

  @Default(StoryStatus.unread)
  StoryStatus status;
  @Default(0)
  int progress;
  final Story story;
  final StoryRatings? myRating;

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
