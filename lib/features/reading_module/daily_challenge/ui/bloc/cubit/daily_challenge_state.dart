part of 'daily_challenge_cubit.dart';

@freezed
class DailyChallengeState with _$DailyChallengeState {
  const factory DailyChallengeState(
      {@Default(false) bool loading,
      required DailyChallenge data,
      Story? storyHovered}) = _ReadingChallangeState;
}
