// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_sar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengeSarEvent _$ChallengeSarEventFromJson(Map<String, dynamic> json) =>
    ChallengeSarEvent(
      trigger: $enumDecode(_$ChallengeSarTriggersEnumMap, json['trigger']),
      userId: json['userId'] as int,
      storyId: json['storyId'] as int?,
      now: DateTime.parse(json['now'] as String),
    );

Map<String, dynamic> _$ChallengeSarEventToJson(ChallengeSarEvent instance) =>
    <String, dynamic>{
      'trigger': _$ChallengeSarTriggersEnumMap[instance.trigger]!,
      'userId': instance.userId,
      'storyId': instance.storyId,
      'now': instance.now.toIso8601String(),
    };

const _$ChallengeSarTriggersEnumMap = {
  ChallengeSarTriggers.storyEnded: 'story-ended',
  ChallengeSarTriggers.storyInit: 'story-init',
  ChallengeSarTriggers.firstSessionOfDay: 'first-session-of-day',
};
