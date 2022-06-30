import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/constants.dart';

enum HeroHeaderDayState { day, evening, night }

class HeroHeader extends StatelessWidget {
  const HeroHeader({
    Key? key,
    this.dayState = HeroHeaderDayState.day,
    this.small = false,
    this.onTap,
    this.bookName,
  }) : super(key: key);
  final HeroHeaderDayState dayState;
  final bool small;
  final GestureTapCallback? onTap;
  final String? bookName;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: small ? 92 : 140,
      decoration: BoxDecoration(
        borderRadius: Constants.borderRadius23,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: Constants.borderRadius23,
        onTap: () {},
        child: Stack(
          fit: StackFit.expand,
          children: [
            buildBackgroundImage(),
            small ? buildSmallContent() : buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget buildBackgroundImage() {
    String imagePath = '';
    switch (dayState) {
      case HeroHeaderDayState.day:
        imagePath = small
            ? 'assets/images/day-illustration-small.svg'
            : 'assets/images/day-illustration.svg';
        break;
      case HeroHeaderDayState.evening:
        imagePath = small
            ? 'assets/images/evening-illustration-small.svg'
            : 'assets/images/evening-illustration.svg';
        break;
      case HeroHeaderDayState.night:
        imagePath = small
            ? 'assets/images/night-illustration-small.svg'
            : 'assets/images/night-illustration.svg';
        break;
    }
    return SvgPicture.asset(
      imagePath,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }

  Widget buildSmallContent() {
    const textShadow = [
      Shadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 7.0,
        color: Color.fromARGB(31, 0, 0, 0),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Constants.space12, horizontal: Constants.space18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  'assets/icons/flame-icon.svg',
                  color: const Color(0xFFFFB84D),
                ),
              ),
              const SizedBox(width: Constants.space8),
              const Text(
                '¿Vamos a comenzar con la lectura?',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  shadows: textShadow,
                ),
              ),
            ],
          ),
          const SizedBox(height: Constants.space4),
          const Text(
            'Lee cada dia para entrar en racha y \nhacer mas puntos',
            style: TextStyle(
              fontSize: 15,
              shadows: textShadow,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    double completedPercentage = 40;
    const textShadow = [
      Shadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 7.0,
        color: Color.fromARGB(31, 0, 0, 0),
      ),
    ];
    final Widget textHeader = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Mis Lecturas Diarias',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: textShadow,
            ),
          ),
          const SizedBox(height: Constants.space4),
          Text(
            'Leyendo: ${bookName}',
            style: const TextStyle(
              fontSize: 15,
              shadows: textShadow,
            ),
          ),
        ]);
    final Widget progressBar = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Has completado el ${completedPercentage.toInt()}% de tu meta diaria',
          textAlign: TextAlign.right,
          style: const TextStyle(
            shadows: textShadow,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: Constants.space8),
        ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: Constants.borderRadius16,
          child: LinearProgressIndicator(
            minHeight: 7,
            value: completedPercentage / 100,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Constants.space18, horizontal: Constants.space18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textHeader,
          progressBar,
        ],
      ),
    );
  }
}
