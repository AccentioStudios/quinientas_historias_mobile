import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/story_entity.dart';

part 'quiz_items.entity.g.dart';

@JsonSerializable()
class QuizItem {
  QuizItem(
      {this.id,
      required this.question,
      required this.options,
      this.answered,
      this.wasCorrect,
      required this.correctAnswer,
      required this.explanation,
      required this.points,
      this.storyId,
      this.liked,
      this.story});

  factory QuizItem.fromJson(Map<String, dynamic> json) =>
      _$QuizItemFromJson(json);

  final int? id;
  final String question;
  final List<String> options;
  int? answered;
  bool? wasCorrect;
  final String correctAnswer;
  final int? storyId;
  final String explanation;
  final int points;
  bool? liked;
  Story? story;

  Map<String, dynamic> toJson() => _$QuizItemToJson(this);
}
