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
  dynamic get canEdit => throw _privateConstructorUsedError;
  School? get data => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SchoolProfileStateCopyWith<SchoolProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SchoolProfileStateCopyWith<$Res> {
  factory $SchoolProfileStateCopyWith(
          SchoolProfileState value, $Res Function(SchoolProfileState) then) =
      _$SchoolProfileStateCopyWithImpl<$Res>;
  $Res call({dynamic isLoading, dynamic canEdit, School? data, User? user});
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
    Object? canEdit = freezed,
    Object? data = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      canEdit: canEdit == freezed
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as dynamic,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as School?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
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
  $Res call({dynamic isLoading, dynamic canEdit, School? data, User? user});
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
    Object? canEdit = freezed,
    Object? data = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_SchoolProfileState(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading,
      canEdit: canEdit == freezed ? _value.canEdit : canEdit,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as School?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc

class _$_SchoolProfileState implements _SchoolProfileState {
  const _$_SchoolProfileState(
      {this.isLoading = false, this.canEdit = false, this.data, this.user});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  @JsonKey()
  final dynamic canEdit;
  @override
  final School? data;
  @override
  final User? user;

  @override
  String toString() {
    return 'SchoolProfileState(isLoading: $isLoading, canEdit: $canEdit, data: $data, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SchoolProfileState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.canEdit, canEdit) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(canEdit),
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$$_SchoolProfileStateCopyWith<_$_SchoolProfileState> get copyWith =>
      __$$_SchoolProfileStateCopyWithImpl<_$_SchoolProfileState>(
          this, _$identity);
}

abstract class _SchoolProfileState implements SchoolProfileState {
  const factory _SchoolProfileState(
      {final dynamic isLoading,
      final dynamic canEdit,
      final School? data,
      final User? user}) = _$_SchoolProfileState;

  @override
  dynamic get isLoading => throw _privateConstructorUsedError;
  @override
  dynamic get canEdit => throw _privateConstructorUsedError;
  @override
  School? get data => throw _privateConstructorUsedError;
  @override
  User? get user => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SchoolProfileStateCopyWith<_$_SchoolProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}
