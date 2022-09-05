import 'package:quinientas_historias/core/data/models/jwt_token_model.dart';

import '../data/models/http_response_model.dart';

abstract class HttpHelper {
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<HttpResponse> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });

  Future<HttpResponse> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<HttpResponse> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });

  void setAuth(JWTTokenModel authModel);
  void removeAuth();
}
