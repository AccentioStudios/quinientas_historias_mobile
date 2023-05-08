import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/auth_provider.dart';
import '../../features/challenges/challenges_admin_provider.dart';
import '../../features/challenges/ui/pages/admin/onboarding_new_challenge_page.dart';
import '../../features/challenges/challenges_provider.dart';
import '../../features/challenges/ui/pages/admin/challenges_admin_register.dart';
import '../../features/config/ui/pages/config_page.dart';
import '../../features/explore/explore_provider.dart';
import '../../features/home/home_provider.dart';
import '../../features/home/ui/bloc/cubit/home_cubit.dart';
import '../../features/invites/received/received_invite_provider.dart';
import '../../features/invites/send/send_invite_provider.dart';
import '../../features/profiles_module/school_profile/school_profile_provider.dart';
import '../../features/profiles_module/team_profile/team_profile_provider.dart';
import '../../features/profiles_module/user_profile/user_profile_provider.dart';
import '../../features/reading_module/reading_story/reading_story_provider.dart';
import '../../features/shell/ui/shell_page.dart';
import '../../features/tournament/tournament_provider.dart';
import '../data/entities/team_entity.dart';
import '../data/entities/user_entity.dart';
import '../integrations/secure_storage_service.dart';
import '../integrations/remote_config_service.dart';
import '../ui/pages/common_page_layout.dart';
import 'guards/admin_auth_guard.dart';
import 'guards/new_challenge_onboarding_guard.dart';

part 'auto_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Provider|Page,Route')
class AppRouter extends _$AppRouter implements AutoRouteGuard {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: ShellRoute.page,
          children: [
            AutoRoute(path: '', page: HomeRoute.page),
            AutoRoute(path: 'tournaments', page: TournamentRoute.page),
            AutoRoute(path: 'user', page: UserProfileRoute.page),
            AutoRoute(path: 'config', page: ConfigRoute.page),
          ],
        ),
        // AutoRoute(path: '/tournament', page: TournamentDetailsRoute.page),
        AutoRoute(path: '/user/:id', page: UserProfileRoute.page),
        AutoRoute(path: '/school/:id', page: SchoolProfileRoute.page),
        AutoRoute(path: '/team/:id', page: TeamProfileRoute.page),
        AutoRoute(path: '/auth', page: AuthRoute.page),
        AutoRoute(path: '/common_info', page: CommonInfoRoute.page),
        AutoRoute(path: '/story/:id', page: ReadingStoryRoute.page),
        AutoRoute(path: '/invite/received', page: ReceivedInviteRoute.page),
        AutoRoute(path: '/invite/send', page: SendInviteRoute.page),
        AutoRoute(path: '/explore', page: ExploreStoriesRoute.page),
        AutoRoute(path: '/challenge', page: ChallengesRoute.page),
        AutoRoute(
          path: '/challenge/admin',
          page: ChallengesAdminRoute.page,
          children: [
            AutoRoute(
              path: 'register',
              page: OnboardingNewChallengeRoute.page,
              guards: [
                AdminAuthGuard(),
              ],
            ),
          ],
          guards: [AdminAuthGuard()],
        ),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // check if the app is in not in maintenance mode
    if (!_checkMaintenanceMode() ||
        resolver.route.name == CommonInfoRoute.name) {
      // check if the user is authenticated
      if (await _checkAccessToken() ||
          resolver.route.name == ReceivedInviteRoute.name ||
          resolver.route.name == AuthRoute.name ||
          resolver.route.name == CommonInfoRoute.name) {
        // we continue navigation
        resolver.next();
      } else {
        // else we navigate to the Login page so we get authenticateed
        // we redirect the user to our login page
        push(AuthRoute(
            autoNavigateToShell: false,
            onResult: (success) {
              if (success == true) {
                resolver.next(true);
              } else {
                resolver.next(false);
              }
            }));
      }
    } else {
      // else we navigate to the maintenance page
      push(CommonInfoRoute(
        headline: 'Volveremos pronto',
        message:
            'Nuestro equipo esta trabajando fuertemente\npara hacer todavia mejor tu experiencia, volveremos lo mas rápido posible!, lo prometemos.',
        riveAnimationPath: 'assets/images/maintenance-animation.riv',
        withoutBtns: true,
      ));
    }
  }

  static bool _checkMaintenanceMode() {
    final remoteConfig = RemoteConfigService.instance;
    final bool response = remoteConfig.getBool('maintenance_mode');
    return response;
  }

  static Future<bool> _checkAccessToken() async {
    final String? secureStorage =
        await GetIt.I<SecureStorageService>().getAccessToken();
    final test = secureStorage != null;
    return test;
  }
}

// @MaterialAutoRouter(
//   routes: <AutoRoute>[
//     AutoRoute(
//       page: HomeScreen,
//       name: 'HomeRoute',
//       path: '/',
//     ),
//     AutoRoute(
//       page: DashboardScreen,
//       name: 'DashboardRoute',
//       path: '/dashboard',
//       children: <AutoRoute>[
//         AutoRoute<EmptyRouterPage>(
//           name: 'ProductsRoute',
//           path: 'products',
//           page: EmptyRouterPage,
//           children: [
//             AutoRoute(
//               page: ProductsScreen,
//               path: '',
//             ),
//             AutoRoute(
//                 page: AddProductsScreen,
//                 name: 'AddProductsRoute',
//                 path: 'add_products'),
//           ],
//         ),
//         AutoRoute(page: ProfileScreen, name: 'ProfileRoute', path: 'profile')
//       ],
//     ),
//     AutoRoute(page: AboutScreen, name: 'AboutRouter', path: '/about')
//   ],
// )
// class $AppRouter {}
