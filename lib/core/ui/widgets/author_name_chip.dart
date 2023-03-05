import 'package:flutter/material.dart';
import 'package:quinientas_historias/core/ui/widgets/user_avatar.dart';

import '../../data/entities/author_entity.dart';
import '../../data/entities/user_entity.dart';
import '../../utils/constants.dart';

class AuthorNameChip extends StatelessWidget {
  const AuthorNameChip({Key? key, this.author}) : super(key: key);
  final Author? author;
  @override
  Widget build(BuildContext context) {
    return author == null
        ? const SizedBox.shrink()
        : FittedBox(
            child: Container(
              height: 37,
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.space8,
                vertical: Constants.space8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: Constants.borderRadius23,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: 25,
                  //   height: 25,
                  //   child: UserAvatar(
                  //     user: author!,
                  //     height: 25,
                  //     width: 25,
                  //   ),
                  // ),
                  const SizedBox(
                    width: Constants.space12,
                  ),
                  Text(author?.name ?? ''),
                ],
              ),
            ),
          );
  }
}
