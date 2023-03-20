import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:universal_html/html.dart";

import '../data/dto/auth_dto.dart';

// Singleton
class SecureStorageHelper {
  static final SecureStorageHelper _instance = SecureStorageHelper._internal();
  factory SecureStorageHelper() {
    return _instance;
  }
  SecureStorageHelper._internal();

  static const FlutterSecureStorage instance = FlutterSecureStorage();

  static saveSession(AuthDto authDto) {
    deleteAll();
    if (authDto.accessToken != null && authDto.refreshToken != null) {
      if (kIsWeb) {
        final Storage localStorage = window.localStorage;
        localStorage['accessToken'] = authDto.accessToken!;
        localStorage['refreshToken'] = authDto.refreshToken!;
        localStorage['user'] = jsonEncode(authDto.payload.toJson());
        return;
      }
      const secureStorage = FlutterSecureStorage();
      secureStorage.write(key: 'accessToken', value: authDto.accessToken);
      secureStorage.write(key: 'refreshToken', value: authDto.refreshToken);
      secureStorage.write(
          key: 'user', value: jsonEncode(authDto.payload.toJson()));
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

  static Future<JwtPayload?> getSessionData() async {
    final String? userData;
    if (kIsWeb) {
      final Storage localStorage = window.localStorage;
      userData = localStorage['user'];
    } else {
      userData = await instance.read(key: 'user');
    }

    if (userData != null) {
      Map<String, dynamic> jsonData = json.decode(userData);
      return JwtPayload.fromJson(jsonData);
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
