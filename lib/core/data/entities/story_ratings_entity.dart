import 'package:freezed_annotation/freezed_annotation.dart';

import 'story_entity.dart';

part 'story_ratings_entity.g.dart';

@JsonSerializable()
class StoryRatings {
  StoryRatings({
    required this.id,
    required this.storyId,
    required this.userId,
    required this.niceRating,
    this.qualityRating,
    this.veracityRating,
    this.originalityRating,
    this.educationalRating,
    this.story,
  });

  factory StoryRatings.fromJson(Map<String, dynamic> json) =>
      _$StoryRatingsFromJson(json);

  final int id;
  final int storyId;
  final int userId;
  final int niceRating;
  final int? qualityRating;
  final int? veracityRating;
  final int? originalityRating;
  final int? educationalRating;
  final Story? story;

  Map<String, dynamic> toJson() => _$StoryRatingsToJson(this);
}
