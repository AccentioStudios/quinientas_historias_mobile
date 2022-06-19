class HttpResponse {
  HttpResponse(
    this.data,
    this.statusCode, {
    this.headers,
    this.stackTrace,
  });

  final String? data;
  final int statusCode;
  final Map<String, String>? headers;
  final Exception? stackTrace;

  bool isSuccess() {
    return statusCode == 200;
  }
}
