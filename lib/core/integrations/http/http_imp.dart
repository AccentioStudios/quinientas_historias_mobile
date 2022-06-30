import 'dart:io';

import 'package:http/http.dart' as http;

import '../../data/models/http_response_model.dart';
import '../../data/models/http_status_model.dart';
import '../../exceptions/http_request_exception.dart';
import '../../helpers/http_helper.dart';
import '../environments/plataform_environments.dart';

class HttpImp implements HttpHelper {
  HttpImp({required this.hostUrl, this.https = PlataformEnvironment.https});
  final String hostUrl;
  final bool https;
  @override
  Future<HttpResponse> get(String path,
      {Map<String, dynamic>? parameters}) async {
    try {
      final Uri uri = _buildUri(path, parameters);
      final response = await http.get(
        uri,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      HttpResponse httpResponse = _buildHttpResponse(response);
      return httpResponse;
    } catch (e) {
      throw _buildHttpResponseWithError(_handleHttpError(e));
    }
  }

  @override
  Future<HttpResponse> post(String path,
      {Object? data, Map<String, dynamic>? parameters}) async {
    try {
      final response = await http.post(_buildUri(path, parameters),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: data);
      return _buildHttpResponse(response);
    } catch (e) {
      throw _buildHttpResponseWithError(_handleHttpError(e));
    }
  }

  @override
  Future<HttpResponse> put(String path,
      {Object? data, Map<String, dynamic>? parameters}) async {
    try {
      final response = await http.put(_buildUri(path, parameters),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: data);
      return _buildHttpResponse(response);
    } catch (e) {
      throw _buildHttpResponseWithError(_handleHttpError(e));
    }
  }

  @override
  Future<HttpResponse> delete(String path,
      {Map<String, dynamic>? parameters}) async {
    try {
      final response = await http.get(_buildUri(path, parameters));
      return _buildHttpResponse(response);
    } catch (e) {
      throw _buildHttpResponseWithError(_handleHttpError(e));
    }
  }

  Uri _buildUri(String path, Map<String, dynamic>? parameters) {
    if (https) {
      return Uri.https(hostUrl, path, parameters);
    }
    return Uri.http(hostUrl, path, parameters);
  }

  _handleHttpError(Object error) {
    if (error is http.ClientException && error.message.isNotEmpty) {
      return HttpRequestException(500, error.message, error);
    }
    if (error is FormatException) {
      return HttpRequestException(500, error.message, error);
    }
    return HttpRequestException(500, 'Unknown error', error as Exception);
  }

  HttpResponse _buildHttpResponse(http.Response response) {
    if (response.headers['content-type']!
        .split(";")
        .contains('application/json')) {
      return HttpResponse(
        headers: response.headers,
      ).jsonDecode(response);
    }
    return HttpResponse(
      body: response.body,
      status: HttpStatusModel.fromJson({
        "message": "",
        "statusCode": response.statusCode.toString(),
      }),
      headers: response.headers,
    );
  }

  HttpResponse _buildHttpResponseWithError(HttpRequestException error) {
    return HttpResponse(
      body: error.data,
      status: HttpStatusModel.fromJson({
        "message": "",
        "statusCode": error.statusCode.toString(),
      }),
    );
  }
}
