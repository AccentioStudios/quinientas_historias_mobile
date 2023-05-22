// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_sar_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengeSar _$ChallengeSarFromJson(Map<String, dynamic> json) => ChallengeSar(
      id: json['id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      probability: (json['probability'] as num).toDouble(),
      required: json['required'] as bool,
      tournaments:
          (json['tournaments'] as List<dynamic>).map((e) => e as int).toList(),
      steps: json['steps'] as int?,
      params:
          (json['params'] as List<dynamic>).map((e) => e as String).toList(),
      triggers:
          (json['triggers'] as List<dynamic>).map((e) => e as String).toList(),
      weight: (json['weight'] as num).toDouble(),
      active: json['active'] as bool,
      points: json['points'] as int?,
    );

Map<String, dynamic> _$ChallengeSarToJson(ChallengeSar instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'probability': instance.probability,
      'weight': instance.weight,
      'required': instance.required,
      'active': instance.active,
      'triggers': instance.triggers,
      'tournaments': instance.tournaments,
      'steps': instance.steps,
      'params': instance.params,
      'points': instance.points,
    };
