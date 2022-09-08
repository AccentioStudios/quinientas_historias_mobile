abstract class Failure implements Exception {}

class HttpHandleFailure extends Failure {
  HttpHandleFailure({
    this.error,
    this.stackTrace,
  });
  final Object? error;
  final StackTrace? stackTrace;
}

class UnknownFailure extends Failure {}

class BadRequestFailure extends Failure {}

class NotFoundFailure extends Failure {}
