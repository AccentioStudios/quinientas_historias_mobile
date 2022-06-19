import '../data/models/http_error_model.dart';
import '../data/models/http_response_model.dart';
import '../failures/error_codes.dart';
import '../failures/failures.dart';

typedef HttpResponseMapper<T> = T Function(Object);

extension HttpExtension on Future<HttpResponse> {
  Stream<T> handle<T>({required HttpResponseMapper<T> mapper}) async* {
    final HttpResponse response = await this;
    if (response.isSuccess() && response.data != null) {
      try {
        yield mapper(response.data!);
      } catch (error) {
        if (error is TypeError) {
          throw HttpHandleFailure(error: error);
        }
        throw _checkFailures(response);
      }
    }
  }
}

// extension HandleExtension on HttpResponseMapperObject {
//   Stream<T> fromList<T>({required HttpResponseMapper<T> mapper}) async* {
//     var wtf = this;
//     yield mapper(wtf);
//   }
// }

Failure _checkFailures(HttpResponse response) {
  if (response.data != null && response.data is String) {
    try {
      final HttpErrorModel error = HttpErrorModel.fromHttpResponse(response);
      switch (error.errorCode) {
        case ErrorCodes.unknown:
          return UnknownFailure();
        case ErrorCodes.badRequest:
          return CommonFailure(error.message);
        case ErrorCodes.notFound:
          return CommonFailure('Not found');
        default:
          return UnknownFailure();
      }
    } catch (e) {
      return HttpHandleFailure(error: e);
    }
  }
  return HttpHandleFailure(error: 'Response data empty');
}
