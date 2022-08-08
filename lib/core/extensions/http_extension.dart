import 'dart:convert';

import 'package:quinientas_historias/core/failures/iforgot_failure.dart';
import 'package:quinientas_historias/core/failures/network_failure.dart';

import '../data/models/http_response_model.dart';
import '../failures/auth_failure.dart';
import '../failures/common_failure.dart';
import '../failures/status_codes.dart';
import '../failures/failures.dart';

typedef HttpResponseMapper<T> = T Function(Object);
typedef HttpResponseJsonMapper<T> = T Function(Map<String, dynamic>);

extension HttpExtension on Future<HttpResponse> {
  Stream<T> handle<T>({required HttpResponseMapper<T> mapper}) async* {
    final HttpResponse response = await this;
    _checkFailures(response);
    if (response.isSuccess() && response.body != null) {
      try {
        yield mapper(response.body!);
      } catch (error) {
        throw HttpHandleFailure(error: error);
      }
    }
  }

  Stream<T> handleJson<T>({required HttpResponseJsonMapper<T> mapper}) async* {
    final HttpResponse response = await this;
    _checkFailures(response);
    if (response.isSuccess() && response.body != null) {
      Map<String, dynamic> responseBodyJson = json.decode(response.body!);
      try {
        yield mapper(responseBodyJson);
      } catch (error) {
        throw HttpHandleFailure(error: error);
      }
    } else {
      throw HttpHandleFailure(error: 'no json data');
    }
  }
}

void _checkFailures(HttpResponse response) {
  final StatusCodes httpStatus = response.statusCode;

  if (httpStatus == StatusCodes.networkError) {
    throw NetworkFailure();
  }

  if (httpStatus == StatusCodes.unknown) {
    throw UnknownFailure();
  }

  if (httpStatus != StatusCodes.ok) {
    Map<String, dynamic>? errorBodyJson = json.decode(response.body!);

    switch (httpStatus) {
      case StatusCodes.networkError:
        throw NetworkFailure();
      case StatusCodes.badRequest:
        throw CommonFailure();
      case StatusCodes.notFound:
        throw CommonFailure();
      case StatusCodes.unauthorized:
        if (errorBodyJson != null) {
          throw AuthFailure.fromJson(errorBodyJson);
        }
        throw AuthFailure();
      case StatusCodes.internalServerError:
        if (errorBodyJson != null) {
          throw CommonFailure.fromJson(errorBodyJson);
        }
        throw CommonFailure();

      case StatusCodes.iforgotError:
        if (errorBodyJson != null) {
          throw IForgotFailure.fromJson(errorBodyJson);
        }
        throw IForgotFailure();

      case StatusCodes.mustUpdatePassword:
        if (errorBodyJson != null) {
          throw AuthFailure.fromJson(errorBodyJson);
        }
        throw AuthFailure(error: AuthFailureType.mustUpdatePassword);

      default:
        throw UnknownFailure();
    }
  }
}
