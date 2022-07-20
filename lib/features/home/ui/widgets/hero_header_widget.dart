import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quinientas_historias/core/data/entities/daily_challenge_entity.dart';

import '../../../../core/ui/widgets/percentage_progress_bar.dart';
import '../../../../core/utils/constants.dart';

enum HeroHeaderDayState { day, evening, night }

class HeroHeader extends StatelessWidget {
  const HeroHeader({
    Key? key,
    this.dayState = HeroHeaderDayState.day,
    this.dailyChallenge,
    this.onTap,
  }) : super(key: key);
  final HeroHeaderDayState dayState;
  final DailyChallenge? dailyChallenge;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 93,
      decoration: BoxDecoration(
        borderRadius: Constants.borderRadius23,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: Constants.borderRadius23,
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            buildBackgroundImage(),
            ifDailyChallengeExists()
                ? buildContentChallangeOngoing(context)
                : buildContentInitial(),
          ],
        ),
      ),
    );
  }

  bool ifDailyChallengeExists() {
    if (dailyChallenge != null) {
      if (dailyChallenge?.challenge.isNotEmpty == true) {
        return true;
      }
    }
    return false;
  }

  Widget buildBackgroundImage() {
    String imagePath = '';
    switch (dayState) {
      case HeroHeaderDayState.day:
        imagePath = 'assets/images/day-illustration-small.svg';

        break;
      case HeroHeaderDayState.evening:
        imagePath = 'assets/images/evening-illustration-small.svg';
        break;
      case HeroHeaderDayState.night:
        imagePath = 'assets/images/night-illustration-small.svg';
        break;
    }
    return SvgPicture.asset(
      imagePath,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }

  Widget buildContentInitial() {
    const textShadow = [
      Shadow(
        offset: Offset(0.0, 1.0),
        blurRadius: 3.0,
        color: Color.fromARGB(92, 0, 0, 0),
      ),
      Shadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 7.0,
        color: Color.fromARGB(38, 0, 0, 0),
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

  Widget buildContentChallangeOngoing(BuildContext context) {
    const textShadow = [
      Shadow(
        offset: Offset(0.0, 1.0),
        blurRadius: 3.0,
        color: Color.fromARGB(92, 0, 0, 0),
      ),
      Shadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 7.0,
        color: Color.fromARGB(38, 0, 0, 0),
      ),
    ];

    int completedPercentage =
        calculatePercentage(dailyChallenge?.count, dailyChallenge?.readed);
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Constants.space18, horizontal: Constants.space21),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mis Lecturas Diarias',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: textShadow,
                ),
              ),
              const SizedBox(height: Constants.space4),
              Text(
                'Has completado el $completedPercentage% de tu meta diaria',
                style: const TextStyle(
                  fontSize: 15,
                  shadows: textShadow,
                ),
              ),
            ],
          ),
          PercentageProgressBar(
            completedPercentage: completedPercentage,
          )
        ],
      ),
    );
  }

  int calculatePercentage(int? total, int? current) {
    if (total != null && current != null) {
      if (total > 0) {
        return (current * 100 ~/ total).toInt();
      }
      return 0;
    }
    return 0;
  }
}
