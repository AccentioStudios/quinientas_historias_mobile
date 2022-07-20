// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_challenge_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyChallenge _$DailyChallengeFromJson(Map<String, dynamic> json) =>
    DailyChallenge(
      count: json['count'] as int? ?? 0,
      readed: json['readed'] as int? ?? 0,
      challenge: (json['challenge'] as List<dynamic>?)
              ?.map((e) => StoryProgress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          defaultValue,
      hasOldChallengeIncomplete:
          json['hasOldChallengeIncomplete'] as bool? ?? false,
    );

Map<String, dynamic> _$DailyChallengeToJson(DailyChallenge instance) =>
    <String, dynamic>{
      'count': instance.count,
      'readed': instance.readed,
      'challenge': instance.challenge,
      'hasOldChallengeIncomplete': instance.hasOldChallengeIncomplete,
    };
