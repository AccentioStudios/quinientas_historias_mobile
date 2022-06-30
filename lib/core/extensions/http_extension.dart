import '../data/models/http_status_model.dart';
import '../data/models/http_response_model.dart';
import '../failures/error_codes.dart';
import '../failures/failures.dart';

typedef HttpResponseMapper<T> = T Function(Object);
typedef HttpResponseJsonMapper<T> = T Function(Map<String, dynamic>);

extension HttpExtension on Future<HttpResponse> {
  Stream<T> handle<T>({required HttpResponseMapper<T> mapper}) async* {
    final HttpResponse response = await this;
    if (response.isSuccess() && response.body != null) {
      try {
        yield mapper(response.body!);
      } catch (error) {
        throw HttpHandleFailure(error: error);
      }
    }
    _checkFailures(response);
  }

  Stream<T> handleJson<T>({required HttpResponseJsonMapper<T> mapper}) async* {
    final HttpResponse response = await this;
    if (response.isSuccess()) {
      if (response.jsonData == null) {
        throw HttpHandleFailure(error: 'no json data');
      }
      try {
        yield mapper(response.jsonData!);
      } catch (error) {
        throw HttpHandleFailure(error: error);
      }
    }
    _checkFailures(response);
  }
}

void _checkFailures(HttpResponse response) {
  final HttpStatusModel? httpStatus = response.status;

  if (httpStatus == null) {
    throw UnknownFailure();
  }

  if (httpStatus.statusCode != StatusCodes.ok) {
    if (response.body != null) {
      switch (httpStatus.statusCode) {
        case StatusCodes.ok:
          break;
        case StatusCodes.unknown:
          throw UnknownFailure();
        case StatusCodes.badRequest:
          throw CommonFailure(httpStatus.message);
        case StatusCodes.notFound:
          throw CommonFailure('Not found');
        default:
          throw UnknownFailure();
      }
    }
    throw UnknownFailure();
  }
}
