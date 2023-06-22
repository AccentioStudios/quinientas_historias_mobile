import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/data/entities/school_entity.dart';
import '../../../../../core/routes/auto_router.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/single_chip.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/team_profile_cubit.dart';

class TeamCards extends StatelessWidget {
  const TeamCards({super.key, required this.state});
  final TeamProfileState state;
  @override
  Widget build(BuildContext context) {
    return PaddingColumn(
      padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: SingleChip(
                primaryLabel: state.team?.teamPoints.toString() ?? '0',
                secondaryLabel: 'Puntos Equipo',
                svgIconPath: 'assets/icons/points-outline-icon.svg',
              ),
            ),
            const SizedBox(width: Constants.space18),
            Expanded(
              child: SingleChip(
                primaryLabel: state.team?.teamReads.toString() ?? '0',
                secondaryLabel: 'Lecturas',
                svgIconPath: 'assets/icons/book-open-outline-icon.svg',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: Constants.space16,
        ),
        if (state.team?.school != null)
          SingleChip(
            onTap: () => _navigateToSchoolPage(context, state.team?.school),
            primaryLabel: 'Escuela',
            secondaryLabel: state.team?.school?.name ?? '',
          ),
      ],
    );
  }

  void _navigateToSchoolPage(BuildContext context, School? school) {
    if (school != null) {
      AutoRouter.of(context).push(
        SchoolProfileRoute(
          schoolId: school.id,
        ),
      );
    }
  }
}
