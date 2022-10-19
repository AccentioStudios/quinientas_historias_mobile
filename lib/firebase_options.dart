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
    apiKey: 'AIzaSyAnpurh9rJpDESlWK0Rsc_9iN7hKqJHyrE',
    appId: '1:167564851917:web:efaa9f37d9c112110ac784',
    messagingSenderId: '167564851917',
    projectId: 'historias-25985',
    authDomain: 'historias-25985.firebaseapp.com',
    storageBucket: 'historias-25985.appspot.com',
    measurementId: 'G-Q10Y0XXHZT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAlgQVIg4dkwRwDGs-enN6Zta0eeR3zgO4',
    appId: '1:167564851917:android:0e6e7614fc226c120ac784',
    messagingSenderId: '167564851917',
    projectId: 'historias-25985',
    storageBucket: 'historias-25985.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrBwCGtoNgZFSQZWxRgQL21S2lEqCc_qA',
    appId: '1:167564851917:ios:3580bfa3fd1112910ac784',
    messagingSenderId: '167564851917',
    projectId: 'historias-25985',
    storageBucket: 'historias-25985.appspot.com',
    iosClientId: '167564851917-jr4d2aanbtj5dpjvh0efailtv19vau7o.apps.googleusercontent.com',
    iosBundleId: 'com.accentiostudios.quinientas',
  );
}
