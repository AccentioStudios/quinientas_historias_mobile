// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_items.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizItem _$QuizItemFromJson(Map<String, dynamic> json) => QuizItem(
      id: json['id'] as int?,
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      answered: json['answered'] as int?,
      wasCorrect: json['wasCorrect'] as bool?,
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String,
      points: json['points'] as int,
      storyId: json['storyId'] as int?,
      liked: json['liked'] as bool?,
      story: json['story'] == null
          ? null
          : Story.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuizItemToJson(QuizItem instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'options': instance.options,
      'answered': instance.answered,
      'wasCorrect': instance.wasCorrect,
      'correctAnswer': instance.correctAnswer,
      'storyId': instance.storyId,
      'explanation': instance.explanation,
      'points': instance.points,
      'liked': instance.liked,
      'story': instance.story,
    };
