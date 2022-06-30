import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../failures/error_codes.dart';
import 'http_response_model.dart';

part 'http_status_model.g.dart';

@JsonSerializable()
class HttpStatusModel {
  HttpStatusModel({this.message, this.statusCode});

  factory HttpStatusModel.fromJson(Map<String, dynamic> json) =>
      _$HttpStatusModelFromJson(json);
  Map<String, dynamic> toJson() => _$HttpStatusModelToJson(this);

  String? message;
  @JsonKey(defaultValue: StatusCodes.unknown)
  StatusCodes? statusCode;
}
