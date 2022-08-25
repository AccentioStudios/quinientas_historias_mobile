import 'package:flutter/material.dart';
import 'package:quinientas_historias/core/ui/widgets/outlined_card.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class SingleChipWithoutIcon extends StatelessWidget {
  const SingleChipWithoutIcon({
    Key? key,
    required this.primaryLabel,
    required this.secondaryLabel,
  }) : super(key: key);
  final String primaryLabel;
  final String secondaryLabel;

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.space12, vertical: Constants.space12),
      child: Row(
        children: [
          const SizedBox(width: Constants.space8),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(primaryLabel,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(secondaryLabel,
                style: const TextStyle(
                    fontSize: 14, color: onSurfaceMutedTextDarkColor)),
          ]),
        ],
      ),
    );
  }
}
