import 'dart:convert';
import 'dart:io';

import 'package:alice/core/alice_http_extensions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../data/models/http_response_model.dart';
import '../../data/models/jwt_token_model.dart';
import '../../exceptions/http_request_exception.dart';
import '../../helpers/alice_helper.dart';
import '../../helpers/http_helper.dart';
import '../../helpers/secure_storage_helper.dart';
import '../environments/platform_environments.dart';

class HttpImp implements HttpHelper {
  HttpImp({required this.hostUrl, this.https = PlatformEnvironment.https});
  final String hostUrl;
  final bool https;

  @override
  Future<HttpResponse> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      String? savedAccessToken =
          await SecureStorageHelper.getSavedAccessToken();
      final Uri uri = _buildUri(path, queryParameters);
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          if (savedAccessToken != null)
            HttpHeaders.authorizationHeader: 'Bearer $savedAccessToken'
        },
      ).interceptWithAlice(AliceHelper.instance);
      HttpResponse httpResponse = _buildHttpResponse(response);
      return httpResponse;
    } catch (e) {
      return _buildHttpResponseWithError(_handleHttpError(e));
    }
  }

  @override
  Future<HttpResponse> post(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      String? savedAccessToken =
          await SecureStorageHelper.getSavedAccessToken();

      final response = await http
          .post(_buildUri(path, queryParameters),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.accessControlAllowOriginHeader: '*',
                HttpHeaders.accessControlAllowMethodsHeader:
                    'GET, POST, DELETE, HEAD, OPTIONS',
                HttpHeaders.accessControlAllowCredentialsHeader: 'true',
                if (savedAccessToken != null)
                  HttpHeaders.authorizationHeader: 'Bearer $savedAccessToken'
              },
              body: data)
          .interceptWithAlice(AliceHelper.instance);

      return _buildHttpResponse(response);
    } catch (e) {
      return _buildHttpResponseWithError(_handleHttpError(e));
    }
  }

  @override
  Future<HttpResponse> put(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      String? savedAccessToken =
          await SecureStorageHelper.getSavedAccessToken();

      final response = await http
          .put(_buildUri(path, queryParameters),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                if (savedAccessToken != null)
                  HttpHeaders.authorizationHeader: 'Bearer $savedAccessToken'
              },
              body: data)
          .interceptWithAlice(AliceHelper.instance);
      return _buildHttpResponse(response);
    } catch (e) {
      return _buildHttpResponseWithError(_handleHttpError(e));
    }
  }

  @override
  Future<HttpResponse> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      String? savedAccessToken =
          await SecureStorageHelper.getSavedAccessToken();

      final response =
          await http.get(_buildUri(path, queryParameters), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        if (savedAccessToken != null)
          HttpHeaders.authorizationHeader: 'Bearer $savedAccessToken',
      }).interceptWithAlice(AliceHelper.instance);
      return _buildHttpResponse(response);
    } catch (e) {
      return _buildHttpResponseWithError(_handleHttpError(e));
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
    if (error is http.ClientException && error.message.isNotEmpty) {
      return HttpRequestException(500, error.message, error);
    }
    if (error is FormatException) {
      return HttpRequestException(500, error.message, error);
    }

    return HttpRequestException(null, 'Unknown error', error as Exception);
  }

  HttpResponse _buildHttpResponse(http.Response response) {
    return HttpResponse(
      headers: response.headers,
    ).parse(response);
  }

  HttpResponse _buildHttpResponseWithError(HttpRequestException error) {
    return HttpResponse().parse(error);
  }

  @override
  void setAuth(JWTTokenModel jwtToken) {
    if (jwtToken.accessToken != null) {
      final String jwtJson = jwtToken.toJson();
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
