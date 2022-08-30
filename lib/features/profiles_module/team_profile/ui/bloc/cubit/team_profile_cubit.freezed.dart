// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'team_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TeamProfileState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  Team? get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TeamProfileStateCopyWith<TeamProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamProfileStateCopyWith<$Res> {
  factory $TeamProfileStateCopyWith(
          TeamProfileState value, $Res Function(TeamProfileState) then) =
      _$TeamProfileStateCopyWithImpl<$Res>;
  $Res call({dynamic isLoading, Team? data});
}

/// @nodoc
class _$TeamProfileStateCopyWithImpl<$Res>
    implements $TeamProfileStateCopyWith<$Res> {
  _$TeamProfileStateCopyWithImpl(this._value, this._then);

  final TeamProfileState _value;
  // ignore: unused_field
  final $Res Function(TeamProfileState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Team?,
    ));
  }
}

/// @nodoc
abstract class _$$_TeamProfileStateCopyWith<$Res>
    implements $TeamProfileStateCopyWith<$Res> {
  factory _$$_TeamProfileStateCopyWith(
          _$_TeamProfileState value, $Res Function(_$_TeamProfileState) then) =
      __$$_TeamProfileStateCopyWithImpl<$Res>;
  @override
  $Res call({dynamic isLoading, Team? data});
}

/// @nodoc
class __$$_TeamProfileStateCopyWithImpl<$Res>
    extends _$TeamProfileStateCopyWithImpl<$Res>
    implements _$$_TeamProfileStateCopyWith<$Res> {
  __$$_TeamProfileStateCopyWithImpl(
      _$_TeamProfileState _value, $Res Function(_$_TeamProfileState) _then)
      : super(_value, (v) => _then(v as _$_TeamProfileState));

  @override
  _$_TeamProfileState get _value => super._value as _$_TeamProfileState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_TeamProfileState(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Team?,
    ));
  }
}

/// @nodoc

class _$_TeamProfileState implements _TeamProfileState {
  const _$_TeamProfileState({this.isLoading = false, this.data});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final Team? data;

  @override
  String toString() {
    return 'TeamProfileState(isLoading: $isLoading, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TeamProfileState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$$_TeamProfileStateCopyWith<_$_TeamProfileState> get copyWith =>
      __$$_TeamProfileStateCopyWithImpl<_$_TeamProfileState>(this, _$identity);
}

abstract class _TeamProfileState implements TeamProfileState {
  const factory _TeamProfileState({final dynamic isLoading, final Team? data}) =
      _$_TeamProfileState;

  @override
  dynamic get isLoading => throw _privateConstructorUsedError;
  @override
  Team? get data => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TeamProfileStateCopyWith<_$_TeamProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}
