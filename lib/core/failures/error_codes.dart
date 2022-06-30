import 'package:freezed_annotation/freezed_annotation.dart';

enum StatusCodes {
  unknown,
  @JsonValue('200')
  ok,
  @JsonValue('400')
  badRequest,
  @JsonValue('401')
  unauthorized,
  @JsonValue('403')
  fordbidden,
  @JsonValue('404')
  notFound,
  @JsonValue('500')
  internalServerError,
}
