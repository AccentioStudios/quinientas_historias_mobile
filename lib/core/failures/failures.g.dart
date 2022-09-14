// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpFailure _$HttpFailureFromJson(Map<String, dynamic> json) => HttpFailure(
      message: json['message'] as String?,
      error: $enumDecodeNullable(_$FailureTypeEnumMap, json['error']),
      statusCode:
          $enumDecodeNullable(_$StatusCodesEnumMap, json['statusCode']) ??
              StatusCodes.unknown,
    );

Map<String, dynamic> _$HttpFailureToJson(HttpFailure instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': _$FailureTypeEnumMap[instance.error],
      'statusCode': _$StatusCodesEnumMap[instance.statusCode],
    };

const _$FailureTypeEnumMap = {
  FailureType.email: 'email-error',
  FailureType.password: 'password-error',
  FailureType.mustUpdatePassword: 'must-update-password',
  FailureType.unauthorized: 'unauthorized',
  FailureType.invalidAccessToken: 'invalid-access-token',
  FailureType.sendCodeIssue: 'iforgot-send-code-issue',
  FailureType.invalidToken: 'iforgot-invalid-token',
  FailureType.invalidCode: 'iforgot-invalid-code',
  FailureType.codeExpired: 'iforgot-code-expired',
  FailureType.userAlreadyInvited: 'user-already-invited',
  FailureType.httpHandleError: 'http-handle-error',
  FailureType.networkError: 'network-error',
  FailureType.unknown: 'unknown',
};

const _$StatusCodesEnumMap = {
  StatusCodes.clientException: 'clientException',
  StatusCodes.formatException: 'formatException',
  StatusCodes.networkError: 'networkError',
  StatusCodes.unknown: 'unknown',
  StatusCodes.ok: 200,
  StatusCodes.badRequest: 400,
  StatusCodes.unauthorized: 401,
  StatusCodes.fordbidden: 403,
  StatusCodes.notFound: 404,
  StatusCodes.internalServerError: 500,
  StatusCodes.iforgotError: 452,
};
