// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tournament _$TournamentFromJson(Map<String, dynamic> json) => Tournament(
      title: json['title'] as String,
      initDate: DateTime.parse(json['initDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$TournamentToJson(Tournament instance) =>
    <String, dynamic>{
      'title': instance.title,
      'initDate': instance.initDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
