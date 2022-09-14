import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/failures/status_codes.dart';

part 'failures.g.dart';

@JsonSerializable()
class HttpFailure implements Exception {
  HttpFailure(
      {this.message, this.error, this.statusCode = StatusCodes.unknown});
  final String? message;
  final FailureType? error;
  final StatusCodes? statusCode;

  factory HttpFailure.fromJson(Map<String, dynamic> json) =>
      _$HttpFailureFromJson(json);
  Map<String, dynamic> toJson() => _$HttpFailureToJson(this);
}

enum FailureType {
  // Fields Failures Type
  @JsonValue('email-error')
  email,
  @JsonValue('password-error')
  password,

  // Auth Failures Type
  @JsonValue('must-update-password')
  mustUpdatePassword,
  @JsonValue('unauthorized')
  unauthorized,
  @JsonValue('invalid-access-token')
  invalidAccessToken,

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
  @JsonValue('invite-bad-request')

  // Others
  @JsonValue('http-handle-error')
  httpHandleError,
  @JsonValue('network-error')
  networkError,
  @JsonValue('unknown')
  unknown,
}
