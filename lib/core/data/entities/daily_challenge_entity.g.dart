// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_challenge_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyChallenge _$DailyChallengeFromJson(Map<String, dynamic> json) =>
    DailyChallenge(
      count: json['count'] as int,
      readed: json['readed'] as int,
      challenge: (json['challenge'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : StoryProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyChallengeToJson(DailyChallenge instance) =>
    <String, dynamic>{
      'count': instance.count,
      'readed': instance.readed,
      'challenge': instance.challenge,
    };
