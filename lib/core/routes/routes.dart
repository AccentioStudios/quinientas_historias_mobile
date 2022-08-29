import 'package:flutter/material.dart';

import '../../features/auth/auth_provider.dart';
import '../../features/config/ui/pages/config_page.dart';
import '../../features/home/home_provider.dart';
import '../../features/home/ui/pages/home_navigator.dart';
import '../../features/landing/ui/landing_provider.dart';
import '../../features/profiles_module/school_profile/school_profile_provider.dart';
import '../../features/profiles_module/team_profile/team_profile_provider.dart';
import '../../features/profiles_module/user_profile/user_profile_provider.dart';
import '../../features/reading_module/daily_challenge/daily_challange_provider.dart';
import '../../features/tournament/tournament_provider.dart';

abstract class Routes {
  static const String landing = '/landing';
  static const String login = '/login';
  static const String home = '/home';

  static const String homeNavigator = '/homeNavigator';
  static const String dailyChallenge = '/dailyChallenge';
  static const String tournament = '/tournament';
  static const String schoolProfile = '/schoolProfile';
  static const String teamProfile = '/teamProfile';
  static const String userProfile = '/userProfile';
  static const String config = '/config';

  static Map<String, WidgetBuilder> generateRoutes() {
    return <String, WidgetBuilder>{
      landing: (context) => const LandingProvider(),
      login: (context) => const AuthProvider(),
      homeNavigator: (context) => const HomeNavigator(),
    };
  }

  static Map<String, WidgetBuilder> generateHomeNavigatorRoutes() {
    return <String, WidgetBuilder>{
      home: (context) => const HomeProvider(),
      schoolProfile: (context) => const SchoolProfileProvider(),
      dailyChallenge: (context) => const DailyChallangeProvider(),
      tournament: (context) => const TournamentProvider(),
      teamProfile: (context) => const TeamProfileProvider(),
      userProfile: (context) => const UserProfileProvider(),
      config: (context) => const ConfigPage(),
    };
  }
}
