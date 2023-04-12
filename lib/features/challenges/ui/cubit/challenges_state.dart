part of 'challenges_cubit.dart';

@freezed
class ChallengesState with _$ChallengesState {
  const factory ChallengesState({
    @Default(false) bool loading,
  }) = _ChallengesState;
}
