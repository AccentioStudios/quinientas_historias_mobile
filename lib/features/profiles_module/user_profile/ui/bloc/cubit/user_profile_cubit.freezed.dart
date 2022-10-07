// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  User? get user => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserProfileStateCopyWith<UserProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileStateCopyWith<$Res> {
  factory $UserProfileStateCopyWith(
          UserProfileState value, $Res Function(UserProfileState) then) =
      _$UserProfileStateCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading, bool isMyProfile, HttpFailure? httpFailure, User? user});
}

/// @nodoc
class _$UserProfileStateCopyWithImpl<$Res>
    implements $UserProfileStateCopyWith<$Res> {
  _$UserProfileStateCopyWithImpl(this._value, this._then);

  final UserProfileState _value;
  // ignore: unused_field
  final $Res Function(UserProfileState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isMyProfile = freezed,
    Object? httpFailure = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMyProfile: isMyProfile == freezed
          ? _value.isMyProfile
          : isMyProfile // ignore: cast_nullable_to_non_nullable
              as bool,
      httpFailure: httpFailure == freezed
          ? _value.httpFailure
          : httpFailure // ignore: cast_nullable_to_non_nullable
              as HttpFailure?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
abstract class _$$_UserProfileStateCopyWith<$Res>
    implements $UserProfileStateCopyWith<$Res> {
  factory _$$_UserProfileStateCopyWith(
          _$_UserProfileState value, $Res Function(_$_UserProfileState) then) =
      __$$_UserProfileStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading, bool isMyProfile, HttpFailure? httpFailure, User? user});
}

/// @nodoc
class __$$_UserProfileStateCopyWithImpl<$Res>
    extends _$UserProfileStateCopyWithImpl<$Res>
    implements _$$_UserProfileStateCopyWith<$Res> {
  __$$_UserProfileStateCopyWithImpl(
      _$_UserProfileState _value, $Res Function(_$_UserProfileState) _then)
      : super(_value, (v) => _then(v as _$_UserProfileState));

  @override
  _$_UserProfileState get _value => super._value as _$_UserProfileState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isMyProfile = freezed,
    Object? httpFailure = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_UserProfileState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMyProfile: isMyProfile == freezed
          ? _value.isMyProfile
          : isMyProfile // ignore: cast_nullable_to_non_nullable
              as bool,
      httpFailure: httpFailure == freezed
          ? _value.httpFailure
          : httpFailure // ignore: cast_nullable_to_non_nullable
              as HttpFailure?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
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
  final User? user;

  @override
  String toString() {
    return 'UserProfileState(isLoading: $isLoading, isMyProfile: $isMyProfile, httpFailure: $httpFailure, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserProfileState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.isMyProfile, isMyProfile) &&
            const DeepCollectionEquality()
                .equals(other.httpFailure, httpFailure) &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isMyProfile),
      const DeepCollectionEquality().hash(httpFailure),
      const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$$_UserProfileStateCopyWith<_$_UserProfileState> get copyWith =>
      __$$_UserProfileStateCopyWithImpl<_$_UserProfileState>(this, _$identity);
}

abstract class _UserProfileState implements UserProfileState {
  const factory _UserProfileState(
      {final bool isLoading,
      final bool isMyProfile,
      final HttpFailure? httpFailure,
      final User? user}) = _$_UserProfileState;

  @override
  bool get isLoading;
  @override
  bool get isMyProfile;
  @override
  HttpFailure? get httpFailure;
  @override
  User? get user;
  @override
  @JsonKey(ignore: true)
  _$$_UserProfileStateCopyWith<_$_UserProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}
