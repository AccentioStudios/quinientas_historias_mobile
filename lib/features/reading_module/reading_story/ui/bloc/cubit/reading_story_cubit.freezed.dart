// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'reading_story_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReadingStoryState {
  bool get loading => throw _privateConstructorUsedError;
  bool get saveFavoriteloading => throw _privateConstructorUsedError;
  int get storyProgress => throw _privateConstructorUsedError;
  Story? get story => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReadingStoryStateCopyWith<ReadingStoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadingStoryStateCopyWith<$Res> {
  factory $ReadingStoryStateCopyWith(
          ReadingStoryState value, $Res Function(ReadingStoryState) then) =
      _$ReadingStoryStateCopyWithImpl<$Res>;
  $Res call(
      {bool loading,
      bool saveFavoriteloading,
      int storyProgress,
      Story? story});
}

/// @nodoc
class _$ReadingStoryStateCopyWithImpl<$Res>
    implements $ReadingStoryStateCopyWith<$Res> {
  _$ReadingStoryStateCopyWithImpl(this._value, this._then);

  final ReadingStoryState _value;
  // ignore: unused_field
  final $Res Function(ReadingStoryState) _then;

  @override
  $Res call({
    Object? loading = freezed,
    Object? saveFavoriteloading = freezed,
    Object? storyProgress = freezed,
    Object? story = freezed,
  }) {
    return _then(_value.copyWith(
      loading: loading == freezed
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      saveFavoriteloading: saveFavoriteloading == freezed
          ? _value.saveFavoriteloading
          : saveFavoriteloading // ignore: cast_nullable_to_non_nullable
              as bool,
      storyProgress: storyProgress == freezed
          ? _value.storyProgress
          : storyProgress // ignore: cast_nullable_to_non_nullable
              as int,
      story: story == freezed
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as Story?,
    ));
  }
}

/// @nodoc
abstract class _$$_ReadingStoryStateCopyWith<$Res>
    implements $ReadingStoryStateCopyWith<$Res> {
  factory _$$_ReadingStoryStateCopyWith(_$_ReadingStoryState value,
          $Res Function(_$_ReadingStoryState) then) =
      __$$_ReadingStoryStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool loading,
      bool saveFavoriteloading,
      int storyProgress,
      Story? story});
}

/// @nodoc
class __$$_ReadingStoryStateCopyWithImpl<$Res>
    extends _$ReadingStoryStateCopyWithImpl<$Res>
    implements _$$_ReadingStoryStateCopyWith<$Res> {
  __$$_ReadingStoryStateCopyWithImpl(
      _$_ReadingStoryState _value, $Res Function(_$_ReadingStoryState) _then)
      : super(_value, (v) => _then(v as _$_ReadingStoryState));

  @override
  _$_ReadingStoryState get _value => super._value as _$_ReadingStoryState;

  @override
  $Res call({
    Object? loading = freezed,
    Object? saveFavoriteloading = freezed,
    Object? storyProgress = freezed,
    Object? story = freezed,
  }) {
    return _then(_$_ReadingStoryState(
      loading: loading == freezed
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      saveFavoriteloading: saveFavoriteloading == freezed
          ? _value.saveFavoriteloading
          : saveFavoriteloading // ignore: cast_nullable_to_non_nullable
              as bool,
      storyProgress: storyProgress == freezed
          ? _value.storyProgress
          : storyProgress // ignore: cast_nullable_to_non_nullable
              as int,
      story: story == freezed
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as Story?,
    ));
  }
}

/// @nodoc

class _$_ReadingStoryState implements _ReadingStoryState {
  const _$_ReadingStoryState(
      {this.loading = false,
      this.saveFavoriteloading = false,
      this.storyProgress = 0,
      this.story});

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool saveFavoriteloading;
  @override
  @JsonKey()
  final int storyProgress;
  @override
  final Story? story;

  @override
  String toString() {
    return 'ReadingStoryState(loading: $loading, saveFavoriteloading: $saveFavoriteloading, storyProgress: $storyProgress, story: $story)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReadingStoryState &&
            const DeepCollectionEquality().equals(other.loading, loading) &&
            const DeepCollectionEquality()
                .equals(other.saveFavoriteloading, saveFavoriteloading) &&
            const DeepCollectionEquality()
                .equals(other.storyProgress, storyProgress) &&
            const DeepCollectionEquality().equals(other.story, story));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(loading),
      const DeepCollectionEquality().hash(saveFavoriteloading),
      const DeepCollectionEquality().hash(storyProgress),
      const DeepCollectionEquality().hash(story));

  @JsonKey(ignore: true)
  @override
  _$$_ReadingStoryStateCopyWith<_$_ReadingStoryState> get copyWith =>
      __$$_ReadingStoryStateCopyWithImpl<_$_ReadingStoryState>(
          this, _$identity);
}

abstract class _ReadingStoryState implements ReadingStoryState {
  const factory _ReadingStoryState(
      {final bool loading,
      final bool saveFavoriteloading,
      final int storyProgress,
      final Story? story}) = _$_ReadingStoryState;

  @override
  bool get loading => throw _privateConstructorUsedError;
  @override
  bool get saveFavoriteloading => throw _privateConstructorUsedError;
  @override
  int get storyProgress => throw _privateConstructorUsedError;
  @override
  Story? get story => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ReadingStoryStateCopyWith<_$_ReadingStoryState> get copyWith =>
      throw _privateConstructorUsedError;
}