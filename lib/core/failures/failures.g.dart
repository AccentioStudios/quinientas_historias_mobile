// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpFailure _$HttpFailureFromJson(Map<String, dynamic> json) => HttpFailure(
      message: $enumDecodeNullable(_$FailureTypeEnumMap, json['message'],
          unknownValue: FailureType.unknown),
      statusCode:
          $enumDecodeNullable(_$StatusCodesEnumMap, json['statusCode']) ??
              StatusCodes.internalServerError,
    );

Map<String, dynamic> _$HttpFailureToJson(HttpFailure instance) =>
    <String, dynamic>{
      'message': _$FailureTypeEnumMap[instance.message],
      'statusCode': _$StatusCodesEnumMap[instance.statusCode],
    };

const _$FailureTypeEnumMap = {
  FailureType.email: 'email-error',
  FailureType.fieldsError: 'fields-error',
  FailureType.invalidCode: 'invalid-code',
  FailureType.unauthorized: 'unauthorized',
  FailureType.invalidAccessToken: 'invalid-access-token',
  FailureType.expiredAccessToken: 'expired-access-token',
  FailureType.signatureAccessTokenInvalid: 'signature-access-token-invalid',
  FailureType.userIsNotActive: 'user-is-not-active',
  FailureType.userIsBanned: 'user-is-banned',
  FailureType.roleNotValid: 'role-not-valid',
  FailureType.userAlreadyInvited: 'user-already-invited',
  FailureType.inviteNotFound: 'invite-not-found',
  FailureType.formatException: 'format-exception',
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
  StatusCodes.created: 201,
  StatusCodes.badRequest: 400,
  StatusCodes.unauthorized: 401,
  StatusCodes.fordbidden: 403,
  StatusCodes.notFound: 404,
  StatusCodes.internalServerError: 500,
  StatusCodes.iforgotError: 452,
};
