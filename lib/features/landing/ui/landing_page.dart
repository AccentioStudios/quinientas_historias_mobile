import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/routes/routes.dart';

class LandingPage extends StatefulWidget {
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

  Future<void> initCheckings() async {
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
  }
}
