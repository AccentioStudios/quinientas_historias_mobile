// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] == null
          ? null
          : User.fromJson(json['author'] as Map<String, dynamic>),
      coverUrl: json['coverUrl'] as String?,
      coverColor: json['coverColor'] as String?,
      content: json['content'] as String?,
      favorited: json['favorited'] as bool?,
      readingTime: json['readingTime'] == null
          ? null
          : ReadTimeResults.fromJson(
              json['readingTime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'coverUrl': instance.coverUrl,
      'coverColor': instance.coverColor,
      'content': instance.content,
      'favorited': instance.favorited,
      'readingTime': instance.readingTime,
    };

ReadTimeResults _$ReadTimeResultsFromJson(Map<String, dynamic> json) =>
    ReadTimeResults(
      text: json['text'] as String?,
      minutes: (json['minutes'] as num).toDouble(),
    );

Map<String, dynamic> _$ReadTimeResultsToJson(ReadTimeResults instance) =>
    <String, dynamic>{
      'text': instance.text,
      'minutes': instance.minutes,
    };
