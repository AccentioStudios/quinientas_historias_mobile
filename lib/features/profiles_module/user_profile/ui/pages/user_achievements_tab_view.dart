import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quinientas_historias/core/utils/constants.dart';

import '../../../../../core/data/entities/user_entity.dart';

class UserAchievementsTabView extends StatelessWidget {
  const UserAchievementsTabView({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    if (user.userFavorites != null) {
      return user.userFavorites!.isNotEmpty
          ? const Placeholder()
          : const UserAchievementsEmptyState();
    }
    return const UserAchievementsEmptyState();
  }
}

class UserAchievementsEmptyState extends StatelessWidget {
  const UserAchievementsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child:
                  SvgPicture.asset('assets/icons/achievement-outline-icon.svg'),
            ),
            const SizedBox(height: Constants.space21),
            const Text('No hay logros todavía'),
            const SizedBox(height: Constants.space41),
          ]),
    );
  }
}
