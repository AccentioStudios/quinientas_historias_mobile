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
      _$SendInvitesStateCopyWithImpl<$Res>;
  $Res call(
      {dynamic isLoading,
      dynamic sendingInvite,
      List<Invite> invites,
      dynamic formValidationError,
      User? user});
}

/// @nodoc
class _$SendInvitesStateCopyWithImpl<$Res>
    implements $SendInvitesStateCopyWith<$Res> {
  _$SendInvitesStateCopyWithImpl(this._value, this._then);

  final SendInvitesState _value;
  // ignore: unused_field
  final $Res Function(SendInvitesState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? sendingInvite = freezed,
    Object? invites = freezed,
    Object? formValidationError = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      sendingInvite: sendingInvite == freezed
          ? _value.sendingInvite
          : sendingInvite // ignore: cast_nullable_to_non_nullable
              as dynamic,
      invites: invites == freezed
          ? _value.invites
          : invites // ignore: cast_nullable_to_non_nullable
              as List<Invite>,
      formValidationError: formValidationError == freezed
          ? _value.formValidationError
          : formValidationError // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
abstract class _$$_SendInvitesStateCopyWith<$Res>
    implements $SendInvitesStateCopyWith<$Res> {
  factory _$$_SendInvitesStateCopyWith(
          _$_SendInvitesState value, $Res Function(_$_SendInvitesState) then) =
      __$$_SendInvitesStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic isLoading,
      dynamic sendingInvite,
      List<Invite> invites,
      dynamic formValidationError,
      User? user});
}

/// @nodoc
class __$$_SendInvitesStateCopyWithImpl<$Res>
    extends _$SendInvitesStateCopyWithImpl<$Res>
    implements _$$_SendInvitesStateCopyWith<$Res> {
  __$$_SendInvitesStateCopyWithImpl(
      _$_SendInvitesState _value, $Res Function(_$_SendInvitesState) _then)
      : super(_value, (v) => _then(v as _$_SendInvitesState));

  @override
  _$_SendInvitesState get _value => super._value as _$_SendInvitesState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? sendingInvite = freezed,
    Object? invites = freezed,
    Object? formValidationError = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_SendInvitesState(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading,
      sendingInvite:
          sendingInvite == freezed ? _value.sendingInvite : sendingInvite,
      invites: invites == freezed
          ? _value._invites
          : invites // ignore: cast_nullable_to_non_nullable
              as List<Invite>,
      formValidationError: formValidationError == freezed
          ? _value.formValidationError
          : formValidationError,
      user: user == freezed
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
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(sendingInvite),
      const DeepCollectionEquality().hash(_invites),
      const DeepCollectionEquality().hash(formValidationError),
      const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
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
  dynamic get isLoading => throw _privateConstructorUsedError;
  @override
  dynamic get sendingInvite => throw _privateConstructorUsedError;
  @override
  List<Invite> get invites => throw _privateConstructorUsedError;
  @override
  dynamic get formValidationError => throw _privateConstructorUsedError;
  @override
  User? get user => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SendInvitesStateCopyWith<_$_SendInvitesState> get copyWith =>
      throw _privateConstructorUsedError;
}
