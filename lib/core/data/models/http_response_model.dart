import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

import '../../failures/error_codes.dart';
import 'http_status_model.dart';

part 'http_response_model.g.dart';

@JsonSerializable()
class HttpResponse {
  HttpResponse({
    this.body,
    this.jsonData,
    this.status,
    this.headers,
    this.stackTrace,
  });

  HttpResponse jsonDecode(Response response) {
    HttpResponse _this = this;

    Map<String, dynamic>? responseBodyJson = json.decode(response.body);
    HttpStatusModel status = HttpStatusModel.fromJson({
      "message": "",
      "statusCode": response.statusCode.toString(),
    });

    HttpResponse httpResponse = HttpResponse(
      body: response.body,
      jsonData: responseBodyJson,
      status: status,
      headers: _this.headers,
    );
    return httpResponse;
  }

  final String? body;
  final Map<String, dynamic>? jsonData;
  final HttpStatusModel? status;
  final Map<String, String>? headers;
  final Object? stackTrace;

  Map<String, dynamic> toJson() => _$HttpResponseToJson(this);

  bool isSuccess() {
    return status?.statusCode == StatusCodes.ok;
  }
}
