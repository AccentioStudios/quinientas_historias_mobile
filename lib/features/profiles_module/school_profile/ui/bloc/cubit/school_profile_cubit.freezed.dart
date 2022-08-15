// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'school_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SchoolProfileState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  SchoolProfile? get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SchoolProfileStateCopyWith<SchoolProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchoolProfileStateCopyWith<$Res> {
  factory $SchoolProfileStateCopyWith(
          SchoolProfileState value, $Res Function(SchoolProfileState) then) =
      _$SchoolProfileStateCopyWithImpl<$Res>;
  $Res call({dynamic isLoading, SchoolProfile? data});
}

/// @nodoc
class _$SchoolProfileStateCopyWithImpl<$Res>
    implements $SchoolProfileStateCopyWith<$Res> {
  _$SchoolProfileStateCopyWithImpl(this._value, this._then);

  final SchoolProfileState _value;
  // ignore: unused_field
  final $Res Function(SchoolProfileState) _then;

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
              as SchoolProfile?,
    ));
  }
}

/// @nodoc
abstract class _$$_SchoolProfileStateCopyWith<$Res>
    implements $SchoolProfileStateCopyWith<$Res> {
  factory _$$_SchoolProfileStateCopyWith(_$_SchoolProfileState value,
          $Res Function(_$_SchoolProfileState) then) =
      __$$_SchoolProfileStateCopyWithImpl<$Res>;
  @override
  $Res call({dynamic isLoading, SchoolProfile? data});
}

/// @nodoc
class __$$_SchoolProfileStateCopyWithImpl<$Res>
    extends _$SchoolProfileStateCopyWithImpl<$Res>
    implements _$$_SchoolProfileStateCopyWith<$Res> {
  __$$_SchoolProfileStateCopyWithImpl(
      _$_SchoolProfileState _value, $Res Function(_$_SchoolProfileState) _then)
      : super(_value, (v) => _then(v as _$_SchoolProfileState));

  @override
  _$_SchoolProfileState get _value => super._value as _$_SchoolProfileState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_SchoolProfileState(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SchoolProfile?,
    ));
  }
}

/// @nodoc

class _$_SchoolProfileState implements _SchoolProfileState {
  const _$_SchoolProfileState({this.isLoading = false, this.data});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final SchoolProfile? data;

  @override
  String toString() {
    return 'SchoolProfileState(isLoading: $isLoading, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SchoolProfileState &&
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
  _$$_SchoolProfileStateCopyWith<_$_SchoolProfileState> get copyWith =>
      __$$_SchoolProfileStateCopyWithImpl<_$_SchoolProfileState>(
          this, _$identity);
}

abstract class _SchoolProfileState implements SchoolProfileState {
  const factory _SchoolProfileState(
      {final dynamic isLoading,
      final SchoolProfile? data}) = _$_SchoolProfileState;

  @override
  dynamic get isLoading => throw _privateConstructorUsedError;
  @override
  SchoolProfile? get data => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SchoolProfileStateCopyWith<_$_SchoolProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}
