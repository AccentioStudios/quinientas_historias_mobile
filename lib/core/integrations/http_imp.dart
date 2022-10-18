import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:quinientas_historias/core/integrations/alice_service.dart';

import '../data/models/jwt_token_model.dart';
import '../failures/failures.dart';
import '../failures/status_codes.dart';
import '../helpers/http_helper.dart';
import '../helpers/secure_storage_helper.dart';
import 'platform_environments.dart';

class HttpImp implements HttpHelper {
  HttpImp({required this.hostUrl, this.https = PlatformEnvironment.https});
  final String hostUrl;
  final bool https;

  @override
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      JWTTokenModel? sessionData = await SecureStorageHelper.getSessionData();
      final Uri uri = _buildUri(path, queryParameters);
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.accessControlAllowOriginHeader: '*',
          HttpHeaders.accessControlAllowMethodsHeader:
              'GET, POST, DELETE, HEAD, OPTIONS',
          HttpHeaders.accessControlAllowCredentialsHeader: 'true',
          if (sessionData != null)
            HttpHeaders.authorizationHeader: 'Bearer ${sessionData.accessToken}'
        },
      );
      if (kDebugMode) {
        AliceService.instance.onHttpResponse(response);
      }
      return response;
    } catch (e) {
      throw _handleHttpError(e);
    }
  }

  @override
  Future<Response> post(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      JWTTokenModel? sessionData = await SecureStorageHelper.getSessionData();
      final response = await http.post(_buildUri(path, queryParameters),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.accessControlAllowOriginHeader: '*',
            HttpHeaders.accessControlAllowMethodsHeader:
                'GET, POST, DELETE, HEAD, OPTIONS',
            HttpHeaders.accessControlAllowCredentialsHeader: 'true',
            if (sessionData != null)
              HttpHeaders.authorizationHeader:
                  'Bearer ${sessionData.accessToken}'
          },
          body: data);
      if (kDebugMode) {
        AliceService.instance.onHttpResponse(response);
      }
      return response;
    } catch (e) {
      throw _handleHttpError(e);
    }
  }

  @override
  Future<Response> put(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      JWTTokenModel? sessionData = await SecureStorageHelper.getSessionData();

      final response = await http.put(_buildUri(path, queryParameters),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.accessControlAllowOriginHeader: '*',
            HttpHeaders.accessControlAllowMethodsHeader:
                'GET, POST, DELETE, HEAD, OPTIONS',
            HttpHeaders.accessControlAllowCredentialsHeader: 'true',
            if (sessionData != null)
              HttpHeaders.authorizationHeader:
                  'Bearer ${sessionData.accessToken}'
          },
          body: data);
      if (kDebugMode) {
        AliceService.instance.onHttpResponse(response);
      }
      return response;
    } catch (e) {
      throw _handleHttpError(e);
    }
  }

  @override
  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      JWTTokenModel? sessionData = await SecureStorageHelper.getSessionData();

      final response =
          await http.delete(_buildUri(path, queryParameters), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.accessControlAllowOriginHeader: '*',
        HttpHeaders.accessControlAllowMethodsHeader:
            'GET, POST, DELETE, HEAD, OPTIONS',
        HttpHeaders.accessControlAllowCredentialsHeader: 'true',
        if (sessionData != null)
          HttpHeaders.authorizationHeader: 'Bearer ${sessionData.accessToken}',
      });
      if (kDebugMode) {
        AliceService.instance.onHttpResponse(response);
      }
      return response;
    } catch (e) {
      throw _handleHttpError(e);
    }
  }

  Uri _buildUri(String path, Map<String, dynamic>? queryParameters) {
    try {
      if (https) {
        return Uri.https(hostUrl, path, queryParameters);
      }
      return Uri.http(hostUrl, path, queryParameters);
    } catch (error) {
      rethrow;
    }
  }

  _handleHttpError(Object error) {
    if (error is SocketException) {
      return HttpFailure(
          message: error.message,
          error: FailureType.networkError,
          statusCode: StatusCodes.networkError);
    }

    if (error is http.ClientException && error.message.isNotEmpty) {
      return HttpFailure(
          message: error.message,
          error: FailureType.httpHandleError,
          statusCode: StatusCodes.clientException);
    }
    if (error is FormatException) {
      return HttpFailure(
          message: error.message,
          error: FailureType.httpHandleError,
          statusCode: StatusCodes.formatException);
    }

    return HttpFailure(
        error: FailureType.httpHandleError, statusCode: StatusCodes.unknown);
  }

  // HttpResponse _buildHttpResponse(http.Response response) {
  //   return HttpResponse(
  //     headers: response.headers,
  //   ).parse(response);
  // }

  // HttpResponse _buildHttpResponseWithError(HttpRequestException error) {
  //   return HttpResponse().parse(error);
  // }

  @override
  void setAuth(JWTTokenModel jwtToken) {
    if (jwtToken.accessToken != null) {
      final String jwtJson = jsonEncode(jwtToken.toJson());
      const secureStorage = FlutterSecureStorage();
      secureStorage.deleteAll();
      secureStorage.write(key: 'accessToken', value: jwtToken.accessToken);
      secureStorage.write(key: 'userData', value: jwtJson);
    }
  }

  @override
  void removeAuth() {
    const secureStorage = FlutterSecureStorage();
    secureStorage.deleteAll();
  }
}
