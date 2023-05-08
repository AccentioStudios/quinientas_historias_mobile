import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';

import '../../data/dto/auth_dto.dart';
import '../../data/entities/user_entity.dart';
import '../../integrations/secure_storage_service.dart';
import '../auto_router.dart';

class AdminAuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if (await _checkAccessToken()) {
      // if user is Admin we continue
      if (await checkUserIsAdmin()) {
        resolver.next(true);
      } else {
        // if now, we redirect the user to our login page
        router.push(AuthRoute(
            autoNavigateToShell: false,
            byPassFirstScreen: true,
            onResult: (success) async {
              if (success == true) {
                // if user is Admin we continue
                if (await checkUserIsAdmin()) {
                  resolver.next(true);
                } else {
                  router.pushNamed('/');
                }
              } else {
                router.pushNamed('/');
              }
            }));
      }
    } else {
      // we redirect the user to our login page
      router.push(AuthRoute(
          autoNavigateToShell: false,
          byPassFirstScreen: true,
          onResult: (success) {
            if (success == true) {
              resolver.next(true);
            } else {
              resolver.next(false);
            }
          }));
    }
  }

  static Future<bool> checkUserIsAdmin() async {
    // if user is authenticated we continue
    final JwtPayload? sessionData =
        await GetIt.I<SecureStorageService>().getSessionData();

    return sessionData?.role == Role.admin;
  }

  static Future<bool> _checkAccessToken() async {
    final String? secureStorage =
        await GetIt.I<SecureStorageService>().getAccessToken();
    final test = secureStorage != null;
    return test;
  }
}
