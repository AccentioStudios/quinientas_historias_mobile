import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:quinientas_historias/core/data/models/jwt_token_model.dart';

import '../failures/failures.dart';
import '../failures/status_codes.dart';
import '../helpers/http_helper.dart';
import '../helpers/secure_storage_helper.dart';
import 'alice_service.dart';
import 'platform_environments.dart';

class HttpHelperImp implements HttpHelper {
  HttpHelperImp({
    required this.hostUrl,
    this.https = PlatformEnvironment.https,
  }) {
    _setupDio();
  }
  late Dio _dio;
  final String hostUrl;
  final bool https;

  _setupDio() {
    _dio = Dio(BaseOptions(sendTimeout: const Duration(seconds: 30)));
    if (kDebugMode || PlatformEnvironment.env != 'prod') {
      _dio.interceptors.add(PrettyDioLogger(
        responseHeader: true,
        requestBody: true,
        compact: false,
      ));
      _dio.interceptors.add(AliceService.instance.getDioInterceptor());
    }
    addAccessTokenInterceptor();
  }

  addAccessTokenInterceptor() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      return handler.next(options);
    }, onError: (DioError e, handler) async {
      if (e.response?.data is Map<String, dynamic>) {
        final failure = HttpFailure.fromJson(e.response?.data);
        if (e.response?.statusCode == 401 &&
            failure.message == FailureType.expiredAccessToken) {
          if (await refreshToken()) {
            String? accessToken = await SecureStorageHelper.getAccessToken();
            e.requestOptions.headers[HttpHeaders.authorizationHeader] =
                'Bearer $accessToken';
            final newTry = await retry(e.requestOptions);
            return handler.resolve(newTry);
          }
          return handler.reject(e);
        }
      }
      return handler.next(e);
    }));
  }

  Future<bool> refreshToken() async {
    try {
      String? refreshToken = await SecureStorageHelper.getRefreshToken();
      final response = await _dio.get(
        _buildUrl('v2/auth/refresh', null),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.accessControlAllowOriginHeader: '*',
          HttpHeaders.accessControlAllowMethodsHeader:
              'GET, POST, DELETE, HEAD, OPTIONS',
          HttpHeaders.accessControlAllowCredentialsHeader: 'true',
          if (refreshToken != null)
            HttpHeaders.authorizationHeader: 'Bearer $refreshToken'
        }),
      );
      if (response.statusCode == 200) {
        final token = JWTTokenModel.decode(response.data);
        SecureStorageHelper.saveSession(token);
        return true;
      } else {
        SecureStorageHelper.deleteAll();
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<Response> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return _dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  @override
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      String? accessToken = await SecureStorageHelper.getAccessToken();
      final response = await _dio.get(
        _buildUrl(path, queryParameters),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.accessControlAllowOriginHeader: '*',
          HttpHeaders.accessControlAllowMethodsHeader:
              'GET, POST, DELETE, HEAD, OPTIONS',
          HttpHeaders.accessControlAllowCredentialsHeader: 'true',
          if (accessToken != null)
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
        }),
      );

      return response;
    } catch (e) {
      throw _handleHttpError(e);
    }
  }

  @override
  Future<Response> post(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      String? accessToken = await SecureStorageHelper.getAccessToken();
      final response = await _dio.post(
        _buildUrl(path, queryParameters),
        data: data,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.accessControlAllowOriginHeader: '*',
          HttpHeaders.accessControlAllowMethodsHeader:
              'GET, POST, DELETE, HEAD, OPTIONS',
          HttpHeaders.accessControlAllowCredentialsHeader: 'true',
          if (accessToken != null)
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
        }),
      );
      return response;
    } catch (e) {
      throw _handleHttpError(e);
    }
  }

  @override
  Future<Response> put(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      String? accessToken = await SecureStorageHelper.getAccessToken();

      final response = await _dio.put(
        _buildUrl(path, queryParameters),
        data: data,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.accessControlAllowOriginHeader: '*',
          HttpHeaders.accessControlAllowMethodsHeader:
              'GET, POST, DELETE, HEAD, OPTIONS',
          HttpHeaders.accessControlAllowCredentialsHeader: 'true',
          if (accessToken != null)
            HttpHeaders.authorizationHeader: 'Bearer $accessToken'
        }),
      );

      return response;
    } catch (e) {
      throw _handleHttpError(e);
    }
  }

  @override
  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      String? accessToken = await SecureStorageHelper.getAccessToken();

      final response = await _dio.delete(_buildUrl(path, queryParameters),
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.accessControlAllowOriginHeader: '*',
            HttpHeaders.accessControlAllowMethodsHeader:
                'GET, POST, DELETE, HEAD, OPTIONS',
            HttpHeaders.accessControlAllowCredentialsHeader: 'true',
            if (accessToken != null)
              HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          }));

      return response;
    } catch (e) {
      throw _handleHttpError(e);
    }
  }

  String _buildUrl(String path, Map<String, dynamic>? queryParameters) {
    try {
      if (https) {
        return Uri.https(hostUrl, path, queryParameters).toString();
      }
      return Uri.http(hostUrl, path, queryParameters).toString();
    } catch (error) {
      rethrow;
    }
  }

  _handleHttpError(Object error) {
    if (error is DioError) {
      if (error.response?.statusCode == 401) {
        return HttpFailure(
            message: FailureType.invalidAccessToken,
            statusCode: StatusCodes.unauthorized);
      }
    }
    if (error is SocketException) {
      return HttpFailure(
          message: FailureType.networkError,
          statusCode: StatusCodes.networkError);
    }

    if (error is FormatException) {
      return HttpFailure(
          message: FailureType.httpHandleError,
          statusCode: StatusCodes.formatException);
    }

    return HttpFailure(
        message: FailureType.httpHandleError, statusCode: StatusCodes.unknown);
  }

  // HttpResponse _buildHttpResponse(http.Response response) {
  //   return HttpResponse(
  //     headers: response.headers,
  //   ).parse(response);
  // }

  // HttpResponse _buildHttpResponseWithError(HttpRequestException error) {
  //   return HttpResponse().parse(error);
  // }
}
