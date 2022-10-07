// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tournament_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TournamentState {
  dynamic get tournamentIsLoading => throw _privateConstructorUsedError;
  Tournament? get tournament => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TournamentStateCopyWith<TournamentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentStateCopyWith<$Res> {
  factory $TournamentStateCopyWith(
          TournamentState value, $Res Function(TournamentState) then) =
      _$TournamentStateCopyWithImpl<$Res>;
  $Res call({dynamic tournamentIsLoading, Tournament? tournament});
}

/// @nodoc
class _$TournamentStateCopyWithImpl<$Res>
    implements $TournamentStateCopyWith<$Res> {
  _$TournamentStateCopyWithImpl(this._value, this._then);

  final TournamentState _value;
  // ignore: unused_field
  final $Res Function(TournamentState) _then;

  @override
  $Res call({
    Object? tournamentIsLoading = freezed,
    Object? tournament = freezed,
  }) {
    return _then(_value.copyWith(
      tournamentIsLoading: tournamentIsLoading == freezed
          ? _value.tournamentIsLoading
          : tournamentIsLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tournament: tournament == freezed
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as Tournament?,
    ));
  }
}

/// @nodoc
abstract class _$$_TournamentStateCopyWith<$Res>
    implements $TournamentStateCopyWith<$Res> {
  factory _$$_TournamentStateCopyWith(
          _$_TournamentState value, $Res Function(_$_TournamentState) then) =
      __$$_TournamentStateCopyWithImpl<$Res>;
  @override
  $Res call({dynamic tournamentIsLoading, Tournament? tournament});
}

/// @nodoc
class __$$_TournamentStateCopyWithImpl<$Res>
    extends _$TournamentStateCopyWithImpl<$Res>
    implements _$$_TournamentStateCopyWith<$Res> {
  __$$_TournamentStateCopyWithImpl(
      _$_TournamentState _value, $Res Function(_$_TournamentState) _then)
      : super(_value, (v) => _then(v as _$_TournamentState));

  @override
  _$_TournamentState get _value => super._value as _$_TournamentState;

  @override
  $Res call({
    Object? tournamentIsLoading = freezed,
    Object? tournament = freezed,
  }) {
    return _then(_$_TournamentState(
      tournamentIsLoading: tournamentIsLoading == freezed
          ? _value.tournamentIsLoading
          : tournamentIsLoading,
      tournament: tournament == freezed
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as Tournament?,
    ));
  }
}

/// @nodoc

class _$_TournamentState implements _TournamentState {
  const _$_TournamentState({this.tournamentIsLoading = false, this.tournament});

  @override
  @JsonKey()
  final dynamic tournamentIsLoading;
  @override
  final Tournament? tournament;

  @override
  String toString() {
    return 'TournamentState(tournamentIsLoading: $tournamentIsLoading, tournament: $tournament)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TournamentState &&
            const DeepCollectionEquality()
                .equals(other.tournamentIsLoading, tournamentIsLoading) &&
            const DeepCollectionEquality()
                .equals(other.tournament, tournament));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(tournamentIsLoading),
      const DeepCollectionEquality().hash(tournament));

  @JsonKey(ignore: true)
  @override
  _$$_TournamentStateCopyWith<_$_TournamentState> get copyWith =>
      __$$_TournamentStateCopyWithImpl<_$_TournamentState>(this, _$identity);
}

abstract class _TournamentState implements TournamentState {
  const factory _TournamentState(
      {final dynamic tournamentIsLoading,
      final Tournament? tournament}) = _$_TournamentState;

  @override
  dynamic get tournamentIsLoading;
  @override
  Tournament? get tournament;
  @override
  @JsonKey(ignore: true)
  _$$_TournamentStateCopyWith<_$_TournamentState> get copyWith =>
      throw _privateConstructorUsedError;
}
