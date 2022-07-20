class HttpRequestException implements Exception {
  const HttpRequestException(
    this.statusCode,
    this.data,
    this.exception,
  );
  final int? statusCode;
  final String? data;
  final Exception? exception;

  @override
  String toString() =>
      'HttpRequestError: statusCode -> $statusCode, data -> $data';
}
