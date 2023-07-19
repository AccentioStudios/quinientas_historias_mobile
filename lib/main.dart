import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'core/app.dart';
import 'core/helpers/shared_preferences_helper.dart';
import 'core/integrations/firebase_messaging_service.dart';
import 'core/integrations/injections/get_it.dart';
import 'core/integrations/notification_service.dart';
import 'core/integrations/platform_environments.dart';
import 'core/integrations/remote_config_service.dart';
import 'core/integrations/secure_storage_service.dart';
import 'core/routes/auto_router.dart';
import 'features/challenges/data/entities/challenge_sar_event.dart';
import 'features/challenges/sar_service.dart';
import 'firebase_options.dart';

void main() async {
  // Inject dependencies
  GetItInjector.init();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp(
      name: '500Historias${PlatformEnvironment.appIdSuffix}',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBFUY50O5JI5kpAJ_5MpFjgple3PBM1xtg",
        authDomain: "historias-dev-e781f.firebaseapp.com",
        projectId: "historias-dev-e781f",
        storageBucket: "historias-dev-e781f.appspot.com",
        messagingSenderId: "591116256365",
        appId: "1:591116256365:web:cfa0c17d2508eb71dbab64",
        measurementId: "G-YGKL975CV6",
      ),
    );
  }

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SharedPreferencesHelper.init();
  await RemoteConfigService.init();

  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  // Check if it's the first open of the day and emit the trigger if it is the case (only if the user is logged in)
  emitFirstOpenOfDayTrigger();
  runApp(MultiProvider(
    providers: [
      Provider<NotificationService>(
        create: (context) => NotificationService(context),
      ),
      Provider<FirebaseMessagingService>(
        create: (context) =>
            FirebaseMessagingService(context.read<NotificationService>()),
      ),
    ],
    builder: (context, child) {
      return Application(router: GetIt.I<AppRouter>());
    },
  ));
}

checkFirstOpenOfDay() {
  final sharedPreferences = SharedPreferencesHelper.instance;
  final lastOpenString = sharedPreferences.getString('lastOpen');
  if (lastOpenString != null) {
    final now = DateTime.now();
    final lastOpen = DateTime.tryParse(lastOpenString);

    if (lastOpen == null ||
        now.year != lastOpen.year ||
        now.month != lastOpen.month ||
        now.day != lastOpen.day) {
      sharedPreferences.setString('lastOpen', now.toString());
      return true;
    }
    return false;
  }
  return false;
}

emitFirstOpenOfDayTrigger() async {
  final userData = await GetIt.I<SecureStorageService>().getSessionData();
  if (userData != null) {
    if (checkFirstOpenOfDay()) {
      GetIt.I<SARService>()
          .emit(ChallengeSarTriggers.firstSessionOfDay, userId: userData.id);
    }
  }
}
