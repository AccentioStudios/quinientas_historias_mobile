import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class Headline extends StatelessWidget {
  const Headline({
    Key? key,
    required this.label,
    this.linkText,
    this.onTap,
  }) : super(key: key);
  final String label;
  final String? linkText;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Constants.space41),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: linkText != null
                    ? Text(
                        linkText!,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        const SizedBox(height: Constants.space21),
      ],
    );
  }
}
