import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../data/models/response_wrapper.dart';
import '../failures/failures.dart';
import '../failures/status_codes.dart';

typedef HttpResponseMapper<T> = T Function(Object);
typedef HttpResponseJsonMapper<T> = T Function(Map<String, dynamic>);

extension HttpExtension on Future<Response> {
  Stream<T> handle<T>({required HttpResponseMapper<T> mapper}) async* {
    final Response response = await this;
    final ResponseWrapper wrapper = ResponseWrapper.parse(response);
    _checkFailures(wrapper);
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        yield mapper(response.data ?? {});
      } catch (error) {
        throw HttpFailure(message: FailureTypes.httpHandleError);
      }
    }
  }

  Stream<T> handleJson<T>({required HttpResponseJsonMapper<T> mapper}) async* {
    final Response response = await this;
    final ResponseWrapper wrapper = ResponseWrapper.parse(response);
    _checkFailures(wrapper);
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        yield mapper(response.data);
      } catch (error) {
        if (error is FormatException) {
          throw HttpFailure(message: FailureTypes.formatException);
        }
        throw HttpFailure(message: FailureTypes.httpHandleError);
      }
    } else {
      throw HttpFailure(message: FailureTypes.httpHandleError);
    }
  }
}

void _checkFailures(ResponseWrapper wrapper) {
  final StatusCodes httpStatus = wrapper.statusCode;

  if (httpStatus == StatusCodes.networkError) {
    throw HttpFailure(
        message: FailureTypes.networkError, statusCode: httpStatus);
  }

  if (httpStatus == StatusCodes.unknown) {
    throw HttpFailure(statusCode: httpStatus);
  }

  if (httpStatus != StatusCodes.ok && httpStatus != StatusCodes.created) {
    Map<String, dynamic>? errorBodyJson =
        json.decode((wrapper.response as Response).data);

    if (errorBodyJson != null) {
      final failure = HttpFailure.fromJson(errorBodyJson);

      FirebaseAnalytics.instance.logEvent(
        name: 'http',
        parameters: {
          "statusCode": failure.statusCode.toString(),
          "message": failure.message.toString(),
        },
      );
      throw failure;
    }
    throw HttpFailure(statusCode: httpStatus);
  }
}
