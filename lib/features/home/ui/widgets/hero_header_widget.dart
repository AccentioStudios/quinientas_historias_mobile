import 'package:flutter/material.dart';

import '../../../../core/data/entities/user_division_entity.dart';
import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/ui/widgets/user_avatar.dart';
import '../../../../core/utils/constants.dart';

enum HeroHeaderDayState { day, afternoon, night }

class HomeReaderHeader extends StatelessWidget {
  const HomeReaderHeader({
    super.key,
    this.user,
    this.division,
  });

  final User? user;
  final UserDivision? division;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: false,
      expandedHeight: 130 + MediaQuery.of(context).padding.top,
      flexibleSpace: FlexibleSpaceBar(
        title: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAvatar(
                  user: user,
                  userDivision: division,
                  avatarUrl: user?.avatarUrl,
                ),
                const SizedBox(height: Constants.space21),
                Text(
                  'Buenos dias ${user?.firstName}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      shadows: const [
                        Shadow(
                          offset: Offset(0, 1.4),
                          blurRadius: 8.0,
                          color: Color.fromARGB(132, 0, 0, 0),
                        ),
                      ]),
                ),
              ]),
        ),
        titlePadding: const EdgeInsets.only(
            left: Constants.space18, bottom: Constants.space21),
        background: Image.asset(
          'assets/images/home-header-image.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
