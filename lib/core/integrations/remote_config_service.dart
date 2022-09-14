import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigService {
  RemoteConfigService._();
  static Future<RemoteConfigService> get instance async {
    if (_instance == null) {
      _instance = RemoteConfigService._();
      await _instance!._init();
    }
    return _instance!;
  }

  static RemoteConfigService? _instance;
  late FirebaseRemoteConfig _firebaseRemoteConfig;
  late Map<String, dynamic> _remoteConfigurations;

  Future<void> _init() async {
    _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    _remoteConfigurations = <String, dynamic>{
      'maintenanceMode': false,
    };

    _firebaseRemoteConfig.setDefaults({..._remoteConfigurations});

    await _fetch();
  }

  Future<void> _fetch() async {
    await _firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 20)));

    // Debug mode is always uses the defaults values
    if (kDebugMode) {
      return;
    }

    await _firebaseRemoteConfig.fetchAndActivate();
    _remoteConfigurations.forEach((String key, dynamic value) {
      _remoteConfigurations[key] = _firebaseRemoteConfig.getValue(key);
    });
  }

  Map<String, dynamic> get remoteConfigurations => _remoteConfigurations;
}
