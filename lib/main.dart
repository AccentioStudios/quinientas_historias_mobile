import 'package:alice/alice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quinientas_historias/core/utils/constants.dart';

import 'core/app.dart';
import 'core/helpers/alice_helper.dart';

void main() async {
  GlobalKey<NavigatorState>? navigateKey;
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  if (FeatureFlag.aliceEnabled) {
    final Alice alice = AliceHelper.instance;
    navigateKey = alice.getNavigatorKey();
  }

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: dotenv.get('FIREBASE_API_KEY'),
      appId: dotenv.get('FIREBASE_APP_ID'),
      messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
      projectId: dotenv.get('FIREBASE_PROJECT_ID'),
      storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(Application(
    navigatorKey: navigateKey,
  ));
}
