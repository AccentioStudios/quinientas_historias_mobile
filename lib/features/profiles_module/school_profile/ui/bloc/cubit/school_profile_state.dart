part of 'school_profile_cubit.dart';

@freezed
class SchoolProfileState with _$SchoolProfileState {
  const factory SchoolProfileState({
    @Default(false) isLoading,
    @Default(false) canEdit,
    School? data,
    User? user,
  }) = _SchoolProfileState;
}
