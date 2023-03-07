import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/user_avatar.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/user_profile_cubit.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({
    super.key,
    required this.state,
  });

  final UserProfileState state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          height: 55 + MediaQuery.of(context).padding.top,
          width: double.infinity,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                right: Constants.space18),
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.space8, vertical: Constants.space4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                child: const Text('Nivel {nivel}')),
          ),
        ),
        PaddingColumn(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 8),
            UserAvatar(width: 82, height: 82, user: state.user!),
            const SizedBox(height: Constants.space18),
            Text(
              '${state.user!.firstName} ${state.user!.lastName}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: Constants.space12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  child: SvgPicture.asset(
                      'assets/icons/bookmark-outline-icon.svg'),
                ),
                const SizedBox(width: Constants.space8),
                Text(
                  '${state.user?.favoriteStories?.length}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(width: 5),
                Text(
                  'Favoritos',
                  style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 24,
                  child: SvgPicture.asset(
                      'assets/icons/book-open-outline-icon.svg'),
                ),
                const SizedBox(width: Constants.space8),
                Text(
                  '${state.user?.userReads?.length}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(width: 5),
                Text(
                  'Lecturas Totales',
                  style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
