// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$ReceivedInvitesStateCopyWithImpl<$Res, ReceivedInvitesState>;
  @useResult
  $Res call({dynamic isLoading, Invite? invite, String code});
}

/// @nodoc
class _$ReceivedInvitesStateCopyWithImpl<$Res,
        $Val extends ReceivedInvitesState>
    implements $ReceivedInvitesStateCopyWith<$Res> {
  _$ReceivedInvitesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? invite = freezed,
    Object? code = null,
  }) {
    return _then(_value.copyWith(
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      invite: freezed == invite
          ? _value.invite
          : invite // ignore: cast_nullable_to_non_nullable
              as Invite?,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReceivedInvitesStateCopyWith<$Res>
    implements $ReceivedInvitesStateCopyWith<$Res> {
  factory _$$_ReceivedInvitesStateCopyWith(_$_ReceivedInvitesState value,
          $Res Function(_$_ReceivedInvitesState) then) =
      __$$_ReceivedInvitesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic isLoading, Invite? invite, String code});
}

/// @nodoc
class __$$_ReceivedInvitesStateCopyWithImpl<$Res>
    extends _$ReceivedInvitesStateCopyWithImpl<$Res, _$_ReceivedInvitesState>
    implements _$$_ReceivedInvitesStateCopyWith<$Res> {
  __$$_ReceivedInvitesStateCopyWithImpl(_$_ReceivedInvitesState _value,
      $Res Function(_$_ReceivedInvitesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? invite = freezed,
    Object? code = null,
  }) {
    return _then(_$_ReceivedInvitesState(
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
      invite: freezed == invite
          ? _value.invite
          : invite // ignore: cast_nullable_to_non_nullable
              as Invite?,
      code: null == code
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
            (identical(other.invite, invite) || other.invite == invite) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(isLoading), invite, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
