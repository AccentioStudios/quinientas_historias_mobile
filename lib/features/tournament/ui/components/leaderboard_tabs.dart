import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class LeaderboardTabs extends StatefulWidget {
  const LeaderboardTabs({Key? key, required this.tabController})
      : super(key: key);
  final TabController tabController;

  @override
  State<LeaderboardTabs> createState() => _LeaderboardTabsState();
}

class _LeaderboardTabsState extends State<LeaderboardTabs> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
            child: TabBar(
              indicatorColor: Theme.of(context).colorScheme.primary,
              indicatorWeight: 3,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor:
                  Theme.of(context).colorScheme.onPrimaryContainer,
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 0.8),
              controller: widget.tabController,
              tabs: const <Widget>[
                Tab(
                  text: 'Mi equipo',
                ),
                Tab(text: 'Mi escuela'),
                Tab(text: 'Todos'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
