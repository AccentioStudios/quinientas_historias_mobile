// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'received_invites_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReceivedInvitesState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  Invite? get invite => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReceivedInvitesStateCopyWith<ReceivedInvitesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceivedInvitesStateCopyWith<$Res> {
  factory $ReceivedInvitesStateCopyWith(ReceivedInvitesState value,
          $Res Function(ReceivedInvitesState) then) =
      _$ReceivedInvitesStateCopyWithImpl<$Res>;
  $Res call({dynamic isLoading, Invite? invite, String code});
}

/// @nodoc
class _$ReceivedInvitesStateCopyWithImpl<$Res>
    implements $ReceivedInvitesStateCopyWith<$Res> {
  _$ReceivedInvitesStateCopyWithImpl(this._value, this._then);

  final ReceivedInvitesState _value;
  // ignore: unused_field
  final $Res Function(ReceivedInvitesState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? invite = freezed,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      invite: invite == freezed
          ? _value.invite
          : invite // ignore: cast_nullable_to_non_nullable
              as Invite?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ReceivedInvitesStateCopyWith<$Res>
    implements $ReceivedInvitesStateCopyWith<$Res> {
  factory _$$_ReceivedInvitesStateCopyWith(_$_ReceivedInvitesState value,
          $Res Function(_$_ReceivedInvitesState) then) =
      __$$_ReceivedInvitesStateCopyWithImpl<$Res>;
  @override
  $Res call({dynamic isLoading, Invite? invite, String code});
}

/// @nodoc
class __$$_ReceivedInvitesStateCopyWithImpl<$Res>
    extends _$ReceivedInvitesStateCopyWithImpl<$Res>
    implements _$$_ReceivedInvitesStateCopyWith<$Res> {
  __$$_ReceivedInvitesStateCopyWithImpl(_$_ReceivedInvitesState _value,
      $Res Function(_$_ReceivedInvitesState) _then)
      : super(_value, (v) => _then(v as _$_ReceivedInvitesState));

  @override
  _$_ReceivedInvitesState get _value => super._value as _$_ReceivedInvitesState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? invite = freezed,
    Object? code = freezed,
  }) {
    return _then(_$_ReceivedInvitesState(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading,
      invite: invite == freezed
          ? _value.invite
          : invite // ignore: cast_nullable_to_non_nullable
              as Invite?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ReceivedInvitesState implements _ReceivedInvitesState {
  const _$_ReceivedInvitesState(
      {this.isLoading = true, this.invite, this.code = ''});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final Invite? invite;
  @override
  @JsonKey()
  final String code;

  @override
  String toString() {
    return 'ReceivedInvitesState(isLoading: $isLoading, invite: $invite, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReceivedInvitesState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.invite, invite) &&
            const DeepCollectionEquality().equals(other.code, code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(invite),
      const DeepCollectionEquality().hash(code));

  @JsonKey(ignore: true)
  @override
  _$$_ReceivedInvitesStateCopyWith<_$_ReceivedInvitesState> get copyWith =>
      __$$_ReceivedInvitesStateCopyWithImpl<_$_ReceivedInvitesState>(
          this, _$identity);
}

abstract class _ReceivedInvitesState implements ReceivedInvitesState {
  const factory _ReceivedInvitesState(
      {final dynamic isLoading,
      final Invite? invite,
      final String code}) = _$_ReceivedInvitesState;

  @override
  dynamic get isLoading;
  @override
  Invite? get invite;
  @override
  String get code;
  @override
  @JsonKey(ignore: true)
  _$$_ReceivedInvitesStateCopyWith<_$_ReceivedInvitesState> get copyWith =>
      throw _privateConstructorUsedError;
}
