import '../../features/auth/data/models/auth_error_model.dart';

abstract class Failure implements Exception {}

class CommonFailure extends Failure {
  CommonFailure(this.message, [this.stacktrace]) : super();
  final String? message;
  final Exception? stacktrace;

  @override
  String toString() => message ?? '';
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({this.message});
  final String? message;
}

class LoginFailure extends Failure {
  LoginFailure({required this.authErrorModel});
  final AuthErrorModel authErrorModel;
}

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
