import 'package:flutter/material.dart';
import 'package:quinientas_historias/core/ui/widgets/outlined_card.dart';

import '../../../../core/data/entities/school_entity.dart';
import '../../../../core/data/entities/tournament_entity.dart';
import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/ui/widgets/percentage_progress_bar.dart';
import '../../../../core/ui/widgets/single_chip.dart';
import '../../../../core/utils/calculate_things.dart';
import '../../../../core/utils/constants.dart';
import '../../../profiles_module/school_profile/school_profile_provider.dart';
import '../../../profiles_module/user_profile/user_profile_provider.dart';
import '../bloc/cubit/home_cubit.dart';
import '../widgets/home_app_bar.dart';

class HomeProfLayout extends StatelessWidget {
  const HomeProfLayout({Key? key, required this.state}) : super(key: key);
  final HomeState state;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 0),
      physics: const BouncingScrollPhysics(),
      children: [
        ProfHeader(
          state: state,
          userProfileOnTap: () {
            _navigateToMyProfilePage(context, state.dashboard?.user);
          },
        ),
        PaddingColumn(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
          children: [
            const SizedBox(height: Constants.space21),
            OutlinedCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(state.dashboard!.tournament!.title ??
                        'Torneo de lectura'),
                  ),
                  const SizedBox(height: Constants.space12),
                  PercentageProgressBar(
                    completedPercentage: CalculateThings.percentage(
                        100,
                        calculatePercentageTournament(
                            state.dashboard!.tournament!)),
                    backgroundColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: Constants.space12),
                  Text(
                    'Quedan ${getTournamentDayLeft(state.dashboard!.tournament!)} dias',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Constants.space21),
            SingleChip(
              primaryLabel: 'Mi escuela',
              secondaryLabel: 'Escuela Paralelepipedo',
              onTap: () {
                _navigateToMySchoolPage(context, state.dashboard?.user.school);
              },
            ),
          ],
        ),
      ],
    );
  }

  int calculatePercentageTournament(Tournament tournament) {
    var initDate = tournament.createdAt;
    var endDate = tournament.endsAt;
    var today = DateTime.now();

    var from = DateTime(initDate.year, initDate.month, initDate.day);
    var to = DateTime(endDate.year, endDate.month, endDate.day);

    var daysDifferenceFromTodayDate =
        (to.difference(today).inHours / 24).round();

    var daysDifferenceFromInitDate = (to.difference(from).inHours / 24).round();

    return (daysDifferenceFromTodayDate * 100 / daysDifferenceFromInitDate)
        .round();
  }

  int getTournamentDayLeft(Tournament tournament) {
    var endDate = tournament.endsAt;
    var today = DateTime.now();
    var to = DateTime(endDate.year, endDate.month, endDate.day);

    var daysDifferenceFromTodayDate =
        (to.difference(today).inHours / 24).round();

    return daysDifferenceFromTodayDate;
  }

  void _navigateToMySchoolPage(BuildContext context, School? mySchool) {
    if (mySchool != null) {
      Navigator.pushNamed(
        context,
        Routes.schoolProfile,
        arguments: SchoolProfileArguments(
          mySchool.id,
        ),
      );
    }
  }

  void _navigateToMyProfilePage(BuildContext context, User? myUser) {
    if (myUser != null) {
      Navigator.pushNamed(
        context,
        Routes.userProfile,
        arguments: UserProfileArguments(
          myUser.id,
        ),
      );
    }
  }
}

class ProfHeader extends StatelessWidget {
  const ProfHeader(
      {Key? key, required this.state, required this.userProfileOnTap})
      : super(key: key);
  final HomeState state;
  final GestureTapCallback? userProfileOnTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 84 + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(children: [
        HomeAppBar(
          user: state.dashboard?.user,
          onTap: userProfileOnTap,
          hideStreak: true,
        ),
      ]),
    );
  }
}
