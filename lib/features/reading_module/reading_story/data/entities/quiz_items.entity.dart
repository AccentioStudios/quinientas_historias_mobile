import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_items.entity.g.dart';

@JsonSerializable()
class QuizItem {
  QuizItem({
    required this.id,
    required this.question,
    required this.options,
    this.answered,
    this.wasCorrect,
    required this.correctAnswer,
    required this.explanation,
    required this.points,
  });

  factory QuizItem.fromJson(Map<String, dynamic> json) =>
      _$QuizItemFromJson(json);

  final int id;
  final String question;
  final List<String> options;
  int? answered;
  bool? wasCorrect;
  final String correctAnswer;
  final String explanation;
  final int points;

  Map<String, dynamic> toJson() => _$QuizItemToJson(this);
}
