// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_management_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserManagementState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  dynamic get registeringUser => throw _privateConstructorUsedError;
  UserDto? get user => throw _privateConstructorUsedError;
  CroppedFile? get avatarMemory => throw _privateConstructorUsedError;
  HttpFailure? get error => throw _privateConstructorUsedError;
  Invite? get invite => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserManagementStateCopyWith<UserManagementState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserManagementStateCopyWith<$Res> {
  factory $UserManagementStateCopyWith(
          UserManagementState value, $Res Function(UserManagementState) then) =
      _$UserManagementStateCopyWithImpl<$Res, UserManagementState>;
  @useResult
  $Res call(
      {dynamic isLoading,
      dynamic registeringUser,
      UserDto? user,
      CroppedFile? avatarMemory,
      HttpFailure? error,
      Invite? invite});
}

/// @nodoc
class _$UserManagementStateCopyWithImpl<$Res, $Val extends UserManagementState>
    implements $UserManagementStateCopyWith<$Res> {
  _$UserManagementStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? registeringUser = freezed,
    Object? user = freezed,
    Object? avatarMemory = freezed,
    Object? error = freezed,
    Object? invite = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      registeringUser: freezed == registeringUser
          ? _value.registeringUser
          : registeringUser // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      avatarMemory: freezed == avatarMemory
          ? _value.avatarMemory
          : avatarMemory // ignore: cast_nullable_to_non_nullable
              as CroppedFile?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as HttpFailure?,
      invite: freezed == invite
          ? _value.invite
          : invite // ignore: cast_nullable_to_non_nullable
              as Invite?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserManagementStateCopyWith<$Res>
    implements $UserManagementStateCopyWith<$Res> {
  factory _$$_UserManagementStateCopyWith(_$_UserManagementState value,
          $Res Function(_$_UserManagementState) then) =
      __$$_UserManagementStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic isLoading,
      dynamic registeringUser,
      UserDto? user,
      CroppedFile? avatarMemory,
      HttpFailure? error,
      Invite? invite});
}

/// @nodoc
class __$$_UserManagementStateCopyWithImpl<$Res>
    extends _$UserManagementStateCopyWithImpl<$Res, _$_UserManagementState>
    implements _$$_UserManagementStateCopyWith<$Res> {
  __$$_UserManagementStateCopyWithImpl(_$_UserManagementState _value,
      $Res Function(_$_UserManagementState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? registeringUser = freezed,
    Object? user = freezed,
    Object? avatarMemory = freezed,
    Object? error = freezed,
    Object? invite = freezed,
  }) {
    return _then(_$_UserManagementState(
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
      registeringUser: freezed == registeringUser
          ? _value.registeringUser!
          : registeringUser,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserDto?,
      avatarMemory: freezed == avatarMemory
          ? _value.avatarMemory
          : avatarMemory // ignore: cast_nullable_to_non_nullable
              as CroppedFile?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as HttpFailure?,
      invite: freezed == invite
          ? _value.invite
          : invite // ignore: cast_nullable_to_non_nullable
              as Invite?,
    ));
  }
}

/// @nodoc

class _$_UserManagementState
    with DiagnosticableTreeMixin
    implements _UserManagementState {
  const _$_UserManagementState(
      {this.isLoading = false,
      this.registeringUser = false,
      this.user,
      this.avatarMemory,
      this.error,
      this.invite});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  @JsonKey()
  final dynamic registeringUser;
  @override
  final UserDto? user;
  @override
  final CroppedFile? avatarMemory;
  @override
  final HttpFailure? error;
  @override
  final Invite? invite;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserManagementState(isLoading: $isLoading, registeringUser: $registeringUser, user: $user, avatarMemory: $avatarMemory, error: $error, invite: $invite)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserManagementState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('registeringUser', registeringUser))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('avatarMemory', avatarMemory))
      ..add(DiagnosticsProperty('error', error))
      ..add(DiagnosticsProperty('invite', invite));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserManagementState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.registeringUser, registeringUser) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.avatarMemory, avatarMemory) ||
                other.avatarMemory == avatarMemory) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.invite, invite) || other.invite == invite));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(registeringUser),
      user,
      avatarMemory,
      error,
      invite);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserManagementStateCopyWith<_$_UserManagementState> get copyWith =>
      __$$_UserManagementStateCopyWithImpl<_$_UserManagementState>(
          this, _$identity);
}

abstract class _UserManagementState implements UserManagementState {
  const factory _UserManagementState(
      {final dynamic isLoading,
      final dynamic registeringUser,
      final UserDto? user,
      final CroppedFile? avatarMemory,
      final HttpFailure? error,
      final Invite? invite}) = _$_UserManagementState;

  @override
  dynamic get isLoading;
  @override
  dynamic get registeringUser;
  @override
  UserDto? get user;
  @override
  CroppedFile? get avatarMemory;
  @override
  HttpFailure? get error;
  @override
  Invite? get invite;
  @override
  @JsonKey(ignore: true)
  _$$_UserManagementStateCopyWith<_$_UserManagementState> get copyWith =>
      throw _privateConstructorUsedError;
}
