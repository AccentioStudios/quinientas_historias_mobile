import 'package:freezed_annotation/freezed_annotation.dart';

import 'story_progress_entity.dart';

part 'daily_challenge_entity.g.dart';

const List<StoryProgress> defaultValue = [];

@JsonSerializable()
class DailyChallenge {
  DailyChallenge({
    this.count = 0,
    this.readed = 0,
    this.challenge = defaultValue,
    this.hasOldChallengeIncomplete = false,
    this.diceCount,
  });

  factory DailyChallenge.fromJson(Map<String, dynamic> json) =>
      _$DailyChallengeFromJson(json);

  final int count;
  final int readed;
  final List<StoryProgress> challenge;
  final bool hasOldChallengeIncomplete;
  final int? diceCount;

  Map<String, dynamic> toJson() => _$DailyChallengeToJson(this);
}
