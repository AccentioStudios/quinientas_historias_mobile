// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpFailure _$HttpFailureFromJson(Map<String, dynamic> json) => HttpFailure(
      message: $enumDecodeNullable(_$FailureTypesEnumMap, json['message'],
          unknownValue: FailureTypes.unknown),
      statusCode:
          $enumDecodeNullable(_$StatusCodesEnumMap, json['statusCode']) ??
              StatusCodes.internalServerError,
    );

Map<String, dynamic> _$HttpFailureToJson(HttpFailure instance) =>
    <String, dynamic>{
      'message': _$FailureTypesEnumMap[instance.message],
      'statusCode': _$StatusCodesEnumMap[instance.statusCode],
    };

const _$FailureTypesEnumMap = {
  FailureTypes.email: 'email-error',
  FailureTypes.fieldsError: 'fields-error',
  FailureTypes.invalidCode: 'invalid-code',
  FailureTypes.unauthorized: 'unauthorized',
  FailureTypes.invalidAccessToken: 'invalid-access-token',
  FailureTypes.expiredAccessToken: 'expired-access-token',
  FailureTypes.signatureAccessTokenInvalid: 'signature-access-token-invalid',
  FailureTypes.userIsNotActive: 'user-is-not-active',
  FailureTypes.userIsBanned: 'user-is-banned',
  FailureTypes.roleNotValid: 'role-not-valid',
  FailureTypes.existingUserLogin: 'existing-user-login',
  FailureTypes.userAlreadyInvited: 'user-already-invited',
  FailureTypes.inviteNotFound: 'invite-not-found',
  FailureTypes.invalidInvitationCode: 'invalid-invitation-code',
  FailureTypes.inviterDontBelongToTheTeam: 'inviter-dont-belong-to-the-team',
  FailureTypes.inviterDontBelongToTheSchool: 'inviter-dont-belong-to-the-team',
  FailureTypes.inviteBelongToAnotherUser: 'invite-belong-to-another-user',
  FailureTypes.formatException: 'format-exception',
  FailureTypes.httpHandleError: 'http-handle-error',
  FailureTypes.networkError: 'network-error',
  FailureTypes.tooManyRequests: 'too-many-requests',
  FailureTypes.unknown: 'unknown',
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
  StatusCodes.tooManyRequests: 429,
  StatusCodes.iforgotError: 452,
};
