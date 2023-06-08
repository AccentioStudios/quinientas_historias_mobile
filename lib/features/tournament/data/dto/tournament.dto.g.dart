// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentDto _$TournamentDtoFromJson(Map<String, dynamic> json) =>
    TournamentDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      startAt: json['startAt'] == null
          ? null
          : DateTime.parse(json['startAt'] as String),
      endsAt: json['endsAt'] == null
          ? null
          : DateTime.parse(json['endsAt'] as String),
      tagId: json['tagId'] as int?,
      coverUrl: json['coverUrl'] as String?,
    );

Map<String, dynamic> _$TournamentDtoToJson(TournamentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'startAt': instance.startAt?.toIso8601String(),
      'endsAt': instance.endsAt?.toIso8601String(),
      'tagId': instance.tagId,
      'coverUrl': instance.coverUrl,
    };
