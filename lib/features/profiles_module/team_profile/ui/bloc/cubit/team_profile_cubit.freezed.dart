// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TeamProfileState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  TeamProfileDto? get team => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TeamProfileStateCopyWith<TeamProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamProfileStateCopyWith<$Res> {
  factory $TeamProfileStateCopyWith(
          TeamProfileState value, $Res Function(TeamProfileState) then) =
      _$TeamProfileStateCopyWithImpl<$Res, TeamProfileState>;
  @useResult
  $Res call({dynamic isLoading, TeamProfileDto? team});
}

/// @nodoc
class _$TeamProfileStateCopyWithImpl<$Res, $Val extends TeamProfileState>
    implements $TeamProfileStateCopyWith<$Res> {
  _$TeamProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? team = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamProfileDto?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TeamProfileStateCopyWith<$Res>
    implements $TeamProfileStateCopyWith<$Res> {
  factory _$$_TeamProfileStateCopyWith(
          _$_TeamProfileState value, $Res Function(_$_TeamProfileState) then) =
      __$$_TeamProfileStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic isLoading, TeamProfileDto? team});
}

/// @nodoc
class __$$_TeamProfileStateCopyWithImpl<$Res>
    extends _$TeamProfileStateCopyWithImpl<$Res, _$_TeamProfileState>
    implements _$$_TeamProfileStateCopyWith<$Res> {
  __$$_TeamProfileStateCopyWithImpl(
      _$_TeamProfileState _value, $Res Function(_$_TeamProfileState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? team = freezed,
  }) {
    return _then(_$_TeamProfileState(
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as TeamProfileDto?,
    ));
  }
}

/// @nodoc

class _$_TeamProfileState implements _TeamProfileState {
  const _$_TeamProfileState({this.isLoading = true, this.team});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final TeamProfileDto? team;

  @override
  String toString() {
    return 'TeamProfileState(isLoading: $isLoading, team: $team)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TeamProfileState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            (identical(other.team, team) || other.team == team));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(isLoading), team);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TeamProfileStateCopyWith<_$_TeamProfileState> get copyWith =>
      __$$_TeamProfileStateCopyWithImpl<_$_TeamProfileState>(this, _$identity);
}

abstract class _TeamProfileState implements TeamProfileState {
  const factory _TeamProfileState(
      {final dynamic isLoading,
      final TeamProfileDto? team}) = _$_TeamProfileState;

  @override
  dynamic get isLoading;
  @override
  TeamProfileDto? get team;
  @override
  @JsonKey(ignore: true)
  _$$_TeamProfileStateCopyWith<_$_TeamProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}
