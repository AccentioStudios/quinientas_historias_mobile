// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'landing_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LandingState {
  dynamic get loading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LandingStateCopyWith<LandingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LandingStateCopyWith<$Res> {
  factory $LandingStateCopyWith(
          LandingState value, $Res Function(LandingState) then) =
      _$LandingStateCopyWithImpl<$Res>;
  $Res call({dynamic loading});
}

/// @nodoc
class _$LandingStateCopyWithImpl<$Res> implements $LandingStateCopyWith<$Res> {
  _$LandingStateCopyWithImpl(this._value, this._then);

  final LandingState _value;
  // ignore: unused_field
  final $Res Function(LandingState) _then;

  @override
  $Res call({
    Object? loading = freezed,
  }) {
    return _then(_value.copyWith(
      loading: loading == freezed
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_LandingStateCopyWith<$Res>
    implements $LandingStateCopyWith<$Res> {
  factory _$$_LandingStateCopyWith(
          _$_LandingState value, $Res Function(_$_LandingState) then) =
      __$$_LandingStateCopyWithImpl<$Res>;
  @override
  $Res call({dynamic loading});
}

/// @nodoc
class __$$_LandingStateCopyWithImpl<$Res>
    extends _$LandingStateCopyWithImpl<$Res>
    implements _$$_LandingStateCopyWith<$Res> {
  __$$_LandingStateCopyWithImpl(
      _$_LandingState _value, $Res Function(_$_LandingState) _then)
      : super(_value, (v) => _then(v as _$_LandingState));

  @override
  _$_LandingState get _value => super._value as _$_LandingState;

  @override
  $Res call({
    Object? loading = freezed,
  }) {
    return _then(_$_LandingState(
      loading: loading == freezed ? _value.loading : loading,
    ));
  }
}

/// @nodoc

class _$_LandingState implements _LandingState {
  const _$_LandingState({this.loading = true});

  @override
  @JsonKey()
  final dynamic loading;

  @override
  String toString() {
    return 'LandingState(loading: $loading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LandingState &&
            const DeepCollectionEquality().equals(other.loading, loading));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(loading));

  @JsonKey(ignore: true)
  @override
  _$$_LandingStateCopyWith<_$_LandingState> get copyWith =>
      __$$_LandingStateCopyWithImpl<_$_LandingState>(this, _$identity);
}

abstract class _LandingState implements LandingState {
  const factory _LandingState({final dynamic loading}) = _$_LandingState;

  @override
  dynamic get loading => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_LandingStateCopyWith<_$_LandingState> get copyWith =>
      throw _privateConstructorUsedError;
}
