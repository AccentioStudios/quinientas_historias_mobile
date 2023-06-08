// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      json['count'] as int?,
      json['name'] as String,
      json['slug'] as String,
      json['taxonomy'] as String?,
      id: json['id'] as int,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'name': instance.name,
      'slug': instance.slug,
      'taxonomy': instance.taxonomy,
    };
