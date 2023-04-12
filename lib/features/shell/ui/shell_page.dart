import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/auto_router.dart';

@RoutePage()
class ShellPage extends StatelessWidget {
  const ShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        const HomeRoute(),
        const TournamentRoute(),
        UserProfileRoute(),
        const ConfigRoute(),
      ],
      transitionBuilder: (context, child, animation) {
        return TransitionsBuilders.noTransition(
            context, animation, animation, child);
      },
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: SizedBox(
            height: 71,
            child: BottomNavigationBar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                selectedLabelStyle: TextStyle(
                  height: 1.5,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                type: BottomNavigationBarType.fixed,
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  // here we switch between tabs
                  tabsRouter.setActiveIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon:
                        SvgPicture.asset('assets/icons/home-outline-icon.svg'),
                    activeIcon: SvgPicture.asset(
                      'assets/icons/home-icon.svg',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        'assets/icons/trophy-outline-icon.svg'),
                    activeIcon: SvgPicture.asset(
                      'assets/icons/trophy-icon.svg',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: 'Torneos',
                  ),
                  BottomNavigationBarItem(
                    icon:
                        SvgPicture.asset('assets/icons/user-outline-icon.svg'),
                    activeIcon: SvgPicture.asset(
                      'assets/icons/user-icon.svg',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: 'Perfil',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        'assets/icons/settings-outline-icon.svg'),
                    activeIcon: SvgPicture.asset(
                      'assets/icons/settings-icon.svg',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: 'Conf',
                  ),
                ]),
          ),
        );
      },
    );
  }
}
