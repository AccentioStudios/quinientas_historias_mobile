import 'package:dio/dio.dart';

abstract class HttpHelper {
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
}
