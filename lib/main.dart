import 'package:alice/alice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/app.dart';
import 'core/helpers/alice_helper.dart';
import 'core/utils/constants.dart';

void main() async {
  GlobalKey<NavigatorState>? navigateKey;
  WidgetsFlutterBinding.ensureInitialized();

  if (FeatureFlag.aliceEnabled) {
    final Alice alice = AliceHelper.instance;
    navigateKey = alice.getNavigatorKey();
  }

  await Firebase.initializeApp();
  runApp(Application(
    navigatorKey: navigateKey,
  ));
}
