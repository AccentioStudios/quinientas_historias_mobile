import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants.dart';

enum ActiveOptionAppButtonBar {
  home,
  tournament,
  dailyChallenge,
  profile,
  configurations,
  none
}

class AppButtonBar extends StatelessWidget {
  const AppButtonBar({
    Key? key,
    required this.activeOption,
    required this.onSelectOption,
  }) : super(key: key);

  final ActiveOptionAppButtonBar activeOption;
  final Function(ActiveOptionAppButtonBar) onSelectOption;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 71,
      child: BottomAppBar(
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: const CircularNotchedRectangle(),
        notchMargin: 7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space21),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _Item(
                active: activeOption == ActiveOptionAppButtonBar.home,
                labelText: 'Home',
                iconSvgPath: 'assets/icons/home-outline-icon.svg',
                activeIconSvgPath: 'assets/icons/home-icon.svg',
                onPressed: () {
                  if (activeOption != ActiveOptionAppButtonBar.home) {
                    onSelectOption(ActiveOptionAppButtonBar.home);
                  }
                },
              ),
              _Item(
                active: activeOption == ActiveOptionAppButtonBar.tournament,
                labelText: 'Torneo',
                iconSvgPath: 'assets/icons/trophy-outline-icon.svg',
                activeIconSvgPath: 'assets/icons/trophy-icon.svg',
                onPressed: () {
                  if (activeOption != ActiveOptionAppButtonBar.tournament) {
                    onSelectOption(ActiveOptionAppButtonBar.tournament);
                  }
                },
              ),
              // const SizedBox(width: Constants.space21),
              _Item(
                active: activeOption == ActiveOptionAppButtonBar.profile,
                labelText: 'Perfil',
                iconSvgPath: 'assets/icons/user-outline-icon.svg',
                activeIconSvgPath: 'assets/icons/user-icon.svg',
                onPressed: () {
                  if (activeOption != ActiveOptionAppButtonBar.profile) {
                    onSelectOption(ActiveOptionAppButtonBar.profile);
                  }
                },
              ),
              _Item(
                active: activeOption == ActiveOptionAppButtonBar.configurations,
                labelText: 'Conf',
                iconSvgPath: 'assets/icons/settings-outline-icon.svg',
                activeIconSvgPath: 'assets/icons/settings-icon.svg',
                onPressed: () {
                  if (activeOption != ActiveOptionAppButtonBar.configurations) {
                    onSelectOption(ActiveOptionAppButtonBar.configurations);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    this.labelText,
    required this.iconSvgPath,
    required this.activeIconSvgPath,
    this.active = false,
    this.onPressed,
  }) : super(key: key);
  final String? labelText;
  final String iconSvgPath;
  final String activeIconSvgPath;
  final VoidCallback? onPressed;
  final bool active;
  @override
  Widget build(BuildContext context) {
    Color defaultColor = Theme.of(context).colorScheme.onPrimaryContainer;
    Color activeColor = Theme.of(context).colorScheme.primary;

    Color currentColor = active ? activeColor : defaultColor;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        height: 50,
        width: 50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            active
                ? SvgPicture.asset(activeIconSvgPath, color: currentColor)
                : SvgPicture.asset(iconSvgPath, color: currentColor),
            labelText != null
                ? const SizedBox(
                    height: Constants.space4,
                  )
                : const SizedBox.shrink(),
            labelText != null
                ? Text(
                    labelText!,
                    style: TextStyle(
                      color: currentColor,
                      fontFamily: 'Proxima',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class FloatingActionBtnDocked extends StatelessWidget {
  const FloatingActionBtnDocked({Key? key, this.onPressed}) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(50),
      ),
      width: 62,
      height: 62,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(50),
        ),

        child: _Item(
          onPressed: () {
            if (onPressed != null) return onPressed!();
          },
          iconSvgPath: 'assets/icons/book-open-outline-icon.svg',
          activeIconSvgPath: 'assets/icons/book-open-icon.svg',
        ), //icon inside button
      ),
    );
  }

  // void _navigateToDailyChallengePage(
  //   BuildContext context,
  // ) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => const DailyChallangeProvider()));
  // }
}
