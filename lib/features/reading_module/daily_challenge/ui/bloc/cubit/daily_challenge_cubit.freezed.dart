// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'daily_challenge_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DailyChallengeState {
  bool get loading => throw _privateConstructorUsedError;
  DailyChallenge get data => throw _privateConstructorUsedError;
  Story? get storyHovered => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DailyChallengeStateCopyWith<DailyChallengeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyChallengeStateCopyWith<$Res> {
  factory $DailyChallengeStateCopyWith(
          DailyChallengeState value, $Res Function(DailyChallengeState) then) =
      _$DailyChallengeStateCopyWithImpl<$Res, DailyChallengeState>;
  @useResult
  $Res call({bool loading, DailyChallenge data, Story? storyHovered});
}

/// @nodoc
class _$DailyChallengeStateCopyWithImpl<$Res, $Val extends DailyChallengeState>
    implements $DailyChallengeStateCopyWith<$Res> {
  _$DailyChallengeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? data = null,
    Object? storyHovered = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DailyChallenge,
      storyHovered: freezed == storyHovered
          ? _value.storyHovered
          : storyHovered // ignore: cast_nullable_to_non_nullable
              as Story?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReadingChallangeStateCopyWith<$Res>
    implements $DailyChallengeStateCopyWith<$Res> {
  factory _$$_ReadingChallangeStateCopyWith(_$_ReadingChallangeState value,
          $Res Function(_$_ReadingChallangeState) then) =
      __$$_ReadingChallangeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loading, DailyChallenge data, Story? storyHovered});
}

/// @nodoc
class __$$_ReadingChallangeStateCopyWithImpl<$Res>
    extends _$DailyChallengeStateCopyWithImpl<$Res, _$_ReadingChallangeState>
    implements _$$_ReadingChallangeStateCopyWith<$Res> {
  __$$_ReadingChallangeStateCopyWithImpl(_$_ReadingChallangeState _value,
      $Res Function(_$_ReadingChallangeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? data = null,
    Object? storyHovered = freezed,
  }) {
    return _then(_$_ReadingChallangeState(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DailyChallenge,
      storyHovered: freezed == storyHovered
          ? _value.storyHovered
          : storyHovered // ignore: cast_nullable_to_non_nullable
              as Story?,
    ));
  }
}

/// @nodoc

class _$_ReadingChallangeState implements _ReadingChallangeState {
  const _$_ReadingChallangeState(
      {this.loading = false, required this.data, this.storyHovered});

  @override
  @JsonKey()
  final bool loading;
  @override
  final DailyChallenge data;
  @override
  final Story? storyHovered;

  @override
  String toString() {
    return 'DailyChallengeState(loading: $loading, data: $data, storyHovered: $storyHovered)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReadingChallangeState &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.storyHovered, storyHovered) ||
                other.storyHovered == storyHovered));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading, data, storyHovered);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReadingChallangeStateCopyWith<_$_ReadingChallangeState> get copyWith =>
      __$$_ReadingChallangeStateCopyWithImpl<_$_ReadingChallangeState>(
          this, _$identity);
}

abstract class _ReadingChallangeState implements DailyChallengeState {
  const factory _ReadingChallangeState(
      {final bool loading,
      required final DailyChallenge data,
      final Story? storyHovered}) = _$_ReadingChallangeState;

  @override
  bool get loading;
  @override
  DailyChallenge get data;
  @override
  Story? get storyHovered;
  @override
  @JsonKey(ignore: true)
  _$$_ReadingChallangeStateCopyWith<_$_ReadingChallangeState> get copyWith =>
      throw _privateConstructorUsedError;
}
