part of 'school_profile_cubit.dart';

@freezed
class SchoolProfileState with _$SchoolProfileState {
  const factory SchoolProfileState({
    @Default(false) isLoading,
    SchoolProfile? data,
  }) = _SchoolProfileState;
}
