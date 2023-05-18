part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    Dashboard? dashboard,
    @Default(false) bool loading,
    Object? error,
  }) = _HomeState;
}
