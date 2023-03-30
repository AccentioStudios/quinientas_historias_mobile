part of 'school_profile_cubit.dart';

@freezed
class SchoolProfileState with _$SchoolProfileState {
  const factory SchoolProfileState({
    @Default(false) isLoading,
    SchoolProfileDto? school,
  }) = _SchoolProfileState;
}
