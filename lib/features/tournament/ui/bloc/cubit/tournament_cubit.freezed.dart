// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  dynamic get leaderboardIsLoading => throw _privateConstructorUsedError;
  Tournament? get tournament => throw _privateConstructorUsedError;
  ListPage<LeaderboardModel>? get listPage =>
      throw _privateConstructorUsedError;
  bool get teamTabShowed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TournamentStateCopyWith<TournamentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentStateCopyWith<$Res> {
  factory $TournamentStateCopyWith(
          TournamentState value, $Res Function(TournamentState) then) =
      _$TournamentStateCopyWithImpl<$Res, TournamentState>;
  @useResult
  $Res call(
      {dynamic tournamentIsLoading,
      dynamic leaderboardIsLoading,
      Tournament? tournament,
      ListPage<LeaderboardModel>? listPage,
      bool teamTabShowed});
}

/// @nodoc
class _$TournamentStateCopyWithImpl<$Res, $Val extends TournamentState>
    implements $TournamentStateCopyWith<$Res> {
  _$TournamentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournamentIsLoading = freezed,
    Object? leaderboardIsLoading = freezed,
    Object? tournament = freezed,
    Object? listPage = freezed,
    Object? teamTabShowed = null,
  }) {
    return _then(_value.copyWith(
      tournamentIsLoading: freezed == tournamentIsLoading
          ? _value.tournamentIsLoading
          : tournamentIsLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      leaderboardIsLoading: freezed == leaderboardIsLoading
          ? _value.leaderboardIsLoading
          : leaderboardIsLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tournament: freezed == tournament
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as Tournament?,
      listPage: freezed == listPage
          ? _value.listPage
          : listPage // ignore: cast_nullable_to_non_nullable
              as ListPage<LeaderboardModel>?,
      teamTabShowed: null == teamTabShowed
          ? _value.teamTabShowed
          : teamTabShowed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TournamentStateCopyWith<$Res>
    implements $TournamentStateCopyWith<$Res> {
  factory _$$_TournamentStateCopyWith(
          _$_TournamentState value, $Res Function(_$_TournamentState) then) =
      __$$_TournamentStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic tournamentIsLoading,
      dynamic leaderboardIsLoading,
      Tournament? tournament,
      ListPage<LeaderboardModel>? listPage,
      bool teamTabShowed});
}

/// @nodoc
class __$$_TournamentStateCopyWithImpl<$Res>
    extends _$TournamentStateCopyWithImpl<$Res, _$_TournamentState>
    implements _$$_TournamentStateCopyWith<$Res> {
  __$$_TournamentStateCopyWithImpl(
      _$_TournamentState _value, $Res Function(_$_TournamentState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournamentIsLoading = freezed,
    Object? leaderboardIsLoading = freezed,
    Object? tournament = freezed,
    Object? listPage = freezed,
    Object? teamTabShowed = null,
  }) {
    return _then(_$_TournamentState(
      tournamentIsLoading: freezed == tournamentIsLoading
          ? _value.tournamentIsLoading!
          : tournamentIsLoading,
      leaderboardIsLoading: freezed == leaderboardIsLoading
          ? _value.leaderboardIsLoading!
          : leaderboardIsLoading,
      tournament: freezed == tournament
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as Tournament?,
      listPage: freezed == listPage
          ? _value.listPage
          : listPage // ignore: cast_nullable_to_non_nullable
              as ListPage<LeaderboardModel>?,
      teamTabShowed: null == teamTabShowed
          ? _value.teamTabShowed
          : teamTabShowed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TournamentState implements _TournamentState {
  const _$_TournamentState(
      {this.tournamentIsLoading = true,
      this.leaderboardIsLoading = true,
      this.tournament,
      this.listPage,
      this.teamTabShowed = true});

  @override
  @JsonKey()
  final dynamic tournamentIsLoading;
  @override
  @JsonKey()
  final dynamic leaderboardIsLoading;
  @override
  final Tournament? tournament;
  @override
  final ListPage<LeaderboardModel>? listPage;
  @override
  @JsonKey()
  final bool teamTabShowed;

  @override
  String toString() {
    return 'TournamentState(tournamentIsLoading: $tournamentIsLoading, leaderboardIsLoading: $leaderboardIsLoading, tournament: $tournament, listPage: $listPage, teamTabShowed: $teamTabShowed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TournamentState &&
            const DeepCollectionEquality()
                .equals(other.tournamentIsLoading, tournamentIsLoading) &&
            const DeepCollectionEquality()
                .equals(other.leaderboardIsLoading, leaderboardIsLoading) &&
            (identical(other.tournament, tournament) ||
                other.tournament == tournament) &&
            (identical(other.listPage, listPage) ||
                other.listPage == listPage) &&
            (identical(other.teamTabShowed, teamTabShowed) ||
                other.teamTabShowed == teamTabShowed));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(tournamentIsLoading),
      const DeepCollectionEquality().hash(leaderboardIsLoading),
      tournament,
      listPage,
      teamTabShowed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TournamentStateCopyWith<_$_TournamentState> get copyWith =>
      __$$_TournamentStateCopyWithImpl<_$_TournamentState>(this, _$identity);
}

abstract class _TournamentState implements TournamentState {
  const factory _TournamentState(
      {final dynamic tournamentIsLoading,
      final dynamic leaderboardIsLoading,
      final Tournament? tournament,
      final ListPage<LeaderboardModel>? listPage,
      final bool teamTabShowed}) = _$_TournamentState;

  @override
  dynamic get tournamentIsLoading;
  @override
  dynamic get leaderboardIsLoading;
  @override
  Tournament? get tournament;
  @override
  ListPage<LeaderboardModel>? get listPage;
  @override
  bool get teamTabShowed;
  @override
  @JsonKey(ignore: true)
  _$$_TournamentStateCopyWith<_$_TournamentState> get copyWith =>
      throw _privateConstructorUsedError;
}
