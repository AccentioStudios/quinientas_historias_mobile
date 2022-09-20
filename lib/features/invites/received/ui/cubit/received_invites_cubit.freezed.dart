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
  User? get whoIsInviting => throw _privateConstructorUsedError;
  Team? get team => throw _privateConstructorUsedError;
  School? get school => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  dynamic get isLoading => throw _privateConstructorUsedError;
  dynamic get formValidationError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReceivedInvitesStateCopyWith<ReceivedInvitesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceivedInvitesStateCopyWith<$Res> {
  factory $ReceivedInvitesStateCopyWith(ReceivedInvitesState value,
          $Res Function(ReceivedInvitesState) then) =
      _$ReceivedInvitesStateCopyWithImpl<$Res>;
  $Res call(
      {User? whoIsInviting,
      Team? team,
      School? school,
      String code,
      dynamic isLoading,
      dynamic formValidationError});
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
    Object? whoIsInviting = freezed,
    Object? team = freezed,
    Object? school = freezed,
    Object? code = freezed,
    Object? isLoading = freezed,
    Object? formValidationError = freezed,
  }) {
    return _then(_value.copyWith(
      whoIsInviting: whoIsInviting == freezed
          ? _value.whoIsInviting
          : whoIsInviting // ignore: cast_nullable_to_non_nullable
              as User?,
      team: team == freezed
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team?,
      school: school == freezed
          ? _value.school
          : school // ignore: cast_nullable_to_non_nullable
              as School?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      formValidationError: formValidationError == freezed
          ? _value.formValidationError
          : formValidationError // ignore: cast_nullable_to_non_nullable
              as dynamic,
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
  $Res call(
      {User? whoIsInviting,
      Team? team,
      School? school,
      String code,
      dynamic isLoading,
      dynamic formValidationError});
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
    Object? whoIsInviting = freezed,
    Object? team = freezed,
    Object? school = freezed,
    Object? code = freezed,
    Object? isLoading = freezed,
    Object? formValidationError = freezed,
  }) {
    return _then(_$_ReceivedInvitesState(
      whoIsInviting: whoIsInviting == freezed
          ? _value.whoIsInviting
          : whoIsInviting // ignore: cast_nullable_to_non_nullable
              as User?,
      team: team == freezed
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team?,
      school: school == freezed
          ? _value.school
          : school // ignore: cast_nullable_to_non_nullable
              as School?,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: isLoading == freezed ? _value.isLoading : isLoading,
      formValidationError: formValidationError == freezed
          ? _value.formValidationError
          : formValidationError,
    ));
  }
}

/// @nodoc

class _$_ReceivedInvitesState implements _ReceivedInvitesState {
  const _$_ReceivedInvitesState(
      {this.whoIsInviting,
      this.team,
      this.school,
      this.code = '',
      this.isLoading = true,
      this.formValidationError = false});

  @override
  final User? whoIsInviting;
  @override
  final Team? team;
  @override
  final School? school;
  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  @JsonKey()
  final dynamic formValidationError;

  @override
  String toString() {
    return 'ReceivedInvitesState(whoIsInviting: $whoIsInviting, team: $team, school: $school, code: $code, isLoading: $isLoading, formValidationError: $formValidationError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReceivedInvitesState &&
            const DeepCollectionEquality()
                .equals(other.whoIsInviting, whoIsInviting) &&
            const DeepCollectionEquality().equals(other.team, team) &&
            const DeepCollectionEquality().equals(other.school, school) &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.formValidationError, formValidationError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(whoIsInviting),
      const DeepCollectionEquality().hash(team),
      const DeepCollectionEquality().hash(school),
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(formValidationError));

  @JsonKey(ignore: true)
  @override
  _$$_ReceivedInvitesStateCopyWith<_$_ReceivedInvitesState> get copyWith =>
      __$$_ReceivedInvitesStateCopyWithImpl<_$_ReceivedInvitesState>(
          this, _$identity);
}

abstract class _ReceivedInvitesState implements ReceivedInvitesState {
  const factory _ReceivedInvitesState(
      {final User? whoIsInviting,
      final Team? team,
      final School? school,
      final String code,
      final dynamic isLoading,
      final dynamic formValidationError}) = _$_ReceivedInvitesState;

  @override
  User? get whoIsInviting => throw _privateConstructorUsedError;
  @override
  Team? get team => throw _privateConstructorUsedError;
  @override
  School? get school => throw _privateConstructorUsedError;
  @override
  String get code => throw _privateConstructorUsedError;
  @override
  dynamic get isLoading => throw _privateConstructorUsedError;
  @override
  dynamic get formValidationError => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ReceivedInvitesStateCopyWith<_$_ReceivedInvitesState> get copyWith =>
      throw _privateConstructorUsedError;
}
