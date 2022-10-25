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
  School? get school => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SchoolProfileStateCopyWith<SchoolProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchoolProfileStateCopyWith<$Res> {
  factory $SchoolProfileStateCopyWith(
          SchoolProfileState value, $Res Function(SchoolProfileState) then) =
      _$SchoolProfileStateCopyWithImpl<$Res, SchoolProfileState>;
  @useResult
  $Res call({dynamic isLoading, School? school});
}

/// @nodoc
class _$SchoolProfileStateCopyWithImpl<$Res, $Val extends SchoolProfileState>
    implements $SchoolProfileStateCopyWith<$Res> {
  _$SchoolProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? school = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      school: freezed == school
          ? _value.school
          : school // ignore: cast_nullable_to_non_nullable
              as School?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SchoolProfileStateCopyWith<$Res>
    implements $SchoolProfileStateCopyWith<$Res> {
  factory _$$_SchoolProfileStateCopyWith(_$_SchoolProfileState value,
          $Res Function(_$_SchoolProfileState) then) =
      __$$_SchoolProfileStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic isLoading, School? school});
}

/// @nodoc
class __$$_SchoolProfileStateCopyWithImpl<$Res>
    extends _$SchoolProfileStateCopyWithImpl<$Res, _$_SchoolProfileState>
    implements _$$_SchoolProfileStateCopyWith<$Res> {
  __$$_SchoolProfileStateCopyWithImpl(
      _$_SchoolProfileState _value, $Res Function(_$_SchoolProfileState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? school = freezed,
  }) {
    return _then(_$_SchoolProfileState(
      isLoading: null == isLoading ? _value.isLoading : isLoading,
      school: freezed == school
          ? _value.school
          : school // ignore: cast_nullable_to_non_nullable
              as School?,
    ));
  }
}

/// @nodoc

class _$_SchoolProfileState implements _SchoolProfileState {
  const _$_SchoolProfileState({this.isLoading = false, this.school});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final School? school;

  @override
  String toString() {
    return 'SchoolProfileState(isLoading: $isLoading, school: $school)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SchoolProfileState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            (identical(other.school, school) || other.school == school));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(isLoading), school);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SchoolProfileStateCopyWith<_$_SchoolProfileState> get copyWith =>
      __$$_SchoolProfileStateCopyWithImpl<_$_SchoolProfileState>(
          this, _$identity);
}

abstract class _SchoolProfileState implements SchoolProfileState {
  const factory _SchoolProfileState(
      {final dynamic isLoading, final School? school}) = _$_SchoolProfileState;

  @override
  dynamic get isLoading;
  @override
  School? get school;
  @override
  @JsonKey(ignore: true)
  _$$_SchoolProfileStateCopyWith<_$_SchoolProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}
