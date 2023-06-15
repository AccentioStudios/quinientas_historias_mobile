// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_items.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizItem _$QuizItemFromJson(Map<String, dynamic> json) => QuizItem(
      id: json['id'] as int,
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      answered: json['answered'] as int?,
      wasCorrect: json['wasCorrect'] as bool?,
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String,
      points: json['points'] as int,
    );

Map<String, dynamic> _$QuizItemToJson(QuizItem instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'options': instance.options,
      'answered': instance.answered,
      'wasCorrect': instance.wasCorrect,
      'correctAnswer': instance.correctAnswer,
      'explanation': instance.explanation,
      'points': instance.points,
    };
