class HttpRequestException implements Exception {
  const HttpRequestException(
    this.statusCode,
    this.data,
    this.stackTrace,
  );
  final int statusCode;
  final String? data;
  final Exception? stackTrace;

  @override
  String toString() =>
      'HttpRequestError: statusCode -> $statusCode, data -> $data';
}
