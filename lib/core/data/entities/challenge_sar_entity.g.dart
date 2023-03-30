// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_sar_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengeSar _$ChallengeSarFromJson(Map<String, dynamic> json) => ChallengeSar(
      name: json['name'] as String,
      url: json['url'] as String,
      probability: (json['probability'] as num).toDouble(),
      required: json['required'] as bool,
      active: json['active'] as bool,
      tournaments:
          (json['tournaments'] as List<dynamic>).map((e) => e as int).toList(),
      params:
          (json['params'] as List<dynamic>).map((e) => e as String).toList(),
      sessionToken: json['sessionToken'] as String?,
    );

Map<String, dynamic> _$ChallengeSarToJson(ChallengeSar instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'probability': instance.probability,
      'required': instance.required,
      'active': instance.active,
      'tournaments': instance.tournaments,
      'params': instance.params,
      'sessionToken': instance.sessionToken,
    };
