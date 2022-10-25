// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'send_invites_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SendInvitesState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  dynamic get sendingInvite => throw _privateConstructorUsedError;
  List<Invite> get invites => throw _privateConstructorUsedError;
  dynamic get formValidationError => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SendInvitesStateCopyWith<SendInvitesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendInvitesStateCopyWith<$Res> {
  factory $SendInvitesStateCopyWith(
          SendInvitesState value, $Res Function(SendInvitesState) then) =
      _$SendInvitesStateCopyWithImpl<$Res, SendInvitesState>;
  @useResult
  $Res call(
      {dynamic isLoading,
      dynamic sendingInvite,
      List<Invite> invites,
      dynamic formValidationError,
      User? user});
}

/// @nodoc
class _$SendInvitesStateCopyWithImpl<$Res, $Val extends SendInvitesState>
    implements $SendInvitesStateCopyWith<$Res> {
  _$SendInvitesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? sendingInvite = null,
    Object? invites = null,
    Object? formValidationError = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      sendingInvite: null == sendingInvite
          ? _value.sendingInvite
          : sendingInvite // ignore: cast_nullable_to_non_nullable
              as dynamic,
      invites: null == invites
          ? _value.invites
          : invites // ignore: cast_nullable_to_non_nullable
              as List<Invite>,
      formValidationError: null == formValidationError
          ? _value.formValidationError
          : formValidationError // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SendInvitesStateCopyWith<$Res>
    implements $SendInvitesStateCopyWith<$Res> {
  factory _$$_SendInvitesStateCopyWith(
          _$_SendInvitesState value, $Res Function(_$_SendInvitesState) then) =
      __$$_SendInvitesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic isLoading,
      dynamic sendingInvite,
      List<Invite> invites,
      dynamic formValidationError,
      User? user});
}

/// @nodoc
class __$$_SendInvitesStateCopyWithImpl<$Res>
    extends _$SendInvitesStateCopyWithImpl<$Res, _$_SendInvitesState>
    implements _$$_SendInvitesStateCopyWith<$Res> {
  __$$_SendInvitesStateCopyWithImpl(
      _$_SendInvitesState _value, $Res Function(_$_SendInvitesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? sendingInvite = null,
    Object? invites = null,
    Object? formValidationError = null,
    Object? user = freezed,
  }) {
    return _then(_$_SendInvitesState(
      isLoading: null == isLoading ? _value.isLoading : isLoading,
      sendingInvite:
          null == sendingInvite ? _value.sendingInvite : sendingInvite,
      invites: null == invites
          ? _value._invites
          : invites // ignore: cast_nullable_to_non_nullable
              as List<Invite>,
      formValidationError: null == formValidationError
          ? _value.formValidationError
          : formValidationError,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc

class _$_SendInvitesState implements _SendInvitesState {
  const _$_SendInvitesState(
      {this.isLoading = true,
      this.sendingInvite = false,
      final List<Invite> invites = initInvites,
      this.formValidationError = false,
      this.user})
      : _invites = invites;

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  @JsonKey()
  final dynamic sendingInvite;
  final List<Invite> _invites;
  @override
  @JsonKey()
  List<Invite> get invites {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_invites);
  }

  @override
  @JsonKey()
  final dynamic formValidationError;
  @override
  final User? user;

  @override
  String toString() {
    return 'SendInvitesState(isLoading: $isLoading, sendingInvite: $sendingInvite, invites: $invites, formValidationError: $formValidationError, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SendInvitesState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.sendingInvite, sendingInvite) &&
            const DeepCollectionEquality().equals(other._invites, _invites) &&
            const DeepCollectionEquality()
                .equals(other.formValidationError, formValidationError) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(sendingInvite),
      const DeepCollectionEquality().hash(_invites),
      const DeepCollectionEquality().hash(formValidationError),
      user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SendInvitesStateCopyWith<_$_SendInvitesState> get copyWith =>
      __$$_SendInvitesStateCopyWithImpl<_$_SendInvitesState>(this, _$identity);
}

abstract class _SendInvitesState implements SendInvitesState {
  const factory _SendInvitesState(
      {final dynamic isLoading,
      final dynamic sendingInvite,
      final List<Invite> invites,
      final dynamic formValidationError,
      final User? user}) = _$_SendInvitesState;

  @override
  dynamic get isLoading;
  @override
  dynamic get sendingInvite;
  @override
  List<Invite> get invites;
  @override
  dynamic get formValidationError;
  @override
  User? get user;
  @override
  @JsonKey(ignore: true)
  _$$_SendInvitesStateCopyWith<_$_SendInvitesState> get copyWith =>
      throw _privateConstructorUsedError;
}
