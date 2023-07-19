import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/data/entities/daily_challenge_entity.dart';
import '../../../../../core/data/entities/story_entity.dart';
import '../../../../quiz/domain/entities/quiz_items.entity.dart';

part 'set_story_progress_response.g.dart';

@JsonSerializable()
class SetStoryProgressResponse {
  SetStoryProgressResponse({
    required this.saved,
    required this.points,
    this.dailyChallenge,
    this.recomended,
    this.errorMessage,
    this.quizItems,
  });

  final bool saved;
  final Points points;
  final DailyChallenge? dailyChallenge;
  final List<Story>? recomended;
  final String? errorMessage;
  final List<QuizItem>? quizItems;

  factory SetStoryProgressResponse.fromJson(Map<String, dynamic> json) =>
      _$SetStoryProgressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SetStoryProgressResponseToJson(this);
}

@JsonSerializable()
class Points {
  const Points({required this.base, required this.bonus});

  factory Points.fromJson(Map<String, dynamic> json) => _$PointsFromJson(json);

  final int base;
  final int bonus;

  Map<String, dynamic> toJson() => _$PointsToJson(this);
}
