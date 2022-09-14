import 'dart:convert';

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
      throw HttpFailure.fromJson(errorBodyJson);
    }
    throw HttpFailure(statusCode: httpStatus);

    // switch (httpStatus) {
    //   case StatusCodes.networkError:
    //     throw NetworkFailure();
    //   case StatusCodes.badRequest:
    //     if (errorBodyJson != null) {
    //       throw Failure.fromJson(errorBodyJson);
    //     }
    //     throw BadRequestFailure();
    //   case StatusCodes.notFound:
    //     throw NotFoundFailure();
    //   case StatusCodes.unauthorized:
    //     if (errorBodyJson != null) {
    //       throw AuthFailure.fromJson(errorBodyJson);
    //     }
    //     throw AuthFailure();
    //   case StatusCodes.internalServerError:
    //     if (errorBodyJson != null) {
    //       throw CommonFailure.fromJson(errorBodyJson);
    //     }
    //     throw CommonFailure();

    //   case StatusCodes.iforgotError:
    //     if (errorBodyJson != null) {
    //       throw IForgotFailure.fromJson(errorBodyJson);
    //     }
    //     throw IForgotFailure();

    //   case StatusCodes.mustUpdatePassword:
    //     if (errorBodyJson != null) {
    //       throw AuthFailure.fromJson(errorBodyJson);
    //     }
    //     throw AuthFailure(error: AuthFailureType.mustUpdatePassword);

    //   default:
    //     throw UnknownFailure();
    // }
  }
}
