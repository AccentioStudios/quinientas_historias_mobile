import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'outlined_card.dart';

class DismissibleListTile extends StatelessWidget {
  const DismissibleListTile({
    required super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onDismissed,
  });
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final void Function()? onTap;
  final DismissDirectionCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    final line = Container(
      width: 2,
      height: 35,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              width: 2,
              style: BorderStyle.solid,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.3)),
        ),
      ),
    );

    return OutlinedCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      backgroundColor: brandBlue.withOpacity(0.08),
      child: Dismissible(
        key: key!,
        onDismissed: onDismissed,
        background: Container(
          color: Theme.of(context).colorScheme.errorContainer,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Theme.of(context).colorScheme.errorContainer,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Constants.space12),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              const SizedBox(width: Constants.space8),
              line,
              const SizedBox(width: 1),
              line,
              const SizedBox(width: Constants.space16),
              Flexible(
                child: Column(children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title,
                            if (subtitle != null) subtitle!,
                          ],
                        ),
                      ),
                      trailing != null ? trailing! : const SizedBox.shrink(),
                    ],
                  ),
                ]),
              ),
              const SizedBox(width: Constants.space16),
              line,
              const SizedBox(width: 1),
              line,
              const SizedBox(width: Constants.space8),
            ],
          ),
        ),
      ),
    );
  }
}
