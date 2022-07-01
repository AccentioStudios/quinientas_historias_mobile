import 'package:freezed_annotation/freezed_annotation.dart';

import 'story_progress_entity.dart';

part 'daily_challenge_entity.g.dart';

@JsonSerializable()
class DailyChallenge {
  DailyChallenge({
    required this.count,
    required this.readed,
    this.challenge,
  });

  factory DailyChallenge.fromJson(Map<String, dynamic> json) =>
      _$DailyChallengeFromJson(json);

  final int count;
  final int readed;
  final List<StoryProgress>? challenge;

  Map<String, dynamic> toJson() => _$DailyChallengeToJson(this);
}
