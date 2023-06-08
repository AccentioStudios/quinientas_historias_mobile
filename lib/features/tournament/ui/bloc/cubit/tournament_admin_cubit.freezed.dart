// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament_admin_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TournamentAdminState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  dynamic get creatingTournamentLoading => throw _privateConstructorUsedError;
  List<Tournament> get tournaments => throw _privateConstructorUsedError;
  List<Tag> get tags => throw _privateConstructorUsedError;
  TournamentDto? get tournament => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TournamentAdminStateCopyWith<TournamentAdminState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentAdminStateCopyWith<$Res> {
  factory $TournamentAdminStateCopyWith(TournamentAdminState value,
          $Res Function(TournamentAdminState) then) =
      _$TournamentAdminStateCopyWithImpl<$Res, TournamentAdminState>;
  @useResult
  $Res call(
      {dynamic isLoading,
      dynamic creatingTournamentLoading,
      List<Tournament> tournaments,
      List<Tag> tags,
      TournamentDto? tournament,
      Object? error});
}

/// @nodoc
class _$TournamentAdminStateCopyWithImpl<$Res,
        $Val extends TournamentAdminState>
    implements $TournamentAdminStateCopyWith<$Res> {
  _$TournamentAdminStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? creatingTournamentLoading = freezed,
    Object? tournaments = null,
    Object? tags = null,
    Object? tournament = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      creatingTournamentLoading: freezed == creatingTournamentLoading
          ? _value.creatingTournamentLoading
          : creatingTournamentLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tournaments: null == tournaments
          ? _value.tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as List<Tournament>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      tournament: freezed == tournament
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as TournamentDto?,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TournamentAdminStateCopyWith<$Res>
    implements $TournamentAdminStateCopyWith<$Res> {
  factory _$$_TournamentAdminStateCopyWith(_$_TournamentAdminState value,
          $Res Function(_$_TournamentAdminState) then) =
      __$$_TournamentAdminStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic isLoading,
      dynamic creatingTournamentLoading,
      List<Tournament> tournaments,
      List<Tag> tags,
      TournamentDto? tournament,
      Object? error});
}

/// @nodoc
class __$$_TournamentAdminStateCopyWithImpl<$Res>
    extends _$TournamentAdminStateCopyWithImpl<$Res, _$_TournamentAdminState>
    implements _$$_TournamentAdminStateCopyWith<$Res> {
  __$$_TournamentAdminStateCopyWithImpl(_$_TournamentAdminState _value,
      $Res Function(_$_TournamentAdminState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? creatingTournamentLoading = freezed,
    Object? tournaments = null,
    Object? tags = null,
    Object? tournament = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_TournamentAdminState(
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
      creatingTournamentLoading: freezed == creatingTournamentLoading
          ? _value.creatingTournamentLoading!
          : creatingTournamentLoading,
      tournaments: null == tournaments
          ? _value._tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as List<Tournament>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      tournament: freezed == tournament
          ? _value.tournament
          : tournament // ignore: cast_nullable_to_non_nullable
              as TournamentDto?,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$_TournamentAdminState implements _TournamentAdminState {
  const _$_TournamentAdminState(
      {this.isLoading = false,
      this.creatingTournamentLoading = false,
      final List<Tournament> tournaments = const [],
      final List<Tag> tags = const [],
      this.tournament,
      this.error})
      : _tournaments = tournaments,
        _tags = tags;

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  @JsonKey()
  final dynamic creatingTournamentLoading;
  final List<Tournament> _tournaments;
  @override
  @JsonKey()
  List<Tournament> get tournaments {
    if (_tournaments is EqualUnmodifiableListView) return _tournaments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tournaments);
  }

  final List<Tag> _tags;
  @override
  @JsonKey()
  List<Tag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final TournamentDto? tournament;
  @override
  final Object? error;

  @override
  String toString() {
    return 'TournamentAdminState(isLoading: $isLoading, creatingTournamentLoading: $creatingTournamentLoading, tournaments: $tournaments, tags: $tags, tournament: $tournament, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TournamentAdminState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(
                other.creatingTournamentLoading, creatingTournamentLoading) &&
            const DeepCollectionEquality()
                .equals(other._tournaments, _tournaments) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.tournament, tournament) ||
                other.tournament == tournament) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(creatingTournamentLoading),
      const DeepCollectionEquality().hash(_tournaments),
      const DeepCollectionEquality().hash(_tags),
      tournament,
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TournamentAdminStateCopyWith<_$_TournamentAdminState> get copyWith =>
      __$$_TournamentAdminStateCopyWithImpl<_$_TournamentAdminState>(
          this, _$identity);
}

abstract class _TournamentAdminState implements TournamentAdminState {
  const factory _TournamentAdminState(
      {final dynamic isLoading,
      final dynamic creatingTournamentLoading,
      final List<Tournament> tournaments,
      final List<Tag> tags,
      final TournamentDto? tournament,
      final Object? error}) = _$_TournamentAdminState;

  @override
  dynamic get isLoading;
  @override
  dynamic get creatingTournamentLoading;
  @override
  List<Tournament> get tournaments;
  @override
  List<Tag> get tags;
  @override
  TournamentDto? get tournament;
  @override
  Object? get error;
  @override
  @JsonKey(ignore: true)
  _$$_TournamentAdminStateCopyWith<_$_TournamentAdminState> get copyWith =>
      throw _privateConstructorUsedError;
}
