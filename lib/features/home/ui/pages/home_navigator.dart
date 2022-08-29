import 'package:flutter/material.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/buttom_bar.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  late GlobalKey<NavigatorState> homeNavigatorKey;
  @override
  void initState() {
    homeNavigatorKey = GlobalKey<NavigatorState>();
    super.initState();
  }

  String currentRouteOption = Routes.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionBtnDocked(
      //   onPressed: () {
      //     navigateToDailyChallengePage(homeNavigatorKey.currentContext);
      //   },
      // ),
      bottomNavigationBar: AppButtonBar(
        activeOption: getCurrentRouteOption(),
        onSelectOption: (activeOptionAppButtonBar) {
          navigate(homeNavigatorKey.currentContext, activeOptionAppButtonBar);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: NestedNavigator(
        navigationKey: homeNavigatorKey,
        didPopNextRoute: (Route<dynamic> route, Route<Object?>? previousRoute) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final String previousPageName = previousRoute?.settings.name ?? '';
            setState(() {
              currentRouteOption = previousPageName;
            });
          });
        },
        didPushRoute: (Route<dynamic>? route, Route<Object?>? previousRoute) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final String pageName = route?.settings.name ?? '';
            setState(() {
              currentRouteOption = pageName;
            });
          });
        },
        onChangeRoute: (Route<dynamic> route, Route<Object?>? previousRoute) {},
        initialRoute: Routes.home,
        routes: Routes.generateHomeNavigatorRoutes(),
      ),
    );
  }

  ActiveOptionAppButtonBar getCurrentRouteOption() {
    if (currentRouteOption == Routes.home) {
      return ActiveOptionAppButtonBar.home;
    }
    if (currentRouteOption == Routes.tournament) {
      return ActiveOptionAppButtonBar.tournament;
    }
    if (currentRouteOption == Routes.dailyChallenge) {
      return ActiveOptionAppButtonBar.dailyChallenge;
    }
    if (currentRouteOption == Routes.userProfile) {
      return ActiveOptionAppButtonBar.profile;
    }
    if (currentRouteOption == Routes.config) {
      return ActiveOptionAppButtonBar.configurations;
    }
    return ActiveOptionAppButtonBar.none;
    // if (currentRouteOption == Routes.home) {
    //   return ActiveOptionAppButtonBar.configurations;
    // }
  }

  void navigateToDailyChallengePage(BuildContext? context) {
    if (context != null) {
      Navigator.of(context).pushNamed(Routes.dailyChallenge);
    }
  }

  void navigate(BuildContext? context, ActiveOptionAppButtonBar option) {
    if (context != null) {
      switch (option) {
        case ActiveOptionAppButtonBar.home:
          Navigator.of(context).pushNamed(Routes.home);
          return;
        case ActiveOptionAppButtonBar.tournament:
          Navigator.of(context).pushNamed(Routes.tournament);
          return;

        case ActiveOptionAppButtonBar.dailyChallenge:
          Navigator.of(context).pushNamed(Routes.dailyChallenge);
          return;
        case ActiveOptionAppButtonBar.profile:
          Navigator.of(context).pushNamed(Routes.userProfile);
          return;
        case ActiveOptionAppButtonBar.configurations:
          Navigator.of(context).pushNamed(Routes.config);
          return;
        case ActiveOptionAppButtonBar.none:
          // TODO: Handle this case.
          return;
      }
    }
  }
}

class NestedNavigator extends StatefulWidget {
  const NestedNavigator({
    super.key,
    required this.navigationKey,
    required this.initialRoute,
    required this.routes,
    required this.didPushRoute,
    required this.didPopNextRoute,
    required this.onChangeRoute,
  });
  final GlobalKey<NavigatorState> navigationKey;
  final String initialRoute;
  final Map<String, WidgetBuilder> routes;
  final Function(Route<dynamic>? route, Route<Object?>? previousRoute)
      didPushRoute;
  final Function(Route<dynamic> route, Route<Object?>? previousRoute)
      didPopNextRoute;
  final Function(Route<dynamic> route, Route<Object?>? previousRoute)
      onChangeRoute;

  @override
  State<NestedNavigator> createState() => _NestedNavigatorState();
}

class _NestedNavigatorState extends State<NestedNavigator> {
  late NavigatorObserver observer;
  @override
  void initState() {
    observer = MyNavigatorObserver(
      onChangeRoute: widget.onChangeRoute,
      didPopNextRoute: widget.didPopNextRoute,
      didPushRoute: widget.didPushRoute,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool maybePop =
            await widget.navigationKey.currentState?.maybePop() ?? false;
        return !maybePop;
      },
      child: Navigator(
        key: widget.navigationKey,
        initialRoute: widget.initialRoute,
        observers: <NavigatorObserver>[observer],
        onGenerateRoute: (RouteSettings routeSettings) {
          final String pageName = routeSettings.name ?? '';
          final WidgetBuilder? builder = widget.routes[pageName];
          if (builder != null) {
            return MaterialPageRoute(
                settings: routeSettings,
                builder: (context) => builder(context));
          }
          return null;
          // return SwipePageRoute<dynamic>(
          //   pageBuilderFunction: (BuildContext context,
          //           Animation<double> animation,
          //           Animation<double> secondaryAnimation) =>
          //       builder!(context),
          //   routeSettings: routeSettings,
          // );
        },
      ),
    );
  }
}

class SwipePageRoute<T> extends PageRouteBuilder<T> {
  SwipePageRoute(
      {this.exitPage, required this.pageBuilderFunction, this.routeSettings})
      : super(
            settings: routeSettings,
            pageBuilder: pageBuilderFunction,
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              const Offset begin = Offset(0.1, 0.0);
              const Offset end = Offset.zero;
              const ElasticInOutCurve curve = Curves.elasticInOut;
              final Animatable<Offset> tween =
                  Tween<Offset>(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

              final Animation<Offset> offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            });

  final Widget? exitPage;
  final RoutePageBuilder pageBuilderFunction;
  final RouteSettings? routeSettings;
}

class MyNavigatorObserver extends NavigatorObserver {
  MyNavigatorObserver({
    required this.didPushRoute,
    required this.didPopNextRoute,
    required this.onChangeRoute,
  });

  final Function(Route<dynamic> route, Route<Object?> previousRoute)
      onChangeRoute;
  final Function(Route<dynamic>? route, Route<Object?>? previousRoute)
      didPushRoute;
  final Function(Route<dynamic> route, Route<Object?>? previousRoute)
      didPopNextRoute;
  @override
  void didPush(Route<dynamic> route, Route<Object?>? previousRoute) {
    super.didPush(route, previousRoute);
    didPushRoute(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<Object?>? previousRoute) {
    super.didPop(route, previousRoute);
    didPopNextRoute(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<Object?>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      didPushRoute(newRoute, oldRoute);
    }
  }
}
