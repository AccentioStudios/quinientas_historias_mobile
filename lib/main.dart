import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'core/app.dart';
import 'core/helpers/shared_preferences_helper.dart';
import 'core/integrations/alice_service.dart';
import 'core/integrations/firebase_messaging_service.dart';
import 'core/integrations/notification_service.dart';
import 'core/integrations/platform_environments.dart';
import 'core/integrations/remote_config_service.dart';
import 'core/routes/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp(
      name: '500Historias${PlatformEnvironment.appIdSuffix}',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBiaXDU4ki0LYQu9-JfV2QqFvEZBU5-wmg',
        appId: '1:591116256365:web:47670f9262fb2d46dbab64',
        messagingSenderId: '591116256365',
        projectId: 'historias-dev-e781f',
        authDomain: 'historias-dev-e781f.firebaseapp.com',
        storageBucket: 'historias-dev-e781f.appspot.com',
        measurementId: 'G-W2ZC5P98WT',
      ),
    );
  }

  GlobalKey<NavigatorState>? navigatorKey = Routes.navigatorKey;

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SharedPreferencesHelper.init();
  await RemoteConfigService.init();
  AliceService.init(navigatorKey!);

  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  runApp(MultiProvider(
    providers: [
      Provider<NotificationService>(
        create: (context) => NotificationService(),
      ),
      Provider<FirebaseMessagingService>(
        create: (context) =>
            FirebaseMessagingService(context.read<NotificationService>()),
      ),
    ],
    child: Application(
      navigatorKey: navigatorKey,
    ),
  ));
}
