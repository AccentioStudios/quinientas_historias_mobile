import 'package:flutter/material.dart';

import '../../features/auth/auth_provider.dart';

import '../../features/home/home_provider.dart';
import '../../features/home/ui/pages/home_navigator.dart';
import '../../features/landing/ui/landing_provider.dart';

abstract class Routes {
  static const String root = '/';
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
  static const String challenges = '/challenges';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState>? shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static Map<String, WidgetBuilder> generateRoutes() {
    return <String, WidgetBuilder>{
      root: (context) => const LandingProvider(),
      landing: (context) => const LandingProvider(),
      login: (context) => const AuthProvider(),
      homeNavigator: (context) => const HomeNavigator(),
    };
  }

  static Map<String, WidgetBuilder> generateHomeNavigatorRoutes() {
    return <String, WidgetBuilder>{
      home: (context) => const HomeProvider(),
      // schoolProfile: (context) => const SchoolProfileProvider(),
      // dailyChallenge: (context) => const DailyChallangeProvider(),
      // tournament: (context) => const TournamentProvider(),
      // teamProfile: (context) => const TeamProfileProvider(),
      // userProfile: (context) => const UserProfileProvider(),
      // config: (context) => const ConfigPage(),
      // challenges: (context) => const ChallengesProvider(),
    };
  }
}
