class PlataformEnvironment {
  static const String apiHostUrl =
      String.fromEnvironment('API_URL', defaultValue: 'localhost:8000');

  static const bool https = bool.fromEnvironment('https', defaultValue: false);
}
