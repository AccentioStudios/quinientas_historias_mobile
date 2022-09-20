import 'package:firebase_remote_config/firebase_remote_config.dart';

// Singleton
class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();
  factory RemoteConfigService() {
    return _instance;
  }
  RemoteConfigService._internal();

  static late final FirebaseRemoteConfig instance;

  static init() async {
    instance = FirebaseRemoteConfig.instance;

    final defaultRemoteConfigurations = <String, dynamic>{
      'maintenance_mode': false,
    };
    instance.setDefaults({...defaultRemoteConfigurations});

    await instance.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 20)));

    // // Debug mode is always uses the defaults values
    // if (kDebugMode) {
    //   return;
    // }

    await instance.fetchAndActivate();
  }
}

// class RemoteConfigService {
//   RemoteConfigService._();
//   static Future<RemoteConfigService> get instance async {
//     if (_instance == null) {
//       _instance = RemoteConfigService._();
//       await _instance!._init();
//     }
//     return _instance!;
//   }

//   static RemoteConfigService? _instance;
//   late FirebaseRemoteConfig _firebaseRemoteConfig;
//   late Map<String, dynamic> _remoteConfigurations;

//   Future<void> _init() async {
//     _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
//     _remoteConfigurations = <String, dynamic>{
//       'maintenance_mode': false,
//     };

//     _firebaseRemoteConfig.setDefaults({..._remoteConfigurations});

//     await _fetch();
//   }

//   Future<void> _fetch() async {
//     await _firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
//         fetchTimeout: const Duration(seconds: 10),
//         minimumFetchInterval: const Duration(seconds: 20)));

//     // // Debug mode is always uses the defaults values
//     // if (kDebugMode) {
//     //   return;
//     // }

//     await _firebaseRemoteConfig.fetchAndActivate();
//     _remoteConfigurations.forEach((String key, dynamic value) {
//       _remoteConfigurations[key] = _firebaseRemoteConfig.getValue(key);
//     });
//   }

//   Map<String, dynamic> get remoteConfigurations => _remoteConfigurations;
// }
