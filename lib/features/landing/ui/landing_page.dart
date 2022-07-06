import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/routes/routes.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    initCheckings();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<bool> _checkAccessToken() async {
    const secureStorage = FlutterSecureStorage();
    return await secureStorage.containsKey(key: 'accessToken') &&
        await secureStorage.containsKey(key: 'userId');
  }

  Future<void> initCheckings() async {
    if (await _checkAccessToken()) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacementNamed(Routes.home);
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}
