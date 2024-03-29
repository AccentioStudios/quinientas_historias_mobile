import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

import 'integrations/firebase_messaging_service.dart';
import 'integrations/notification_service.dart';
import 'routes/auto_router.dart';
import 'theme/theme.dart';

class Application extends StatefulWidget {
  const Application({super.key, required this.router});
  final AppRouter router;
  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  StreamSubscription? _streamDeeplink;
  // Uri? _initialUri;
  // bool _initialURILinkHandled = false;
  @override
  void initState() {
    super.initState();
    initCheckings();
    if (!kIsWeb) {
      initilizeFirebaseMessaging();
      checkNotifications();
    }
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _streamDeeplink?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: '500 Historias',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeClass.lightTheme,
        darkTheme: ThemeClass.darkTheme,
        routerDelegate: AutoRouterDelegate(widget.router),
        routeInformationParser: widget.router.defaultRouteParser());
    // return MaterialApp(
    //   title: '500 Historias',
    //   debugShowCheckedModeBanner: false,
    //   themeMode: ThemeMode.dark,
    //   theme: ThemeClass.lightTheme,
    //   darkTheme: ThemeClass.darkTheme,
    //   routes: Routes.generateRoutes(),
    //   initialRoute: Routes.landing,
    //   navigatorKey: widget.navigatorKey,
    // );
  }

  initilizeFirebaseMessaging() async {
    await Provider.of<FirebaseMessagingService>(context, listen: false)
        .initialize();
  }

  checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false)
        .checkForNotifications();
  }

  Future<void> initCheckings() async {
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    try {
      final initialUri = await getInitialUri();
      debugPrint("Initial URI received $initialUri");
      Future.delayed(const Duration(seconds: 1), () {
        _navigateToRouteFromDeepLink(initialUri);
      });
    } on PlatformException {
      debugPrint("Failed to receive initial uri");
    }

    // Attach a listener to the stream
    _streamDeeplink = uriLinkStream.listen((Uri? uri) {
      debugPrint("Stream listener URI received $uri");
      _navigateToRouteFromDeepLink(uri);
    }, onError: (err) {
      debugPrint("Failed to receive stream listener uri");
    });
  }

  // Future<void> initCheckings() async {
  //   await _initURIHandler();
  //   _incomingLinkHandler();
  //   if (_initialUri != null) {
  //     return;
  //   }
  // }

  // Future<void> _initURIHandler() async {
  //   // 1
  //   if (!_initialURILinkHandled) {
  //     _initialURILinkHandled = true;
  //     // 2
  //     try {
  //       // 3
  //       final initialURI = await getInitialUri();
  //       // 4
  //       if (initialURI != null) {
  //         debugPrint("Initial URI received $initialURI");
  //         setState(() {
  //           _initialUri = initialURI;
  //         });
  //         _navigateToRouteFromDeepLink(initialURI);
  //       } else {
  //         debugPrint("Null Initial URI received");
  //       }
  //     } on PlatformException {
  //       // 5
  //       debugPrint("Failed to receive initial uri");
  //     } on FormatException catch (err) {
  //       // 6
  //       debugPrint('Malformed Initial URI received $err');
  //     }
  //   }
  // }

  // void _incomingLinkHandler() {
  //   // 1
  //   if (!kIsWeb) {
  //     // 2
  //     _streamSubscription = uriLinkStream.listen((Uri? uri) {
  //       if (!mounted) {
  //         return;
  //       }
  //       debugPrint('Received URI: $uri');
  //       _navigateToRouteFromDeepLink(uri);
  //       // 3
  //     }, onError: (Object err) {
  //       if (!mounted) {
  //         return;
  //       }
  //       debugPrint('Error occurred: $err');
  //     });
  //   }
  // }

  _navigateToRouteFromDeepLink(Uri? uri) {
    if (uri != null) {
      // convert map QueryParameters to url format query parameters string
      final scheme = uri.scheme;
      final host = uri.host;
      final path = uri.path;
      final query = uri.query;

      var pathWithQueryParameters = '';
      if (scheme == 'qh-app') {
        pathWithQueryParameters = '/$host$path?$query';
      } else {
        pathWithQueryParameters = '$path?$query';
      }
      GetIt.I<AppRouter>().pushNamed(pathWithQueryParameters);
      // GetIt.I<AppRouter>().popUntil((route) => route.isFirst);
    }
  }
}
