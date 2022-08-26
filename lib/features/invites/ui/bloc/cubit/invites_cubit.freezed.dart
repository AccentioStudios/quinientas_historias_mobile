// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'invites_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InvitesState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InvitesStateCopyWith<InvitesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitesStateCopyWith<$Res> {
  factory $InvitesStateCopyWith(
          InvitesState value, $Res Function(InvitesState) then) =
      _$InvitesStateCopyWithImpl<$Res>;
  $Res call({dynamic isLoading, User? user});
}

/// @nodoc
class _$InvitesStateCopyWithImpl<$Res> implements $InvitesStateCopyWith<$Res> {
  _$InvitesStateCopyWithImpl(this._value, this._then);

  final InvitesState _value;
  // ignore: unused_field
  final $Res Function(InvitesState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
abstract class _$$_InvitesStateCopyWith<$Res>
    implements $InvitesStateCopyWith<$Res> {
  factory _$$_InvitesStateCopyWith(
          _$_InvitesState value, $Res Function(_$_InvitesState) then) =
      __$$_InvitesStateCopyWithImpl<$Res>;
  @override
  $Res call({dynamic isLoading, User? user});
}

/// @nodoc
class __$$_InvitesStateCopyWithImpl<$Res>
    extends _$InvitesStateCopyWithImpl<$Res>
    implements _$$_InvitesStateCopyWith<$Res> {
  __$$_InvitesStateCopyWithImpl(
      _$_InvitesState _value, $Res Function(_$_InvitesState) _then)
      : super(_value, (v) => _then(v as _$_InvitesState));

  @override
  _$_InvitesState get _value => super._value as _$_InvitesState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_InvitesState(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc

class _$_InvitesState implements _InvitesState {
  const _$_InvitesState({this.isLoading = false, this.user});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final User? user;

  @override
  String toString() {
    return 'InvitesState(isLoading: $isLoading, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InvitesState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$$_InvitesStateCopyWith<_$_InvitesState> get copyWith =>
      __$$_InvitesStateCopyWithImpl<_$_InvitesState>(this, _$identity);
}

abstract class _InvitesState implements InvitesState {
  const factory _InvitesState({final dynamic isLoading, final User? user}) =
      _$_InvitesState;

  @override
  dynamic get isLoading => throw _privateConstructorUsedError;
  @override
  User? get user => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_InvitesStateCopyWith<_$_InvitesState> get copyWith =>
      throw _privateConstructorUsedError;
}
