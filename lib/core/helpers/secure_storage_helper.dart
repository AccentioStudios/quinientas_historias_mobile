import 'dart:convert';
import "package:universal_html/html.dart";

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quinientas_historias/core/data/models/jwt_token_model.dart';

import '../data/entities/user_entity.dart';

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
      if (kIsWeb) {
        final Storage localStorage = window.localStorage;
        localStorage['accessToken'] = jwtToken.accessToken!;
        localStorage['refreshToken'] = jwtToken.refreshToken!;
        localStorage['user'] = jsonEncode(jwtToken.user.toJson());
        return;
      }
      const secureStorage = FlutterSecureStorage();
      secureStorage.write(key: 'accessToken', value: jwtToken.accessToken);
      secureStorage.write(key: 'refreshToken', value: jwtToken.refreshToken);
      secureStorage.write(
          key: 'user', value: jsonEncode(jwtToken.user.toJson()));
    }
  }

  static Future<String?> getRefreshToken() {
    if (kIsWeb) {
      final Storage localStorage = window.localStorage;
      return Future.value(localStorage['refreshToken']);
    }
    return instance.read(key: 'refreshToken');
  }

  static Future<String?> getAccessToken() {
    if (kIsWeb) {
      final Storage localStorage = window.localStorage;
      return Future.value(localStorage['accessToken']);
    }
    return instance.read(key: 'accessToken');
  }

  static Future<User?> getSessionData() async {
    final String? userData;
    if (kIsWeb) {
      final Storage localStorage = window.localStorage;
      userData = localStorage['user'];
    } else {
      userData = await instance.read(key: 'user');
    }

    if (userData != null) {
      Map<String, dynamic> jsonData = json.decode(userData);
      return User.fromJson(jsonData);
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
