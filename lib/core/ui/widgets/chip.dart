import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants.dart';
import 'outlined_card.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    required this.title,
    required this.body,
    this.svgIconPath,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String body;
  final String? svgIconPath;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

    final TextStyle bodyStyle = TextStyle(
        fontSize: 15, color: Theme.of(context).colorScheme.onSurfaceVariant);

    final border = Border.all(color: Colors.white.withOpacity(0.20));
    return SizedBox(
      width: double.infinity,
      child: OutlinedCard(
        onTap: onTap,
        border: border,
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.space16, vertical: Constants.space12),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            if (svgIconPath != null)
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: Constants.space8),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(svgIconPath!),
                  ),
                ),
              ),
            Flexible(
                flex: 9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: titleStyle),
                    const SizedBox(height: Constants.space8),
                    Text(body, style: bodyStyle),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
