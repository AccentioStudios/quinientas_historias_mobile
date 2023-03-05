// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      link: json['link'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'link': instance.link,
      'slug': instance.slug,
    };
