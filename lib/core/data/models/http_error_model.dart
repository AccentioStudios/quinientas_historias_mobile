import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mama_africa_app/core/data/models/http_response_model.dart';

import '../../failures/error_codes.dart';

part 'http_error_model.g.dart';

@JsonSerializable()
class HttpErrorModel {
  HttpErrorModel({this.message, this.errorCode});
  factory HttpErrorModel.fromHttpResponse(HttpResponse httpResponse) {
    Map<String, dynamic>? responseDataJson =
        json.decode(httpResponse.data!) as Map<String, dynamic>;
    responseDataJson['errorCode'] = httpResponse.statusCode;
    return _$HttpErrorModelFromJson(responseDataJson);
  }
  Map<String, dynamic> toJson() => _$HttpErrorModelToJson(this);

  String? message;
  @JsonKey(defaultValue: ErrorCodes.unknown)
  ErrorCodes? errorCode;
}
