import 'package:flutter/material.dart';

import '../../../../core/ui/widgets/single_chip.dart';
import '../../../../core/utils/constants.dart';

class HeaderPointsAndFavoritesRow extends StatelessWidget {
  const HeaderPointsAndFavoritesRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        Flexible(
          flex: 1,
          child: SingleChip(
            primaryLabel: '950',
            secondaryLabel: 'Puntos totales',
            svgIconPath: 'assets/icons/points-icon.svg',
          ),
        ),
        SizedBox(width: Constants.space12),
        Flexible(
          flex: 1,
          child: SingleChip(
            primaryLabel: '10',
            secondaryLabel: 'Favoritos',
            svgIconPath: 'assets/icons/bookmark-icon.svg',
          ),
        ),
      ],
    );
  }
}
