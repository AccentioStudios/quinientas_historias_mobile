import 'package:flutter/material.dart';

import 'routes/routes.dart';
import 'theme/theme.dart';

class Application extends StatelessWidget {
  const Application({Key? key, required this.navigatorKey}) : super(key: key);

  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: '500 Historias',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      routes: Routes.generateRoutes(),
      initialRoute: Routes.root,
    );
  }
}
