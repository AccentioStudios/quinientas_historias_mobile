// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      id: json['id'] as String,
      title: json['title'] as String,
      readingTime: json['readingTime'] as String?,
      content: json['content'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      coverUrl: json['coverUrl'] as String?,
      coverColor: json['coverColor'] as String?,
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'readingTime': instance.readingTime,
      'content': instance.content,
      'author': instance.author,
      'coverUrl': instance.coverUrl,
      'coverColor': instance.coverColor,
    };
