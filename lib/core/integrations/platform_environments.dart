class PlatformEnvironment {
  static const String appIdSuffix = String.fromEnvironment('APP_ID_SUFFIX');

  static const String apiHostUrl =
      String.fromEnvironment('API_URL', defaultValue: '');
  static const String jwtSignKey =
      String.fromEnvironment('JWT_SIGN_KEY', defaultValue: '');
  static const String env = String.fromEnvironment('ENV', defaultValue: 'prod');

  static const bool https = bool.fromEnvironment('https', defaultValue: true);
}
