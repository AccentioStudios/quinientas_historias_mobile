import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class AuthorNameChip extends StatelessWidget {
  const AuthorNameChip({Key? key, required this.name}) : super(key: key);
  final String? name;
  @override
  Widget build(BuildContext context) {
    return name == null
        ? const SizedBox.shrink()
        : FittedBox(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.space8,
                vertical: Constants.space8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: Constants.borderRadius23,
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(''),
                    ),
                  ),
                  const SizedBox(
                    width: Constants.space12,
                  ),
                  Text(name!),
                ],
              ),
            ),
          );
  }
}
