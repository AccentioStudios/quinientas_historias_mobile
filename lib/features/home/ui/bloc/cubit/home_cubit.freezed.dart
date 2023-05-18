// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeState {
  Dashboard? get dashboard => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call({Dashboard? dashboard, bool loading, Object? error});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dashboard = freezed,
    Object? loading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      dashboard: freezed == dashboard
          ? _value.dashboard
          : dashboard // ignore: cast_nullable_to_non_nullable
              as Dashboard?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$$_HomeStateCopyWith(
          _$_HomeState value, $Res Function(_$_HomeState) then) =
      __$$_HomeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Dashboard? dashboard, bool loading, Object? error});
}

/// @nodoc
class __$$_HomeStateCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$_HomeState>
    implements _$$_HomeStateCopyWith<$Res> {
  __$$_HomeStateCopyWithImpl(
      _$_HomeState _value, $Res Function(_$_HomeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dashboard = freezed,
    Object? loading = null,
    Object? error = freezed,
  }) {
    return _then(_$_HomeState(
      dashboard: freezed == dashboard
          ? _value.dashboard
          : dashboard // ignore: cast_nullable_to_non_nullable
              as Dashboard?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$_HomeState implements _HomeState {
  const _$_HomeState({this.dashboard, this.loading = false, this.error});

  @override
  final Dashboard? dashboard;
  @override
  @JsonKey()
  final bool loading;
  @override
  final Object? error;

  @override
  String toString() {
    return 'HomeState(dashboard: $dashboard, loading: $loading, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeState &&
            (identical(other.dashboard, dashboard) ||
                other.dashboard == dashboard) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dashboard, loading,
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      __$$_HomeStateCopyWithImpl<_$_HomeState>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final Dashboard? dashboard,
      final bool loading,
      final Object? error}) = _$_HomeState;

  @override
  Dashboard? get dashboard;
  @override
  bool get loading;
  @override
  Object? get error;
  @override
  @JsonKey(ignore: true)
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
