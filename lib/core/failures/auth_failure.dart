import 'package:freezed_annotation/freezed_annotation.dart';

import 'failures.dart';

part 'auth_failure.g.dart';

@JsonSerializable()
class AuthFailure extends Failure {
  AuthFailure({this.message, this.errorType = AuthFailureType.unknown});
  final String? message;
  final AuthFailureType? errorType;

  factory AuthFailure.fromJson(Map<String, dynamic> json) =>
      _$AuthFailureFromJson(json);
  Map<String, dynamic> toJson() => _$AuthFailureToJson(this);
}

enum AuthFailureType {
  @JsonValue('email-error')
  email,
  @JsonValue('password-error')
  password,
  @JsonValue('must-update-password')
  mustUpdatePassword,
  @JsonValue('unauthorized')
  unauthorized,
  @JsonValue('invalid-access-token')
  invalidAccessToken,
  @JsonValue('unknown')
  unknown,
}
