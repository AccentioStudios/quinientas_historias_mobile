import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/utils/calculate_things.dart';

import '../../../../core/data/entities/tournament_entity.dart';
import '../../../../core/ui/widgets/percentage_progress_bar.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/cubit/tournament_cubit.dart';

class TournamentHeaderWidget extends StatelessWidget {
  const TournamentHeaderWidget({Key? key, required this.state})
      : super(key: key);

  final TournamentState state;
  @override
  Widget build(BuildContext context) {
    const paddingHeader = EdgeInsets.symmetric(
        horizontal: Constants.space18, vertical: Constants.space18);
    return SliverToBoxAdapter(
      child: Container(
        height: 206 + MediaQuery.of(context).padding.top,
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Column(
          children: [
            AppBar(
                elevation: 0,
                title: Text(state.tournament?.title ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                centerTitle: true),
            state.tournamentIsLoading
                ? const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: paddingHeader,
                        child: Row(
                          children: [
                            SizedBox(
                              child: SvgPicture.asset(
                                  'assets/icons/tournament-icon.svg'),
                            ),
                            const SizedBox(width: Constants.space21),
                            const Flexible(
                              child: Text(
                                'Compite con otras escuelas y sube de posicion con tu equipo para ganar el torneo',
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: Constants.space18,
                            right: Constants.space18,
                            bottom: Constants.space21),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            PercentageProgressBar(
                              completedPercentage: CalculateThings.percentage(
                                  100,
                                  calculatePercentageTournament(
                                      state.tournament!)),
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                            ),
                            const SizedBox(height: Constants.space12),
                            Text(
                              'Quedan ${getTournamentDayLeft(state.tournament!)} dias',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  int calculatePercentageTournament(Tournament tournament) {
    var initDate = tournament.initDate;
    var endDate = tournament.endDate;
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
    var endDate = tournament.endDate;
    var today = DateTime.now();
    var to = DateTime(endDate.year, endDate.month, endDate.day);

    var daysDifferenceFromTodayDate =
        (to.difference(today).inHours / 24).round();

    return daysDifferenceFromTodayDate;
  }
}
