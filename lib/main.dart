import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyBOLUZ-_ePR1xfI2ax6OhpKhHWKYIpQ1f8',
      appId: '1:842187200552:web:e3f12e7d5509a36f483d1d',
      messagingSenderId: '842187200552',
      projectId: 'mama-africa-app',
      storageBucket: 'http://mama-africa-app.appspot.com',
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
