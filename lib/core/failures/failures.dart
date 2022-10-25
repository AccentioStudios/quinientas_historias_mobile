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
  @JsonValue('password-error')
  password,
  @JsonValue('fields-error')
  fieldsError,

  // Auth Failures Type
  @JsonValue('must-update-password')
  mustUpdatePassword,
  @JsonValue('unauthorized')
  unauthorized,
  @JsonValue('invalid-access-token')
  invalidAccessToken,
  @JsonValue('user-is-not-active')
  userIsNotActive,
  @JsonValue('user-is-banned')
  userIsBanned,

  // User Register Failures Type
  @JsonValue('user-is-already-registered')
  userIsAlreadyRegistered,

  //IForgot Failures Type
  @JsonValue('iforgot-send-code-issue')
  sendCodeIssue,
  @JsonValue('iforgot-invalid-token')
  invalidToken,
  @JsonValue('iforgot-invalid-code')
  invalidCode,
  @JsonValue('iforgot-code-expired')
  codeExpired,

  //Invites Failures Type
  @JsonValue('user-already-invited')
  userAlreadyInvited,
  @JsonValue('invite-not-found')
  inviteNotFound,

  // Others
  @JsonValue('http-handle-error')
  httpHandleError,
  @JsonValue('network-error')
  networkError,
  @JsonValue('unknown')
  unknown,
}
