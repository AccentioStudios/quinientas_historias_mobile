import 'package:freezed_annotation/freezed_annotation.dart';

import 'failures.dart';

part 'common_failure.g.dart';

@JsonSerializable()
class CommonFailure extends Failure {
  CommonFailure({this.message, this.error = CommonFailureType.unknown});
  final String? message;
  final CommonFailureType? error;

  factory CommonFailure.fromJson(Map<String, dynamic> json) =>
      _$CommonFailureFromJson(json);
  Map<String, dynamic> toJson() => _$CommonFailureToJson(this);
}

enum CommonFailureType {
  @JsonValue('unknown')
  unknown,
}
