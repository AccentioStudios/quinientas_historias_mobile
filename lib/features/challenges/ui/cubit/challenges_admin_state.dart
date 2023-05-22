part of 'challenges_admin_cubit.dart';

@freezed
class ChallengesAdminState with _$ChallengesAdminState {
  const factory ChallengesAdminState({
    @Default(false) bool loading,
    @Default(false) bool registeringChallenge,
    HttpFailure? error,
    ChallengeSar? challenge,
    @Default(false) bool checkingHealth,
    SarHealthResponseDto? health,
    Object? errorHealth,
  }) = _ChallengesAdminState;
}
