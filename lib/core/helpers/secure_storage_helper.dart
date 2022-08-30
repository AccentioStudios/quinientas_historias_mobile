import 'dart:convert';

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

  static Future<String?> getSavedAccessToken() {
    return instance.read(key: 'accessToken');
  }

  static Future<JWTTokenModel?> getSessionData() async {
    final String? userData = await instance.read(key: 'userData');

    if (userData != null) {
      Map<String, dynamic> jsonData = json.decode(userData);
      return JWTTokenModel.decode(jsonData);
    }

    return null;
  }
}
