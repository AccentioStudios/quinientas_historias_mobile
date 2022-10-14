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
      _$GroupManagementStateCopyWithImpl<$Res>;
  $Res call(
      {dynamic isLoading,
      GroupManagementRequest? groupManagementRequest,
      CroppedFile? avatarMemory,
      HttpFailure? error});
}

/// @nodoc
class _$GroupManagementStateCopyWithImpl<$Res>
    implements $GroupManagementStateCopyWith<$Res> {
  _$GroupManagementStateCopyWithImpl(this._value, this._then);

  final GroupManagementState _value;
  // ignore: unused_field
  final $Res Function(GroupManagementState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? groupManagementRequest = freezed,
    Object? avatarMemory = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      groupManagementRequest: groupManagementRequest == freezed
          ? _value.groupManagementRequest
          : groupManagementRequest // ignore: cast_nullable_to_non_nullable
              as GroupManagementRequest?,
      avatarMemory: avatarMemory == freezed
          ? _value.avatarMemory
          : avatarMemory // ignore: cast_nullable_to_non_nullable
              as CroppedFile?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as HttpFailure?,
    ));
  }
}

/// @nodoc
abstract class _$$_GroupManagementStateCopyWith<$Res>
    implements $GroupManagementStateCopyWith<$Res> {
  factory _$$_GroupManagementStateCopyWith(_$_GroupManagementState value,
          $Res Function(_$_GroupManagementState) then) =
      __$$_GroupManagementStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic isLoading,
      GroupManagementRequest? groupManagementRequest,
      CroppedFile? avatarMemory,
      HttpFailure? error});
}

/// @nodoc
class __$$_GroupManagementStateCopyWithImpl<$Res>
    extends _$GroupManagementStateCopyWithImpl<$Res>
    implements _$$_GroupManagementStateCopyWith<$Res> {
  __$$_GroupManagementStateCopyWithImpl(_$_GroupManagementState _value,
      $Res Function(_$_GroupManagementState) _then)
      : super(_value, (v) => _then(v as _$_GroupManagementState));

  @override
  _$_GroupManagementState get _value => super._value as _$_GroupManagementState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? groupManagementRequest = freezed,
    Object? avatarMemory = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_GroupManagementState(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading,
      groupManagementRequest: groupManagementRequest == freezed
          ? _value.groupManagementRequest
          : groupManagementRequest // ignore: cast_nullable_to_non_nullable
              as GroupManagementRequest?,
      avatarMemory: avatarMemory == freezed
          ? _value.avatarMemory
          : avatarMemory // ignore: cast_nullable_to_non_nullable
              as CroppedFile?,
      error: error == freezed
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
            const DeepCollectionEquality()
                .equals(other.groupManagementRequest, groupManagementRequest) &&
            const DeepCollectionEquality()
                .equals(other.avatarMemory, avatarMemory) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(groupManagementRequest),
      const DeepCollectionEquality().hash(avatarMemory),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
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
