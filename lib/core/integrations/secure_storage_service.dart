import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:universal_html/html.dart";

import '../data/dto/auth_dto.dart';

class SecureStorageService {
  _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  final Storage _localStorage = window.localStorage;

  setPublicEmail(String email) {
    if (kIsWeb) {
      _localStorage['publicEmail'] = email;
    } else {
      _secureStorage.write(
          key: 'publicEmail', value: email, aOptions: _getAndroidOptions());
    }
  }

  getPublicEmail() {
    if (kIsWeb) {
      return _localStorage['publicEmail'];
    } else {
      return _secureStorage.read(
          key: 'publicEmail', aOptions: _getAndroidOptions());
    }
  }

  saveSession(AuthDto authDto) async {
    deleteAll();
    if (authDto.accessToken != null && authDto.refreshToken != null) {
      if (kIsWeb) {
        _localStorage['accessToken'] = authDto.accessToken!;
        _localStorage['refreshToken'] = authDto.refreshToken!;
        _localStorage['user'] = jsonEncode(authDto.payload.toJson());
        return;
      }
      await _secureStorage.write(
          key: 'accessToken',
          value: authDto.accessToken,
          aOptions: _getAndroidOptions());
      await _secureStorage.write(
          key: 'refreshToken',
          value: authDto.refreshToken,
          aOptions: _getAndroidOptions());
      await _secureStorage.write(
          key: 'user',
          value: jsonEncode(authDto.payload.toJson()),
          aOptions: _getAndroidOptions());
    }
  }

  Future<String?> getRefreshToken() async {
    if (kIsWeb) {
      return Future.value(_localStorage['refreshToken']);
    }
    if (await containsKeyInSecureData('refreshToken')) {
      return _secureStorage.read(
          key: 'refreshToken', aOptions: _getAndroidOptions());
    } else {
      return Future.value(null);
    }
  }

  Future<String?> getAccessToken() async {
    try {
      if (kIsWeb) {
        return Future.value(_localStorage['accessToken']);
      }
      if (await containsKeyInSecureData('accessToken')) {
        return _secureStorage.read(
            key: 'accessToken', aOptions: _getAndroidOptions());
      } else {
        return Future.value(null);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return Future.value(null);
    }
  }

  Future<JwtPayload?> getSessionData() async {
    final String? userData;
    if (kIsWeb) {
      userData = _localStorage['user'];
    } else {
      if (await containsKeyInSecureData('user')) {
        userData = await _secureStorage.read(
            key: 'user', aOptions: _getAndroidOptions());
      } else {
        userData = null;
      }
    }

    if (userData != null) {
      Map<String, dynamic> jsonData = json.decode(userData);
      return JwtPayload.fromJson(jsonData);
    }

    return null;
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(
        key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }

  deleteAll() {
    if (kIsWeb) {
      _localStorage.remove('accessToken');
      _localStorage.remove('userData');
    } else {
      _secureStorage.deleteAll(aOptions: _getAndroidOptions());
    }
  }
}
