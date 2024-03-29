import 'package:freezed_annotation/freezed_annotation.dart';

enum StatusCodes {
  clientException,
  formatException,
  networkError,
  unknown,
  @JsonValue(200)
  ok,
  @JsonValue(201)
  created,
  @JsonValue(400)
  badRequest,
  @JsonValue(401)
  unauthorized,
  @JsonValue(403)
  fordbidden,
  @JsonValue(404)
  notFound,
  @JsonValue(500)
  internalServerError,

  @JsonValue(429)
  tooManyRequests,

  // Custom errors

  @JsonValue(452)
  iforgotError,
}
