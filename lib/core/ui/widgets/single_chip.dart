import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/ui/widgets/outlined_card.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class SingleChip extends StatelessWidget {
  const SingleChip(
      {Key? key,
      required this.primaryLabel,
      required this.secondaryLabel,
      required this.svgIconPath})
      : super(key: key);
  final String primaryLabel;
  final String secondaryLabel;
  final String svgIconPath;
  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.space12, vertical: Constants.space12),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(svgIconPath),
          ),
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
