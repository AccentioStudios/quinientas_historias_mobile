import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app.dart';
import 'core/helpers/shared_preferences_helper.dart';
import 'core/integrations/alice_service.dart';
import 'core/integrations/firebase_messaging_service.dart';
import 'core/integrations/notification_service.dart';
import 'core/integrations/remote_config_service.dart';
import 'core/routes/routes.dart';
import 'firebase_options.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    GlobalKey<NavigatorState>? navigatorKey = Routes.navigatorKey;
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await SharedPreferencesHelper.init();
    await RemoteConfigService.init();
    AliceService.init(navigatorKey!);

    if (!kIsWeb) {
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
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
  }, (error, stack) {
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    }
  });
}
