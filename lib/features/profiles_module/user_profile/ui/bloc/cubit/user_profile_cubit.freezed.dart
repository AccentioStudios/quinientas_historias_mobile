// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserProfileState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isMyProfile => throw _privateConstructorUsedError;
  HttpFailure? get httpFailure => throw _privateConstructorUsedError;
  UserProfileDto? get user => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserProfileStateCopyWith<UserProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileStateCopyWith<$Res> {
  factory $UserProfileStateCopyWith(
          UserProfileState value, $Res Function(UserProfileState) then) =
      _$UserProfileStateCopyWithImpl<$Res, UserProfileState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isMyProfile,
      HttpFailure? httpFailure,
      UserProfileDto? user});
}

/// @nodoc
class _$UserProfileStateCopyWithImpl<$Res, $Val extends UserProfileState>
    implements $UserProfileStateCopyWith<$Res> {
  _$UserProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isMyProfile = null,
    Object? httpFailure = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMyProfile: null == isMyProfile
          ? _value.isMyProfile
          : isMyProfile // ignore: cast_nullable_to_non_nullable
              as bool,
      httpFailure: freezed == httpFailure
          ? _value.httpFailure
          : httpFailure // ignore: cast_nullable_to_non_nullable
              as HttpFailure?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserProfileDto?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserProfileStateCopyWith<$Res>
    implements $UserProfileStateCopyWith<$Res> {
  factory _$$_UserProfileStateCopyWith(
          _$_UserProfileState value, $Res Function(_$_UserProfileState) then) =
      __$$_UserProfileStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isMyProfile,
      HttpFailure? httpFailure,
      UserProfileDto? user});
}

/// @nodoc
class __$$_UserProfileStateCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res, _$_UserProfileState>
    implements _$$_UserProfileStateCopyWith<$Res> {
  __$$_UserProfileStateCopyWithImpl(
      _$_UserProfileState _value, $Res Function(_$_UserProfileState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isMyProfile = null,
    Object? httpFailure = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_UserProfileState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMyProfile: null == isMyProfile
          ? _value.isMyProfile
          : isMyProfile // ignore: cast_nullable_to_non_nullable
              as bool,
      httpFailure: freezed == httpFailure
          ? _value.httpFailure
          : httpFailure // ignore: cast_nullable_to_non_nullable
              as HttpFailure?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserProfileDto?,
    ));
  }
}

/// @nodoc

class _$_UserProfileState implements _UserProfileState {
  const _$_UserProfileState(
      {this.isLoading = true,
      this.isMyProfile = false,
      this.httpFailure = null,
      this.user});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isMyProfile;
  @override
  @JsonKey()
  final HttpFailure? httpFailure;
  @override
  final UserProfileDto? user;

  @override
  String toString() {
    return 'UserProfileState(isLoading: $isLoading, isMyProfile: $isMyProfile, httpFailure: $httpFailure, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserProfileState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isMyProfile, isMyProfile) ||
                other.isMyProfile == isMyProfile) &&
            (identical(other.httpFailure, httpFailure) ||
                other.httpFailure == httpFailure) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, isMyProfile, httpFailure, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserProfileStateCopyWith<_$_UserProfileState> get copyWith =>
      __$$_UserProfileStateCopyWithImpl<_$_UserProfileState>(this, _$identity);
}

abstract class _UserProfileState implements UserProfileState {
  const factory _UserProfileState(
      {final bool isLoading,
      final bool isMyProfile,
      final HttpFailure? httpFailure,
      final UserProfileDto? user}) = _$_UserProfileState;

  @override
  bool get isLoading;
  @override
  bool get isMyProfile;
  @override
  HttpFailure? get httpFailure;
  @override
  UserProfileDto? get user;
  @override
  @JsonKey(ignore: true)
  _$$_UserProfileStateCopyWith<_$_UserProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}
