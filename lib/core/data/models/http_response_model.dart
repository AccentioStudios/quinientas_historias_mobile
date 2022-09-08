import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

import '../../exceptions/http_request_exception.dart';
import '../../failures/status_codes.dart';

part 'http_response_model.g.dart';

@JsonSerializable()
class HttpResponse {
  HttpResponse({
    this.body,
    this.statusCode = StatusCodes.unknown,
    this.headers,
    this.stackTrace,
  });

  HttpResponse parse(dynamic response) {
    try {
      if (response is Response) {
        // ignore: no_leading_underscores_for_local_identifiers
        HttpResponse _this = this;
        HttpResponse httpResponse = HttpResponse(
          body: response.body,
          statusCode:
              $enumDecodeNullable(_$StatusCodesEnumMap, response.statusCode) ??
                  StatusCodes.unknown,
          headers: _this.headers,
        );
        return httpResponse;
      } else if (response is HttpRequestException) {
        // If we cant reach the server because connectivity issues or server down
        if (response.exception is SocketException) {
          return HttpResponse(body: null, statusCode: StatusCodes.networkError);
        }
        throw response.exception as Exception;
      } else {
        return HttpResponse(
          body: response.state,
          statusCode:
              $enumDecodeNullable(_$StatusCodesEnumMap, response.statusCode) ??
                  StatusCodes.unknown,
        );
      }
    } catch (err) {
      return HttpResponse(body: null, statusCode: StatusCodes.unknown);
    }
  }

  final String? body;
  @JsonKey(defaultValue: StatusCodes.unknown)
  StatusCodes statusCode;
  final Map<String, String>? headers;
  final Object? stackTrace;

  bool isSuccess() {
    return statusCode == StatusCodes.ok;
  }
}
