// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_failure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthFailure _$AuthFailureFromJson(Map<String, dynamic> json) => AuthFailure(
      message: json['message'] as String?,
      error: $enumDecodeNullable(_$AuthFailureTypeEnumMap, json['error']) ??
          AuthFailureType.unknown,
    );

Map<String, dynamic> _$AuthFailureToJson(AuthFailure instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': _$AuthFailureTypeEnumMap[instance.error],
    };

const _$AuthFailureTypeEnumMap = {
  AuthFailureType.email: 'email-error',
  AuthFailureType.password: 'password-error',
  AuthFailureType.mustUpdatePassword: 'must-update-password',
  AuthFailureType.unauthorized: 'unauthorized',
  AuthFailureType.invalidAccessToken: 'invalid-access-token',
  AuthFailureType.unknown: 'unknown',
};
