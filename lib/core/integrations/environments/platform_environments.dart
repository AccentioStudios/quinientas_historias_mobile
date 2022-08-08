class PlatformEnvironment {
  static const String apiHostUrl =
      String.fromEnvironment('API_URL', defaultValue: 'localhost:8000');
  static const String jwtSignKey =
      String.fromEnvironment('JWT_SIGN_KEY', defaultValue: '');

  static const bool https = bool.fromEnvironment('https', defaultValue: false);
}
