import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/failures/status_codes.dart';

part 'failures.g.dart';

@JsonSerializable()
class Failure implements Exception {
  Failure({this.message, this.error, this.statusCode});
  final String? message;
  final Object? error;
  final StatusCodes? statusCode;

  factory Failure.fromJson(Map<String, dynamic> json) =>
      _$FailureFromJson(json);
  Map<String, dynamic> toJson() => _$FailureToJson(this);
}

class UnknownFailure extends Failure {}

class NetworkFailure extends Failure {}
