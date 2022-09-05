// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'division_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Division _$DivisionFromJson(Map<String, dynamic> json) => Division(
      name: json['name'] as String,
      level: json['level'] as int,
      scoreToAchieve: json['scoreToAchieve'] as int,
    );

Map<String, dynamic> _$DivisionToJson(Division instance) => <String, dynamic>{
      'name': instance.name,
      'level': instance.level,
      'scoreToAchieve': instance.scoreToAchieve,
    };
