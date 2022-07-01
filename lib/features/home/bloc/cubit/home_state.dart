part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    User? user,
    DailyChallenge? dailyChallenge,
    @Default(false) bool loading,
  }) = _HomeState;
}
