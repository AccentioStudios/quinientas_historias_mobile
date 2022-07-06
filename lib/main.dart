import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Application();
  }
}
