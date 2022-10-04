import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/data/entities/daily_challenge_entity.dart';
import '../../../../../core/data/entities/story_entity.dart';

part 'set_story_progress_response.g.dart';

@JsonSerializable()
class SetStoryProgressResponse {
  SetStoryProgressResponse({
    required this.saved,
    this.points,
    this.dailyChallenge,
    this.recomended,
    this.errorMessage,
  });

  final bool saved;
  final int? points;
  final DailyChallenge? dailyChallenge;
  final List<Story>? recomended;
  final String? errorMessage;

  factory SetStoryProgressResponse.fromJson(Map<String, dynamic> json) =>
      _$SetStoryProgressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SetStoryProgressResponseToJson(this);
}
