import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

import '../features/invites/received/received_invite_provider.dart';
import 'integrations/firebase_messaging_service.dart';
import 'integrations/notification_service.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

class Application extends StatefulWidget {
  const Application({Key? key, required this.navigatorKey}) : super(key: key);

  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _incomingLinkHandler();
    if (!kIsWeb) {
      initilizeFirebaseMessaging();
      checkNotifications();
    }
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '500 Historias',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      routes: Routes.generateRoutes(),
      initialRoute: Routes.landing,
      navigatorKey: widget.navigatorKey,
    );
  }

  initilizeFirebaseMessaging() async {
    await Provider.of<FirebaseMessagingService>(context, listen: false)
        .initialize();
  }

  checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false)
        .checkForNotifications();
  }

  void _incomingLinkHandler() {
    // 1
    if (!kIsWeb) {
      // 2
      _streamSubscription = uriLinkStream.listen((Uri? uri) {
        if (!mounted) {
          return;
        }
        debugPrint('Received URI: $uri');
        _navigateToRouteFromDeepLink(uri);
        // 3
      }, onError: (Object err) {
        if (!mounted) {
          return;
        }
        debugPrint('Error occurred: $err');
      });
    }
  }

  _navigateToRouteFromDeepLink(Uri? uri) {
    if (uri != null) {
      if (uri.queryParameters.keys.contains('email') &&
          uri.queryParameters.keys.contains('invite')) {
        ReceivedInviteProvider.open(null,
            navigatorKey: widget.navigatorKey,
            email: uri.queryParameters['email'] ?? '',
            code: uri.queryParameters['invite'] ?? '');
        return;
      }
      Fluttertoast.showToast(msg: 'Link inválido.');
    }
  }
}
