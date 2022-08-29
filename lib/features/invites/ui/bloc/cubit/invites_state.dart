part of 'invites_cubit.dart';

@freezed
class InvitesState with _$InvitesState {
  const factory InvitesState({
    @Default(false) isLoading,
    User? user,
  }) = _InvitesState;
}
