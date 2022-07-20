// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iforgot_failure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IForgotFailure _$IForgotFailureFromJson(Map<String, dynamic> json) =>
    IForgotFailure(
      message: json['message'] as String?,
      error: $enumDecodeNullable(_$IForgotFailureTypeEnumMap, json['error']) ??
          IForgotFailureType.unknown,
    );

Map<String, dynamic> _$IForgotFailureToJson(IForgotFailure instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': _$IForgotFailureTypeEnumMap[instance.error],
    };

const _$IForgotFailureTypeEnumMap = {
  IForgotFailureType.email: 'iforgot-email-error',
  IForgotFailureType.sendCodeIssue: 'iforgot-send-code-issue',
  IForgotFailureType.invalidToken: 'iforgot-invalid-token',
  IForgotFailureType.invalidCode: 'iforgot-invalid-code',
  IForgotFailureType.codeExpired: 'iforgot-code-expired',
  IForgotFailureType.unknown: 'unknown',
};
