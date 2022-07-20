import 'package:freezed_annotation/freezed_annotation.dart';

import 'failures.dart';

part 'iforgot_failure.g.dart';

@JsonSerializable()
class IForgotFailure extends Failure {
  IForgotFailure({this.message, this.error = IForgotFailureType.unknown});
  final String? message;
  final IForgotFailureType? error;

  factory IForgotFailure.fromJson(Map<String, dynamic> json) =>
      _$IForgotFailureFromJson(json);
  Map<String, dynamic> toJson() => _$IForgotFailureToJson(this);
}

enum IForgotFailureType {
  @JsonValue('iforgot-email-error')
  email,
  @JsonValue('iforgot-send-code-issue')
  sendCodeIssue,
  @JsonValue('iforgot-invalid-token')
  invalidToken,
  @JsonValue('iforgot-invalid-code')
  invalidCode,
  @JsonValue('iforgot-code-expired')
  codeExpired,
  @JsonValue('unknown')
  unknown,
}
