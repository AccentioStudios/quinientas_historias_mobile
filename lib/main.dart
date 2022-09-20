import 'dart:async';

import 'package:alice/alice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'core/app.dart';
import 'core/helpers/alice_helper.dart';
import 'core/helpers/shared_preferences_helper.dart';
import 'core/integrations/remote_config_service.dart';
import 'core/utils/constants.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    GlobalKey<NavigatorState>? navigateKey;
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPreferencesHelper.init();

    if (FeatureFlag.aliceEnabled) {
      final Alice alice = AliceHelper.instance;
      navigateKey = alice.getNavigatorKey();
    }

    await Firebase.initializeApp();
    await RemoteConfigService.init();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    runApp(Application(
      navigatorKey: navigateKey,
    ));
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}
