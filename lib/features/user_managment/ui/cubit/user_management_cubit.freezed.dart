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
  UserManagementRequest? get userManagementRequest =>
      throw _privateConstructorUsedError;
  CroppedFile? get avatarMemory => throw _privateConstructorUsedError;
  HttpFailure? get error => throw _privateConstructorUsedError;

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
      UserManagementRequest? userManagementRequest,
      CroppedFile? avatarMemory,
      HttpFailure? error});
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
    Object? userManagementRequest = freezed,
    Object? avatarMemory = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userManagementRequest: freezed == userManagementRequest
          ? _value.userManagementRequest
          : userManagementRequest // ignore: cast_nullable_to_non_nullable
              as UserManagementRequest?,
      avatarMemory: freezed == avatarMemory
          ? _value.avatarMemory
          : avatarMemory // ignore: cast_nullable_to_non_nullable
              as CroppedFile?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as HttpFailure?,
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
      UserManagementRequest? userManagementRequest,
      CroppedFile? avatarMemory,
      HttpFailure? error});
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
    Object? userManagementRequest = freezed,
    Object? avatarMemory = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_UserManagementState(
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
      userManagementRequest: freezed == userManagementRequest
          ? _value.userManagementRequest
          : userManagementRequest // ignore: cast_nullable_to_non_nullable
              as UserManagementRequest?,
      avatarMemory: freezed == avatarMemory
          ? _value.avatarMemory
          : avatarMemory // ignore: cast_nullable_to_non_nullable
              as CroppedFile?,
      error: freezed == error
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
      this.userManagementRequest,
      this.avatarMemory,
      this.error});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final UserManagementRequest? userManagementRequest;
  @override
  final CroppedFile? avatarMemory;
  @override
  final HttpFailure? error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserManagementState(isLoading: $isLoading, userManagementRequest: $userManagementRequest, avatarMemory: $avatarMemory, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserManagementState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('userManagementRequest', userManagementRequest))
      ..add(DiagnosticsProperty('avatarMemory', avatarMemory))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserManagementState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            (identical(other.userManagementRequest, userManagementRequest) ||
                other.userManagementRequest == userManagementRequest) &&
            (identical(other.avatarMemory, avatarMemory) ||
                other.avatarMemory == avatarMemory) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      userManagementRequest,
      avatarMemory,
      error);

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
      final UserManagementRequest? userManagementRequest,
      final CroppedFile? avatarMemory,
      final HttpFailure? error}) = _$_UserManagementState;

  @override
  dynamic get isLoading;
  @override
  UserManagementRequest? get userManagementRequest;
  @override
  CroppedFile? get avatarMemory;
  @override
  HttpFailure? get error;
  @override
  @JsonKey(ignore: true)
  _$$_UserManagementStateCopyWith<_$_UserManagementState> get copyWith =>
      throw _privateConstructorUsedError;
}
