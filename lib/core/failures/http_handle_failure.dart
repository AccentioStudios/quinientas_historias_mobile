import 'failures.dart';

class HttpHandleFailure extends Failure {
  HttpHandleFailure({
    Object? error,
    this.stackTrace,
  }) : super(error: error);
  final StackTrace? stackTrace;
}
