import '../data/models/http_response_model.dart';

abstract class HttpHelper {
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? parameters,
  });

  Future<HttpResponse> post(
    String path, {
    Object? data,
    Map<String, dynamic>? parameters,
  });

  Future<HttpResponse> delete(
    String path, {
    Map<String, dynamic>? parameters,
  });

  Future<HttpResponse> put(
    String path, {
    Object? data,
    Map<String, dynamic>? parameters,
  });
}
