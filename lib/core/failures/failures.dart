import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/failures/status_codes.dart';

part 'failures.g.dart';

@JsonSerializable()
class HttpFailure implements Exception {
  HttpFailure(
      {this.message, this.error, this.statusCode = StatusCodes.unknown});
  final dynamic message;
  final FailureType? error;
  final StatusCodes? statusCode;

  factory HttpFailure.fromJson(Map<String, dynamic> json) =>
      _$HttpFailureFromJson(json);
  Map<String, dynamic> toJson() => _$HttpFailureToJson(this);

  @override
  String toString() =>
      'HttpFailure: $message, error: $error, statusCode: $statusCode';
}

enum FailureType {
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

  //Invites Failures Type
  @JsonValue('user-already-invited')
  userAlreadyInvited,
  @JsonValue('invite-not-found')
  inviteNotFound,

  // Others
  @JsonValue('format-exception')
  formatException,
  @JsonValue('http-handle-error')
  httpHandleError,
  @JsonValue('network-error')
  networkError,
  @JsonValue('unknown')
  unknown,
}
