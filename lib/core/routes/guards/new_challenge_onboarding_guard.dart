import 'package:auto_route/auto_route.dart';
import 'package:quinientas_historias/core/routes/auto_router.dart';

import '../../helpers/shared_preferences_helper.dart';

class NewChallengeOnboardingGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isFirstTime = verifyIfFirstTime();
    if (isFirstTime) {
      router.push(OnboardingNewChallengeRoute(onResult: () {
        SharedPreferencesHelper.instance
            .setBool('newChallengeOnboarding', true);
        router.pushAndPopUntil(const ChallengesAdminRegisterRoute(),
            predicate: (route) {
          return route.settings.name == ChallengesAdminRoute.name;
        });
      }));
    } else {
      resolver.next(true);
    }
  }

  static bool verifyIfFirstTime() {
    final instance = SharedPreferencesHelper.instance;
    final isNotFirstTime = instance.getBool('newChallengeOnboarding');
    if (isNotFirstTime == true) {
      return false;
    }
    return true;
  }
}
