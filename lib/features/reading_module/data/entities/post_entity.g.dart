// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as String),
      coverUrl: json['coverUrl'] as String?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'author': instance.author,
      'coverUrl': instance.coverUrl,
    };
