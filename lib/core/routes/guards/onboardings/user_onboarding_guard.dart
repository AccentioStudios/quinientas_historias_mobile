import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';

import '../../../data/dto/auth_dto.dart';
import '../../../data/entities/user_entity.dart';
import '../../../helpers/shared_preferences_helper.dart';
import '../../../integrations/secure_storage_service.dart';
import '../../auto_router.dart';

class UserOnboardingGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // get session data
    final JwtPayload? sessionData =
        await GetIt.I<SecureStorageService>().getSessionData();

    if (sessionData == null) {
      resolver.next(true);
      return;
    }

    final isFirstTime = verifyIfFirstTime(sessionData.role);
    if (isFirstTime) {
      router.push(OnboardingUserRoute(
          role: sessionData.role,
          onResult: () {
            setBoolTrueByRole(sessionData.role);
            resolver.next(true);
          }));
    } else {
      resolver.next(true);
    }
  }

  static void setBoolTrueByRole(Role role) {
    final instance = SharedPreferencesHelper.instance;
    var key = '';
    switch (role) {
      case Role.reader:
        key = 'readerOnboarding';
        break;
      case Role.captain:
        key = 'readerOnboarding';
        break;
      case Role.prof:
        key = 'profOnboarding';
        break;
      default:
        return;
    }
    instance.setBool(key, true);
  }

  static bool verifyIfFirstTime(Role role) {
    final instance = SharedPreferencesHelper.instance;
    var key = '';
    switch (role) {
      case Role.reader:
        key = 'readerOnboarding';
        break;
      case Role.captain:
        key = 'readerOnboarding';
        break;
      case Role.prof:
        key = 'profOnboarding';
        break;
      default:
        return false;
    }
    final isNotFirstTime = instance.getBool(key);
    if (isNotFirstTime == true) {
      return false;
    }
    return true;
  }
}
