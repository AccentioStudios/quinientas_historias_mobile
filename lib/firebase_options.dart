// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBiaXDU4ki0LYQu9-JfV2QqFvEZBU5-wmg',
    appId: '1:591116256365:web:47670f9262fb2d46dbab64',
    messagingSenderId: '591116256365',
    projectId: 'historias-dev-e781f',
    authDomain: 'historias-dev-e781f.firebaseapp.com',
    storageBucket: 'historias-dev-e781f.appspot.com',
    measurementId: 'G-W2ZC5P98WT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSXGstA9XiB6uLwtl6CEEkqQLj5_kD9ug',
    appId: '1:591116256365:android:ec5afa56ed55a832dbab64',
    messagingSenderId: '591116256365',
    projectId: 'historias-dev-e781f',
    storageBucket: 'historias-dev-e781f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgcdWSdIcJde7bJCoiUxKiG4Nm1OUsI7w',
    appId: '1:591116256365:ios:bde620bb4b59acd1dbab64',
    messagingSenderId: '591116256365',
    projectId: 'historias-dev-e781f',
    storageBucket: 'historias-dev-e781f.appspot.com',
    iosClientId: '591116256365-u5h61oho3hemtnnumhdac4s2dqkan1pm.apps.googleusercontent.com',
    iosBundleId: 'com.accentiostudios.quinientas',
  );
}
