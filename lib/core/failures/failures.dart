import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/failures/status_codes.dart';

part 'failures.g.dart';

@JsonSerializable()
class HttpFailure implements Exception {
  HttpFailure({this.message, this.statusCode = StatusCodes.unknown});
  @JsonKey(unknownEnumValue: FailureTypes.unknown)
  final FailureTypes? message;
  @JsonKey(defaultValue: StatusCodes.internalServerError)
  final StatusCodes? statusCode;

  factory HttpFailure.build(String messageText, int statusCode) {
    return HttpFailure(
      message: $enumDecodeNullable(_$FailureTypesEnumMap, messageText,
          unknownValue: FailureTypes.unknown),
      statusCode: $enumDecodeNullable(_$StatusCodesEnumMap, statusCode) ??
          StatusCodes.internalServerError,
    );
  }

  factory HttpFailure.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('message')) {
      return _$HttpFailureFromJson(json);
    }
    return HttpFailure();
  }
  Map<String, dynamic> toJson() => _$HttpFailureToJson(this);

  @override
  String toString() => 'HttpFailure: $message, statusCode: $statusCode';
}

enum FailureTypes {
  // Fields Failures Type
  @JsonValue('email-error')
  email,
  @JsonValue('fields-error')
  fieldsError,
  @JsonValue('invalid-code')
  invalidCode,

  // Auth Failures Type
  @JsonValue('unauthorized')
  unauthorized,
  @JsonValue('invalid-access-token')
  invalidAccessToken,
  @JsonValue('expired-access-token')
  expiredAccessToken,
  @JsonValue('signature-access-token-invalid')
  signatureAccessTokenInvalid,
  @JsonValue('user-is-not-active')
  userIsNotActive,
  @JsonValue('user-is-banned')
  userIsBanned,
  @JsonValue('role-not-valid')
  roleNotValid,
  @JsonValue('existing-user-login')
  existingUserLogin,

  //Invites Failures Type
  @JsonValue('user-already-invited')
  userAlreadyInvited,
  @JsonValue('invite-not-found')
  inviteNotFound,
  @JsonValue('invalid-invitation-code')
  invalidInvitationCode,
  @JsonValue('inviter-dont-belong-to-the-team')
  inviterDontBelongToTheTeam,
  @JsonValue('inviter-dont-belong-to-the-team')
  inviterDontBelongToTheSchool,
  @JsonValue('invite-belong-to-another-user')
  inviteBelongToAnotherUser,

  // Others

  @JsonValue('format-exception')
  formatException,
  @JsonValue('http-handle-error')
  httpHandleError,
  @JsonValue('network-error')
  networkError,
  unknown,
}
