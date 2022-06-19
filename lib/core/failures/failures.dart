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

class CommonFailure extends Failure {
  CommonFailure(this.message, [this.stacktrace]) : super();
  final String? message;
  final Exception? stacktrace;

  @override
  String toString() => message ?? '';
}
