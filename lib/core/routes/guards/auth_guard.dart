import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';

import '../../integrations/secure_storage_service.dart';
import '../auto_router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if (await _checkAccessToken()) {
      // if user is authenticated we continue
      resolver.next(true);
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

  static Future<bool> _checkAccessToken() async {
    final String? secureStorage =
        await GetIt.I<SecureStorageService>().getAccessToken();
    final test = secureStorage != null;
    return test;
  }
}
