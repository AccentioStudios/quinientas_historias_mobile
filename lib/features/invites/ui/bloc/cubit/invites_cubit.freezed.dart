// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'invites_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InvitesState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  dynamic get sendingInvite => throw _privateConstructorUsedError;
  List<Invite> get invites => throw _privateConstructorUsedError;
  dynamic get emailForm => throw _privateConstructorUsedError;
  dynamic get formValidationError => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InvitesStateCopyWith<InvitesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitesStateCopyWith<$Res> {
  factory $InvitesStateCopyWith(
          InvitesState value, $Res Function(InvitesState) then) =
      _$InvitesStateCopyWithImpl<$Res>;
  $Res call(
      {dynamic isLoading,
      dynamic sendingInvite,
      List<Invite> invites,
      dynamic emailForm,
      dynamic formValidationError,
      User? user});
}

/// @nodoc
class _$InvitesStateCopyWithImpl<$Res> implements $InvitesStateCopyWith<$Res> {
  _$InvitesStateCopyWithImpl(this._value, this._then);

  final InvitesState _value;
  // ignore: unused_field
  final $Res Function(InvitesState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? sendingInvite = freezed,
    Object? invites = freezed,
    Object? emailForm = freezed,
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
      emailForm: emailForm == freezed
          ? _value.emailForm
          : emailForm // ignore: cast_nullable_to_non_nullable
              as dynamic,
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
abstract class _$$_InvitesStateCopyWith<$Res>
    implements $InvitesStateCopyWith<$Res> {
  factory _$$_InvitesStateCopyWith(
          _$_InvitesState value, $Res Function(_$_InvitesState) then) =
      __$$_InvitesStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic isLoading,
      dynamic sendingInvite,
      List<Invite> invites,
      dynamic emailForm,
      dynamic formValidationError,
      User? user});
}

/// @nodoc
class __$$_InvitesStateCopyWithImpl<$Res>
    extends _$InvitesStateCopyWithImpl<$Res>
    implements _$$_InvitesStateCopyWith<$Res> {
  __$$_InvitesStateCopyWithImpl(
      _$_InvitesState _value, $Res Function(_$_InvitesState) _then)
      : super(_value, (v) => _then(v as _$_InvitesState));

  @override
  _$_InvitesState get _value => super._value as _$_InvitesState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? sendingInvite = freezed,
    Object? invites = freezed,
    Object? emailForm = freezed,
    Object? formValidationError = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_InvitesState(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading,
      sendingInvite:
          sendingInvite == freezed ? _value.sendingInvite : sendingInvite,
      invites: invites == freezed
          ? _value._invites
          : invites // ignore: cast_nullable_to_non_nullable
              as List<Invite>,
      emailForm: emailForm == freezed ? _value.emailForm : emailForm,
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

class _$_InvitesState implements _InvitesState {
  const _$_InvitesState(
      {this.isLoading = true,
      this.sendingInvite = false,
      final List<Invite> invites = initInvites,
      this.emailForm = '',
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
  final dynamic emailForm;
  @override
  @JsonKey()
  final dynamic formValidationError;
  @override
  final User? user;

  @override
  String toString() {
    return 'InvitesState(isLoading: $isLoading, sendingInvite: $sendingInvite, invites: $invites, emailForm: $emailForm, formValidationError: $formValidationError, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InvitesState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.sendingInvite, sendingInvite) &&
            const DeepCollectionEquality().equals(other._invites, _invites) &&
            const DeepCollectionEquality().equals(other.emailForm, emailForm) &&
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
      const DeepCollectionEquality().hash(emailForm),
      const DeepCollectionEquality().hash(formValidationError),
      const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$$_InvitesStateCopyWith<_$_InvitesState> get copyWith =>
      __$$_InvitesStateCopyWithImpl<_$_InvitesState>(this, _$identity);
}

abstract class _InvitesState implements InvitesState {
  const factory _InvitesState(
      {final dynamic isLoading,
      final dynamic sendingInvite,
      final List<Invite> invites,
      final dynamic emailForm,
      final dynamic formValidationError,
      final User? user}) = _$_InvitesState;

  @override
  dynamic get isLoading => throw _privateConstructorUsedError;
  @override
  dynamic get sendingInvite => throw _privateConstructorUsedError;
  @override
  List<Invite> get invites => throw _privateConstructorUsedError;
  @override
  dynamic get emailForm => throw _privateConstructorUsedError;
  @override
  dynamic get formValidationError => throw _privateConstructorUsedError;
  @override
  User? get user => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_InvitesStateCopyWith<_$_InvitesState> get copyWith =>
      throw _privateConstructorUsedError;
}
