import 'package:shared_preferences/shared_preferences.dart';

// Singleton
class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();
  factory SharedPreferencesHelper() {
    return _instance;
  }
  SharedPreferencesHelper._internal();

  static late final SharedPreferences instance;

  static init() async {
    instance = await SharedPreferences.getInstance();
  }
}
