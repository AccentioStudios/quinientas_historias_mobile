abstract class Failure implements Exception {}

class HttpHandleFailure extends Failure {
  HttpHandleFailure({
    this.error,
    this.stackTrace,
  });
  final Object? error;
  final StackTrace? stackTrace;
}

class NetworkFailure extends Failure {}

class UnknownFailure extends Failure {}
