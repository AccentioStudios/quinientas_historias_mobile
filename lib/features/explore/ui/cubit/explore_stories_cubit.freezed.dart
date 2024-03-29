// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_stories_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ExploreStoriesState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  ListPage<Story>? get listPage => throw _privateConstructorUsedError;
  ExploreSearchFilters get filters => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExploreStoriesStateCopyWith<ExploreStoriesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExploreStoriesStateCopyWith<$Res> {
  factory $ExploreStoriesStateCopyWith(
          ExploreStoriesState value, $Res Function(ExploreStoriesState) then) =
      _$ExploreStoriesStateCopyWithImpl<$Res, ExploreStoriesState>;
  @useResult
  $Res call(
      {dynamic isLoading,
      ListPage<Story>? listPage,
      ExploreSearchFilters filters});
}

/// @nodoc
class _$ExploreStoriesStateCopyWithImpl<$Res, $Val extends ExploreStoriesState>
    implements $ExploreStoriesStateCopyWith<$Res> {
  _$ExploreStoriesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? listPage = freezed,
    Object? filters = null,
  }) {
    return _then(_value.copyWith(
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      listPage: freezed == listPage
          ? _value.listPage
          : listPage // ignore: cast_nullable_to_non_nullable
              as ListPage<Story>?,
      filters: null == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as ExploreSearchFilters,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExploreStoriesStateCopyWith<$Res>
    implements $ExploreStoriesStateCopyWith<$Res> {
  factory _$$_ExploreStoriesStateCopyWith(_$_ExploreStoriesState value,
          $Res Function(_$_ExploreStoriesState) then) =
      __$$_ExploreStoriesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic isLoading,
      ListPage<Story>? listPage,
      ExploreSearchFilters filters});
}

/// @nodoc
class __$$_ExploreStoriesStateCopyWithImpl<$Res>
    extends _$ExploreStoriesStateCopyWithImpl<$Res, _$_ExploreStoriesState>
    implements _$$_ExploreStoriesStateCopyWith<$Res> {
  __$$_ExploreStoriesStateCopyWithImpl(_$_ExploreStoriesState _value,
      $Res Function(_$_ExploreStoriesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = freezed,
    Object? listPage = freezed,
    Object? filters = null,
  }) {
    return _then(_$_ExploreStoriesState(
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
      listPage: freezed == listPage
          ? _value.listPage
          : listPage // ignore: cast_nullable_to_non_nullable
              as ListPage<Story>?,
      filters: null == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as ExploreSearchFilters,
    ));
  }
}

/// @nodoc

class _$_ExploreStoriesState implements _ExploreStoriesState {
  const _$_ExploreStoriesState(
      {this.isLoading = true,
      this.listPage,
      this.filters = const ExploreSearchFilters()});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final ListPage<Story>? listPage;
  @override
  @JsonKey()
  final ExploreSearchFilters filters;

  @override
  String toString() {
    return 'ExploreStoriesState(isLoading: $isLoading, listPage: $listPage, filters: $filters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExploreStoriesState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            (identical(other.listPage, listPage) ||
                other.listPage == listPage) &&
            (identical(other.filters, filters) || other.filters == filters));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(isLoading), listPage, filters);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExploreStoriesStateCopyWith<_$_ExploreStoriesState> get copyWith =>
      __$$_ExploreStoriesStateCopyWithImpl<_$_ExploreStoriesState>(
          this, _$identity);
}

abstract class _ExploreStoriesState implements ExploreStoriesState {
  const factory _ExploreStoriesState(
      {final dynamic isLoading,
      final ListPage<Story>? listPage,
      final ExploreSearchFilters filters}) = _$_ExploreStoriesState;

  @override
  dynamic get isLoading;
  @override
  ListPage<Story>? get listPage;
  @override
  ExploreSearchFilters get filters;
  @override
  @JsonKey(ignore: true)
  _$$_ExploreStoriesStateCopyWith<_$_ExploreStoriesState> get copyWith =>
      throw _privateConstructorUsedError;
}
