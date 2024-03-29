import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../failures/status_codes.dart';

part 'response_wrapper.g.dart';

@JsonSerializable()
class ResponseWrapper {
  ResponseWrapper({
    required this.response,
    this.statusCode = StatusCodes.unknown,
  });

  factory ResponseWrapper.parse(dynamic response) {
    try {
      ResponseWrapper wrapper = ResponseWrapper(
        response: response,
        statusCode:
            $enumDecodeNullable(_$StatusCodesEnumMap, response.statusCode) ??
                StatusCodes.unknown,
      );
      return wrapper;
    } catch (err) {
      if (kDebugMode) {
        print('error at ResponseWrapper parse');
      }
      return ResponseWrapper(response: response);
    }
  }

  factory ResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$ResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseWrapperToJson(this);

  final Object response;
  @JsonKey(defaultValue: StatusCodes.unknown)
  StatusCodes statusCode;

  bool isSuccess() {
    return statusCode == StatusCodes.ok;
  }
}
