part of 'landing_cubit.dart';

@freezed
class LandingState with _$LandingState {
  const factory LandingState({
    @Default(true) loading,
  }) = _LandingState;
}
