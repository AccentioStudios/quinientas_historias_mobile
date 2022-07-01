part of 'daily_challenge_cubit.dart';

@freezed
class DailyChallengeState with _$DailyChallengeState {
  const factory DailyChallengeState({
    @Default(false) bool loading,
    DailyChallenge? data,
  }) = _ReadingChallangeState;
}
