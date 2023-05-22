// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenges_admin_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChallengesAdminState {
  bool get loading => throw _privateConstructorUsedError;
  bool get registeringChallenge => throw _privateConstructorUsedError;
  HttpFailure? get error => throw _privateConstructorUsedError;
  ChallengeSar? get challenge => throw _privateConstructorUsedError;
  bool get checkingHealth => throw _privateConstructorUsedError;
  SarHealthResponseDto? get health => throw _privateConstructorUsedError;
  Object? get errorHealth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChallengesAdminStateCopyWith<ChallengesAdminState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengesAdminStateCopyWith<$Res> {
  factory $ChallengesAdminStateCopyWith(ChallengesAdminState value,
          $Res Function(ChallengesAdminState) then) =
      _$ChallengesAdminStateCopyWithImpl<$Res, ChallengesAdminState>;
  @useResult
  $Res call(
      {bool loading,
      bool registeringChallenge,
      HttpFailure? error,
      ChallengeSar? challenge,
      bool checkingHealth,
      SarHealthResponseDto? health,
      Object? errorHealth});
}

/// @nodoc
class _$ChallengesAdminStateCopyWithImpl<$Res,
        $Val extends ChallengesAdminState>
    implements $ChallengesAdminStateCopyWith<$Res> {
  _$ChallengesAdminStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? registeringChallenge = null,
    Object? error = freezed,
    Object? challenge = freezed,
    Object? checkingHealth = null,
    Object? health = freezed,
    Object? errorHealth = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      registeringChallenge: null == registeringChallenge
          ? _value.registeringChallenge
          : registeringChallenge // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as HttpFailure?,
      challenge: freezed == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as ChallengeSar?,
      checkingHealth: null == checkingHealth
          ? _value.checkingHealth
          : checkingHealth // ignore: cast_nullable_to_non_nullable
              as bool,
      health: freezed == health
          ? _value.health
          : health // ignore: cast_nullable_to_non_nullable
              as SarHealthResponseDto?,
      errorHealth: freezed == errorHealth ? _value.errorHealth : errorHealth,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChallengesAdminStateCopyWith<$Res>
    implements $ChallengesAdminStateCopyWith<$Res> {
  factory _$$_ChallengesAdminStateCopyWith(_$_ChallengesAdminState value,
          $Res Function(_$_ChallengesAdminState) then) =
      __$$_ChallengesAdminStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      bool registeringChallenge,
      HttpFailure? error,
      ChallengeSar? challenge,
      bool checkingHealth,
      SarHealthResponseDto? health,
      Object? errorHealth});
}

/// @nodoc
class __$$_ChallengesAdminStateCopyWithImpl<$Res>
    extends _$ChallengesAdminStateCopyWithImpl<$Res, _$_ChallengesAdminState>
    implements _$$_ChallengesAdminStateCopyWith<$Res> {
  __$$_ChallengesAdminStateCopyWithImpl(_$_ChallengesAdminState _value,
      $Res Function(_$_ChallengesAdminState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? registeringChallenge = null,
    Object? error = freezed,
    Object? challenge = freezed,
    Object? checkingHealth = null,
    Object? health = freezed,
    Object? errorHealth = freezed,
  }) {
    return _then(_$_ChallengesAdminState(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      registeringChallenge: null == registeringChallenge
          ? _value.registeringChallenge
          : registeringChallenge // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as HttpFailure?,
      challenge: freezed == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as ChallengeSar?,
      checkingHealth: null == checkingHealth
          ? _value.checkingHealth
          : checkingHealth // ignore: cast_nullable_to_non_nullable
              as bool,
      health: freezed == health
          ? _value.health
          : health // ignore: cast_nullable_to_non_nullable
              as SarHealthResponseDto?,
      errorHealth: freezed == errorHealth ? _value.errorHealth : errorHealth,
    ));
  }
}

/// @nodoc

class _$_ChallengesAdminState implements _ChallengesAdminState {
  const _$_ChallengesAdminState(
      {this.loading = false,
      this.registeringChallenge = false,
      this.error,
      this.challenge,
      this.checkingHealth = false,
      this.health,
      this.errorHealth});

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool registeringChallenge;
  @override
  final HttpFailure? error;
  @override
  final ChallengeSar? challenge;
  @override
  @JsonKey()
  final bool checkingHealth;
  @override
  final SarHealthResponseDto? health;
  @override
  final Object? errorHealth;

  @override
  String toString() {
    return 'ChallengesAdminState(loading: $loading, registeringChallenge: $registeringChallenge, error: $error, challenge: $challenge, checkingHealth: $checkingHealth, health: $health, errorHealth: $errorHealth)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChallengesAdminState &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.registeringChallenge, registeringChallenge) ||
                other.registeringChallenge == registeringChallenge) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.challenge, challenge) ||
                other.challenge == challenge) &&
            (identical(other.checkingHealth, checkingHealth) ||
                other.checkingHealth == checkingHealth) &&
            (identical(other.health, health) || other.health == health) &&
            const DeepCollectionEquality()
                .equals(other.errorHealth, errorHealth));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      registeringChallenge,
      error,
      challenge,
      checkingHealth,
      health,
      const DeepCollectionEquality().hash(errorHealth));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChallengesAdminStateCopyWith<_$_ChallengesAdminState> get copyWith =>
      __$$_ChallengesAdminStateCopyWithImpl<_$_ChallengesAdminState>(
          this, _$identity);
}

abstract class _ChallengesAdminState implements ChallengesAdminState {
  const factory _ChallengesAdminState(
      {final bool loading,
      final bool registeringChallenge,
      final HttpFailure? error,
      final ChallengeSar? challenge,
      final bool checkingHealth,
      final SarHealthResponseDto? health,
      final Object? errorHealth}) = _$_ChallengesAdminState;

  @override
  bool get loading;
  @override
  bool get registeringChallenge;
  @override
  HttpFailure? get error;
  @override
  ChallengeSar? get challenge;
  @override
  bool get checkingHealth;
  @override
  SarHealthResponseDto? get health;
  @override
  Object? get errorHealth;
  @override
  @JsonKey(ignore: true)
  _$$_ChallengesAdminStateCopyWith<_$_ChallengesAdminState> get copyWith =>
      throw _privateConstructorUsedError;
}
