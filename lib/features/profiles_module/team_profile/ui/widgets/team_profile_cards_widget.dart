import 'package:flutter/material.dart';

import '../../../../../core/data/entities/school_entity.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/single_chip.dart';
import '../../../../../core/utils/constants.dart';
import '../../../school_profile/school_profile_provider.dart';
import '../bloc/cubit/team_profile_cubit.dart';

class TeamCards extends StatelessWidget {
  const TeamCards({Key? key, required this.state}) : super(key: key);
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
      Navigator.pushNamed(
        context,
        Routes.schoolProfile,
        arguments: SchoolProfileArguments(
          school.id,
        ),
      );
    }
  }
}
