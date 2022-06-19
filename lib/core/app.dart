import 'package:flutter/material.dart';

import '../ui/app_provider.dart';
import 'theme/theme.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mama Africa App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const AppProvider(),
    );
  }
}
