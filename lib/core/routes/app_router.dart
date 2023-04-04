// import 'package:flutter/material.dart';
// import 'package:auto_route/auto_route.dart';
// import '../../features/auth/auth_provider.dart';
// import '../../features/home/ui/pages/home_navigator.dart';
// import '../../features/landing/ui/landing_provider.dart';

// part 'app_router.gr.dart';

// @AutoRouterConfig(replaceInRouteName: 'Navigator|Provider,Route')
// class AppRouter extends _$AppRouter {
//   static const String rootRoute = '/';
//   static const String landing = '/landing';
//   static const String login = '/login';
//   static const String home = '/home';

//   static const String homeNavigator = '/homeNavigator';
//   static const String dailyChallenge = '/dailyChallenge';
//   static const String tournament = '/tournament';
//   static const String schoolProfile = '/schoolProfile';
//   static const String teamProfile = '/teamProfile';
//   static const String userProfile = '/userProfile';
//   static const String configRoute = '/config';

//   @override
//   final List<AutoRoute> routes = [
//     /// routes go here
//     AutoRoute(page: LandingRoute.page, path: '/'),
//     AutoRoute(
//       page: AuthRoute.page,
//       path: login,
//     ),
//     AutoRoute(
//       page: HomeRoute.page,
//       path: homeNavigator,
//     ),
//   ];
// }
