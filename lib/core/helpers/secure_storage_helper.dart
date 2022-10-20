import 'dart:convert';
import "package:universal_html/html.dart";

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quinientas_historias/core/data/models/jwt_token_model.dart';

// Singleton
class SecureStorageHelper {
  static final SecureStorageHelper _instance = SecureStorageHelper._internal();
  factory SecureStorageHelper() {
    return _instance;
  }
  SecureStorageHelper._internal();

  static const FlutterSecureStorage instance = FlutterSecureStorage();

  static saveSession(JWTTokenModel jwtToken) {
    if (jwtToken.accessToken != null) {
      deleteAll();
      final String jwtJson = jsonEncode(jwtToken.toJson());
      if (kIsWeb) {
        final Storage localStorage = window.localStorage;
        localStorage['accessToken'] = jwtToken.accessToken!;
        localStorage['userData'] = jwtJson;
        return;
      }
      const secureStorage = FlutterSecureStorage();
      secureStorage.write(key: 'accessToken', value: jwtToken.accessToken);
      secureStorage.write(key: 'userData', value: jwtJson);
    }
  }

  static Future<String?> getSavedAccessToken() {
    if (kIsWeb) {
      final Storage localStorage = window.localStorage;
      return Future.value(localStorage['accessToken']);
    }
    return instance.read(key: 'accessToken');
  }

  static Future<JWTTokenModel?> getSessionData() async {
    final String? userData;
    if (kIsWeb) {
      final Storage localStorage = window.localStorage;
      userData = localStorage['userData'];
    } else {
      userData = await instance.read(key: 'userData');
    }

    if (userData != null) {
      Map<String, dynamic> jsonData = json.decode(userData);
      return JWTTokenModel.decode(jsonData);
    }

    return null;
  }

  static deleteAll() {
    if (kIsWeb) {
      final Storage localStorage = window.localStorage;
      localStorage.remove('accessToken');
      localStorage.remove('userData');
    } else {
      const secureStorage = FlutterSecureStorage();
      secureStorage.deleteAll();
    }
  }
}
