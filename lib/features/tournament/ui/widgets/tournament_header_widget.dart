import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/ui/widgets/percentage_progress_bar.dart';
import '../../../../core/utils/constants.dart';

class TournamentHeaderWidget extends StatelessWidget {
  const TournamentHeaderWidget({Key? key}) : super(key: key);

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
                title: const Text('Torneo de Lectura',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                centerTitle: true),
            Padding(
              padding: paddingHeader,
              child: Row(
                children: [
                  SizedBox(
                    child: SvgPicture.asset('assets/icons/tournament-icon.svg'),
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
                    completedPercentage: 20,
                    backgroundColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: Constants.space12),
                  const Text(
                    'Quedan 60 dias',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
