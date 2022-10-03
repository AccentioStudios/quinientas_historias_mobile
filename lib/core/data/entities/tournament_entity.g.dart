// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tournament _$TournamentFromJson(Map<String, dynamic> json) => Tournament(
      id: json['id'] as int,
      title: json['title'] as String?,
      active: json['active'] as int?,
      desc: json['desc'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
    );

Map<String, dynamic> _$TournamentToJson(Tournament instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'active': instance.active,
      'desc': instance.desc,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
    };
