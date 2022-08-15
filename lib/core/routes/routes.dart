import 'package:flutter/material.dart';

import '../../features/auth/auth_provider.dart';
import '../../features/home/home_provider.dart';
import '../../features/landing/ui/landing_provider.dart';
import '../../features/profiles_module/school_profile/school_profile_provider.dart';
import '../../features/profiles_module/team_profile/team_profile_provider.dart';
import '../../features/profiles_module/user_profile/user_profile_provider.dart';

abstract class Routes {
  static const String root = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String schoolProfile = '/schoolProfile';
  static const String teamProfile = '/teamProfile';
  static const String userProfile = '/userProfile';

  static Map<String, WidgetBuilder> generateRoutes() {
    return <String, WidgetBuilder>{
      root: (context) => const LandingProvider(),
      login: (context) => const AuthProvider(),
      home: (context) => const HomeProvider(),
      schoolProfile: (context) => const SchoolProfileProvider(),
      teamProfile: (context) => const TeamProfileProvider(),
      userProfile: (context) => const UserProfileProvider(),
    };
  }
}
