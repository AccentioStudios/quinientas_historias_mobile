// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenges_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChallengesState {
  bool get loading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChallengesStateCopyWith<ChallengesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengesStateCopyWith<$Res> {
  factory $ChallengesStateCopyWith(
          ChallengesState value, $Res Function(ChallengesState) then) =
      _$ChallengesStateCopyWithImpl<$Res, ChallengesState>;
  @useResult
  $Res call({bool loading});
}

/// @nodoc
class _$ChallengesStateCopyWithImpl<$Res, $Val extends ChallengesState>
    implements $ChallengesStateCopyWith<$Res> {
  _$ChallengesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChallengesStateCopyWith<$Res>
    implements $ChallengesStateCopyWith<$Res> {
  factory _$$_ChallengesStateCopyWith(
          _$_ChallengesState value, $Res Function(_$_ChallengesState) then) =
      __$$_ChallengesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loading});
}

/// @nodoc
class __$$_ChallengesStateCopyWithImpl<$Res>
    extends _$ChallengesStateCopyWithImpl<$Res, _$_ChallengesState>
    implements _$$_ChallengesStateCopyWith<$Res> {
  __$$_ChallengesStateCopyWithImpl(
      _$_ChallengesState _value, $Res Function(_$_ChallengesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
  }) {
    return _then(_$_ChallengesState(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ChallengesState implements _ChallengesState {
  const _$_ChallengesState({this.loading = false});

  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'ChallengesState(loading: $loading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChallengesState &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChallengesStateCopyWith<_$_ChallengesState> get copyWith =>
      __$$_ChallengesStateCopyWithImpl<_$_ChallengesState>(this, _$identity);
}

abstract class _ChallengesState implements ChallengesState {
  const factory _ChallengesState({final bool loading}) = _$_ChallengesState;

  @override
  bool get loading;
  @override
  @JsonKey(ignore: true)
  _$$_ChallengesStateCopyWith<_$_ChallengesState> get copyWith =>
      throw _privateConstructorUsedError;
}
