// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'group_management_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GroupManagementState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  GroupManagementRequest? get groupManagementRequest =>
      throw _privateConstructorUsedError;
  CroppedFile? get avatarMemory => throw _privateConstructorUsedError;
  HttpFailure? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GroupManagementStateCopyWith<GroupManagementState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupManagementStateCopyWith<$Res> {
  factory $GroupManagementStateCopyWith(GroupManagementState value,
          $Res Function(GroupManagementState) then) =
      _$GroupManagementStateCopyWithImpl<$Res, GroupManagementState>;
  @useResult
  $Res call(
      {dynamic isLoading,
      GroupManagementRequest? groupManagementRequest,
      CroppedFile? avatarMemory,
      HttpFailure? error});
}

/// @nodoc
class _$GroupManagementStateCopyWithImpl<$Res,
        $Val extends GroupManagementState>
    implements $GroupManagementStateCopyWith<$Res> {
  _$GroupManagementStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? groupManagementRequest = freezed,
    Object? avatarMemory = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      groupManagementRequest: freezed == groupManagementRequest
          ? _value.groupManagementRequest
          : groupManagementRequest // ignore: cast_nullable_to_non_nullable
              as GroupManagementRequest?,
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
abstract class _$$_GroupManagementStateCopyWith<$Res>
    implements $GroupManagementStateCopyWith<$Res> {
  factory _$$_GroupManagementStateCopyWith(_$_GroupManagementState value,
          $Res Function(_$_GroupManagementState) then) =
      __$$_GroupManagementStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic isLoading,
      GroupManagementRequest? groupManagementRequest,
      CroppedFile? avatarMemory,
      HttpFailure? error});
}

/// @nodoc
class __$$_GroupManagementStateCopyWithImpl<$Res>
    extends _$GroupManagementStateCopyWithImpl<$Res, _$_GroupManagementState>
    implements _$$_GroupManagementStateCopyWith<$Res> {
  __$$_GroupManagementStateCopyWithImpl(_$_GroupManagementState _value,
      $Res Function(_$_GroupManagementState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? groupManagementRequest = freezed,
    Object? avatarMemory = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_GroupManagementState(
      isLoading: null == isLoading ? _value.isLoading : isLoading,
      groupManagementRequest: freezed == groupManagementRequest
          ? _value.groupManagementRequest
          : groupManagementRequest // ignore: cast_nullable_to_non_nullable
              as GroupManagementRequest?,
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

class _$_GroupManagementState
    with DiagnosticableTreeMixin
    implements _GroupManagementState {
  const _$_GroupManagementState(
      {this.isLoading = false,
      this.groupManagementRequest,
      this.avatarMemory,
      this.error});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final GroupManagementRequest? groupManagementRequest;
  @override
  final CroppedFile? avatarMemory;
  @override
  final HttpFailure? error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GroupManagementState(isLoading: $isLoading, groupManagementRequest: $groupManagementRequest, avatarMemory: $avatarMemory, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GroupManagementState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(
          DiagnosticsProperty('groupManagementRequest', groupManagementRequest))
      ..add(DiagnosticsProperty('avatarMemory', avatarMemory))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupManagementState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            (identical(other.groupManagementRequest, groupManagementRequest) ||
                other.groupManagementRequest == groupManagementRequest) &&
            (identical(other.avatarMemory, avatarMemory) ||
                other.avatarMemory == avatarMemory) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      groupManagementRequest,
      avatarMemory,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupManagementStateCopyWith<_$_GroupManagementState> get copyWith =>
      __$$_GroupManagementStateCopyWithImpl<_$_GroupManagementState>(
          this, _$identity);
}

abstract class _GroupManagementState implements GroupManagementState {
  const factory _GroupManagementState(
      {final dynamic isLoading,
      final GroupManagementRequest? groupManagementRequest,
      final CroppedFile? avatarMemory,
      final HttpFailure? error}) = _$_GroupManagementState;

  @override
  dynamic get isLoading;
  @override
  GroupManagementRequest? get groupManagementRequest;
  @override
  CroppedFile? get avatarMemory;
  @override
  HttpFailure? get error;
  @override
  @JsonKey(ignore: true)
  _$$_GroupManagementStateCopyWith<_$_GroupManagementState> get copyWith =>
      throw _privateConstructorUsedError;
}
