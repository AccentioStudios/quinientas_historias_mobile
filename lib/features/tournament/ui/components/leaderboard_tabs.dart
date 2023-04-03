import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../bloc/cubit/tournament_cubit.dart';

class LeaderboardTabs extends StatefulWidget {
  const LeaderboardTabs({Key? key, required this.state}) : super(key: key);
  final TournamentState state;
  @override
  State<LeaderboardTabs> createState() => _LeaderboardTabsState();
}

class _LeaderboardTabsState extends State<LeaderboardTabs> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 34,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
          child: TabBar(
            unselectedLabelColor: Theme.of(context).colorScheme.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).colorScheme.primary),
            tabs: const <Widget>[
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Por Equipos",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Todos",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
