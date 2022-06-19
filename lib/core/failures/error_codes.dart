import 'package:freezed_annotation/freezed_annotation.dart';

enum ErrorCodes {
  unknown,
  @JsonValue('400')
  badRequest,

  @JsonValue('404')
  notFound,
}
