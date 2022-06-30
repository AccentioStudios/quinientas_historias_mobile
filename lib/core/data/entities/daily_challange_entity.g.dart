// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_challange_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyChallange _$DailyChallangeFromJson(Map<String, dynamic> json) =>
    DailyChallange(
      count: json['count'] as int,
      readed: json['readed'] as int,
      challange: (json['challange'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : StoryProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyChallangeToJson(DailyChallange instance) =>
    <String, dynamic>{
      'count': instance.count,
      'readed': instance.readed,
      'challange': instance.challange,
    };
