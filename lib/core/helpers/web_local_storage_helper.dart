import 'dart:convert';
import "package:universal_html/html.dart";

import '../data/models/jwt_token_model.dart';

// Singleton
class WebLocalStorageHelper {
  static final WebLocalStorageHelper _instance =
      WebLocalStorageHelper._internal();
  factory WebLocalStorageHelper() {
    return _instance;
  }
  WebLocalStorageHelper._internal();

  static Storage localStorage = window.localStorage;

  static saveSession(JWTTokenModel jwtToken) {
    if (jwtToken.accessToken != null) {
      deleteAll();
      final String jwtJson = jsonEncode(jwtToken.toJson());
      final Storage localStorage = window.localStorage;
      localStorage['accessToken'] = jwtToken.accessToken!;
      localStorage['userData'] = jwtJson;
      return;
    }
  }

  static Future<String?> getSavedAccessToken() {
    final Storage localStorage = window.localStorage;
    return Future.value(localStorage['accessToken']);
  }

  static Future<JWTTokenModel?> getSessionData() async {
    final String? userData;

    final Storage localStorage = window.localStorage;
    userData = localStorage['userData'];

    if (userData != null) {
      Map<String, dynamic> jsonData = json.decode(userData);
      return JWTTokenModel.decode(jsonData);
    }

    return null;
  }

  static deleteAll() {
    final Storage localStorage = window.localStorage;
    localStorage.remove('accessToken');
    localStorage.remove('userData');
  }
}
