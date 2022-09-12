part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool loading,
    HttpFailure? httpFailure,
    @Default('') String email,
    @Default('') String password,
    @Default('') String token,
    @Default('') String code,
  }) = _AuthState;
}
