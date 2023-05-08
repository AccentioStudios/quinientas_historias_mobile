import 'package:auto_route/auto_route.dart';
import 'package:quinientas_historias/core/routes/auto_router.dart';

import '../../helpers/shared_preferences_helper.dart';

class NewChallengeOnboardingGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isFirstTime = await verifyIfFirstTime();
    if (!isFirstTime) {
      resolver.next(true);
    } else {
      router.push(OnboardingNewChallengeRoute(onResult: (_) {
        resolver.next(true);
      }));
    }
  }

  static Future<bool> verifyIfFirstTime() async {
    final instance = SharedPreferencesHelper.instance;
    final isNotFirstTime = instance.getBool('newChallengeOnboarding');
    if (isNotFirstTime != true) {
      return false;
    }
    return true;
  }
}
