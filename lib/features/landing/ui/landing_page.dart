import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quinientas_historias/core/failures/failures.dart';
import 'package:quinientas_historias/core/integrations/remote_config_service.dart';
import 'package:quinientas_historias/core/mixins/error_handling.dart';

import '../../../core/routes/routes.dart';
import '../../../core/ui/pages/error_page.dart';

class LandingPage extends StatefulWidget with ErrorHandling {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late GlobalKey<NavigatorState> landingNavigatorKey;

  @override
  void initState() {
    landingNavigatorKey = GlobalKey<NavigatorState>();
    super.initState();
    initCheckings();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
      // body: Navigator(
      //   key: landingNavigatorKey,
      //   initialRoute: Routes.home,
      //   onGenerateRoute: (routeSettings) {
      //     final String pageName = routeSettings.name ?? '';
      //     final WidgetBuilder? builder = routeBuilders[pageName];
      //     return MaterialPageRoute(builder: (context) => builder!(context));
      //   },
      // ),
    );
  }

  Future<bool> _checkAccessToken() async {
    const secureStorage = FlutterSecureStorage();
    return await secureStorage.containsKey(key: 'accessToken');
  }

  bool _checkMaintenanceMode() {
    final remoteConfig = RemoteConfigService.instance;
    final bool response = remoteConfig.getBool('maintenance_mode');
    return response;
  }

  Future<void> initCheckings() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_checkMaintenanceMode()) {
        Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
                builder: (context) => const ErrorPage(
                      headline: 'Volveremos pronto',
                      message:
                          'Nuestro equipo esta trabajando fuertemente\npara hacer todavia mejor tu experiencia, volveremos lo mas rápido posible!, lo prometemos.',
                      riveAnimationPath:
                          'assets/images/maintenance-animation.riv',
                      withoutBtns: true,
                    )));
        return;
      }

      if (await _checkAccessToken()) {
        Navigator.of(context, rootNavigator: true)
            .popUntil((route) => route.isFirst);
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed(Routes.homeNavigator);
      } else {
        Navigator.of(context, rootNavigator: true)
            .popUntil((route) => route.isFirst);
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed(Routes.login);
      }
      // Add Your Code here.
    });
  }
}
