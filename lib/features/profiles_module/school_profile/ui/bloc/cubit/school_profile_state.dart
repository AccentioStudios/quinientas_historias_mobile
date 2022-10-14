part of 'school_profile_cubit.dart';

@freezed
class SchoolProfileState with _$SchoolProfileState {
  const factory SchoolProfileState({
    @Default(false) isLoading,
    School? school,
  }) = _SchoolProfileState;
}
