import 'package:flutter/material.dart';

import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/single_chip.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/school_profile_cubit.dart';

class SchoolCards extends StatelessWidget {
  const SchoolCards({super.key, required this.state});
  final SchoolProfileState state;
  @override
  Widget build(BuildContext context) {
    return PaddingColumn(
      padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: SingleChip(
                primaryLabel: state.school?.schoolPoints.toString() ?? '0',
                secondaryLabel: 'Puntos escuela',
                svgIconPath: 'assets/icons/points-outline-icon.svg',
              ),
            ),
            const SizedBox(width: Constants.space18),
            Expanded(
              child: SingleChip(
                primaryLabel: state.school?.schoolReads.toString() ?? '0',
                secondaryLabel: 'Lecturas totales',
                svgIconPath: 'assets/icons/book-open-outline-icon.svg',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
