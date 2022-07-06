import 'package:flutter/material.dart';
import 'package:quinientas_historias/features/home/home_provider.dart';

import '../../features/auth/auth_provider.dart';
import '../../features/landing/ui/landing_provider.dart';

abstract class Routes {
  static const String root = '/';
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> generateRoutes() {
    return <String, WidgetBuilder>{
      root: (context) => const LandingProvider(),
      login: (context) => const AuthProvider(),
      home: (context) => const HomeProvider(),
    };
  }
}
