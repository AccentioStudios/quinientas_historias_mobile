part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool loading,
    AuthErrorModel? authError,
    @Default('') String email,
    @Default('') String password,
  }) = _AuthState;
}
