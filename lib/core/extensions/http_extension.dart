import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:http/http.dart';

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
    if (response.statusCode == 200) {
      try {
        yield mapper(response.body);
      } catch (error) {
        throw HttpFailure(error: FailureType.httpHandleError);
      }
    }
  }

  Stream<T> handleJson<T>({required HttpResponseJsonMapper<T> mapper}) async* {
    final Response response = await this;
    final ResponseWrapper wrapper = ResponseWrapper.parse(response);

    _checkFailures(wrapper);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBodyJson = json.decode(response.body);
      try {
        yield mapper(responseBodyJson);
      } catch (error) {
        if (error is FormatException) {
          throw HttpFailure(
              error: FailureType.formatException, message: error.message);
        }
        throw HttpFailure(error: FailureType.httpHandleError);
      }
    } else {
      throw HttpFailure(error: FailureType.httpHandleError);
    }
  }
}

void _checkFailures(ResponseWrapper wrapper) {
  final StatusCodes httpStatus = wrapper.statusCode;

  if (httpStatus == StatusCodes.networkError) {
    throw HttpFailure(error: FailureType.networkError, statusCode: httpStatus);
  }

  if (httpStatus == StatusCodes.unknown) {
    throw HttpFailure(statusCode: httpStatus);
  }

  if (httpStatus != StatusCodes.ok) {
    Map<String, dynamic>? errorBodyJson =
        json.decode((wrapper.response as Response).body);

    if (errorBodyJson != null) {
      final failure = HttpFailure.fromJson(errorBodyJson);

      FirebaseAnalytics.instance.logEvent(
        name: failure.error.toString(),
        parameters: {
          "statusCode": failure.statusCode.toString(),
          "message": failure.message,
        },
      );
      throw failure;
    }
    throw HttpFailure(statusCode: httpStatus);
  }
}
