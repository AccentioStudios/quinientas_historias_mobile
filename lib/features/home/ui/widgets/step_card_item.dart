import 'package:flutter/material.dart';

import '../../../../core/ui/widgets/outlined_card.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constants.dart';

class StepCardItem extends StatelessWidget {
  const StepCardItem(
      {super.key,
      this.onTap,
      this.done = false,
      required this.title,
      required this.body,
      this.ctaLabel = 'Click aquí'});
  final String title;
  final String body;
  final String ctaLabel;
  final void Function()? onTap;
  final bool done;
  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

    final TextStyle bodyStyle = TextStyle(
        fontSize: 15, color: Theme.of(context).colorScheme.onSurfaceVariant);

    final TextStyle statusStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: done ? successDarkColor : Theme.of(context).colorScheme.primary);

    final border = done
        ? Border.all(color: successDarkColor)
        : Border.all(color: Colors.white.withOpacity(0.20));

    final TextStyle ctaStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Theme.of(context).colorScheme.primary);

    return SizedBox(
      width: double.infinity,
      child: OutlinedCard(
        onTap: onTap,
        border: border,
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.space16, vertical: Constants.space16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                Flexible(flex: 8, child: Text(title, style: titleStyle)),
                Flexible(
                    flex: 4,
                    child: Text(done ? 'Listo' : 'Obligatorio',
                        style: statusStyle)),
              ],
            ),
            const SizedBox(height: Constants.space8),
            Text(body, style: bodyStyle),
            if (!done) const SizedBox(height: Constants.space8),
            if (!done) Text(ctaLabel, style: ctaStyle),
          ],
        ),
      ),
    );
  }
}
