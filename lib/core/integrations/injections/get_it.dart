import 'package:alice_lightweight/alice.dart';
import 'package:get_it/get_it.dart';

import '../../../features/challenges/sar_service.dart';
import '../../helpers/shared_preferences_helper.dart';
import '../../routes/auto_router.dart';
import '../secure_storage_service.dart';

class GetItInjector {
  // instance of GetIt package
  static final GetIt instance = GetIt.instance;

  // register all the dependencies
  static init() {
    _registerCommonDependencies();
  }

  void clear() {
    instance.reset();
  }

  static _registerCommonDependencies() {
    // Secure storage
    instance.registerSingleton<SecureStorageService>(SecureStorageService());

    // App Router with Alice Http Interceptor
    instance.registerSingleton<AppRouter>(AppRouter());
    instance.registerSingleton<Alice>(
        Alice(navigatorKey: instance.get<AppRouter>().navigatorKey));

    // SARService
    instance.registerSingleton<SARService>(SARService());
  }
}
