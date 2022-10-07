// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  dynamic get uploadingAvatar => throw _privateConstructorUsedError;
  RegisterUserRequest? get registerUser => throw _privateConstructorUsedError;
  HttpFailure? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserManagementStateCopyWith<UserManagementState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserManagementStateCopyWith<$Res> {
  factory $UserManagementStateCopyWith(
          UserManagementState value, $Res Function(UserManagementState) then) =
      _$UserManagementStateCopyWithImpl<$Res>;
  $Res call(
      {dynamic isLoading,
      dynamic uploadingAvatar,
      RegisterUserRequest? registerUser,
      HttpFailure? error});
}

/// @nodoc
class _$UserManagementStateCopyWithImpl<$Res>
    implements $UserManagementStateCopyWith<$Res> {
  _$UserManagementStateCopyWithImpl(this._value, this._then);

  final UserManagementState _value;
  // ignore: unused_field
  final $Res Function(UserManagementState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? uploadingAvatar = freezed,
    Object? registerUser = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      uploadingAvatar: uploadingAvatar == freezed
          ? _value.uploadingAvatar
          : uploadingAvatar // ignore: cast_nullable_to_non_nullable
              as dynamic,
      registerUser: registerUser == freezed
          ? _value.registerUser
          : registerUser // ignore: cast_nullable_to_non_nullable
              as RegisterUserRequest?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as HttpFailure?,
    ));
  }
}

/// @nodoc
abstract class _$$_UserManagementStateCopyWith<$Res>
    implements $UserManagementStateCopyWith<$Res> {
  factory _$$_UserManagementStateCopyWith(_$_UserManagementState value,
          $Res Function(_$_UserManagementState) then) =
      __$$_UserManagementStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic isLoading,
      dynamic uploadingAvatar,
      RegisterUserRequest? registerUser,
      HttpFailure? error});
}

/// @nodoc
class __$$_UserManagementStateCopyWithImpl<$Res>
    extends _$UserManagementStateCopyWithImpl<$Res>
    implements _$$_UserManagementStateCopyWith<$Res> {
  __$$_UserManagementStateCopyWithImpl(_$_UserManagementState _value,
      $Res Function(_$_UserManagementState) _then)
      : super(_value, (v) => _then(v as _$_UserManagementState));

  @override
  _$_UserManagementState get _value => super._value as _$_UserManagementState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? uploadingAvatar = freezed,
    Object? registerUser = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_UserManagementState(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading,
      uploadingAvatar:
          uploadingAvatar == freezed ? _value.uploadingAvatar : uploadingAvatar,
      registerUser: registerUser == freezed
          ? _value.registerUser
          : registerUser // ignore: cast_nullable_to_non_nullable
              as RegisterUserRequest?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as HttpFailure?,
    ));
  }
}

/// @nodoc

class _$_UserManagementState
    with DiagnosticableTreeMixin
    implements _UserManagementState {
  const _$_UserManagementState(
      {this.isLoading = false,
      this.uploadingAvatar = false,
      this.registerUser,
      this.error});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  @JsonKey()
  final dynamic uploadingAvatar;
  @override
  final RegisterUserRequest? registerUser;
  @override
  final HttpFailure? error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserManagementState(isLoading: $isLoading, uploadingAvatar: $uploadingAvatar, registerUser: $registerUser, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserManagementState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('uploadingAvatar', uploadingAvatar))
      ..add(DiagnosticsProperty('registerUser', registerUser))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserManagementState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.uploadingAvatar, uploadingAvatar) &&
            const DeepCollectionEquality()
                .equals(other.registerUser, registerUser) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(uploadingAvatar),
      const DeepCollectionEquality().hash(registerUser),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$_UserManagementStateCopyWith<_$_UserManagementState> get copyWith =>
      __$$_UserManagementStateCopyWithImpl<_$_UserManagementState>(
          this, _$identity);
}

abstract class _UserManagementState implements UserManagementState {
  const factory _UserManagementState(
      {final dynamic isLoading,
      final dynamic uploadingAvatar,
      final RegisterUserRequest? registerUser,
      final HttpFailure? error}) = _$_UserManagementState;

  @override
  dynamic get isLoading;
  @override
  dynamic get uploadingAvatar;
  @override
  RegisterUserRequest? get registerUser;
  @override
  HttpFailure? get error;
  @override
  @JsonKey(ignore: true)
  _$$_UserManagementStateCopyWith<_$_UserManagementState> get copyWith =>
      throw _privateConstructorUsedError;
}
