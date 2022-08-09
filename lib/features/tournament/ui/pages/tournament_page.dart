import 'package:custom_nested_scroll_view/custom_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/ui/widgets/headline.dart';
import 'package:quinientas_historias/core/ui/widgets/padding_column.dart';

import '../../../../core/libs/extended_tab_view.dart';
import '../../../../core/ui/widgets/buttom_bar.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constants.dart';
import '../widgets/tournament_arrow_position_widget.dart';
import '../widgets/tournament_header_widget.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({Key? key}) : super(key: key);

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBody: true,
        floatingActionButton: FloatingActionBtnDocked(
          onPressed: () {
            // _navigateToDailyChallengePage(context, state, cubit);
          },
        ),
        bottomNavigationBar: const AppButtonBar(
          activeOption: ActiveOptionAppButtonBar.tournament,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: CustomNestedScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CustomSliverOverlapAbsorber(
              handle: CustomNestedScrollView.sliverOverlapAbsorberHandleFor(
                  context),
              sliver: const TournamentHeaderWidget(),
            ),
            SliverToBoxAdapter(
              child: PaddingColumn(
                padding: EdgeInsets.symmetric(horizontal: Constants.space16),
                children: [
                  Headline(
                    marginTop: Constants.space21,
                    label: 'Podio de escuelas',
                  ),
                  Headline(
                    marginTop: Constants.space21,
                    label: 'Tablero de posiciones',
                  ),
                ],
              ),
            ),
            LeaderboardTabs(tabController: tabController),
          ],
          body: Builder(
            builder: (context) => ExtendedTabBarView(
              physics: const BouncingScrollPhysics(),
              controller: tabController,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.space16),
                  child: LeaderboardMyTeam(),
                ),
                Text("Segunda guia selecionada"),
                Text("Segunda guia selecionada")
              ],
            ),
          ),
        ));
  }
}

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
              tabs: <Widget>[
                Tab(
                  text: 'Mi equipo',
                ),
                Tab(text: 'Equipos'),
                Tab(text: 'Escuelas'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LeaderboardMyTeam extends StatelessWidget {
  const LeaderboardMyTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: 20,
      shrinkWrap: true,
      itemBuilder: (context, index) => LeaderboardListItem(),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: Constants.space12);
      },
    );
  }
}

class LeaderboardListItem extends StatelessWidget {
  const LeaderboardListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.space16, vertical: Constants.space12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(.08),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 35, child: CircleAvatar()),
              const SizedBox(width: Constants.space12),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('#4 Sebastian (Yo)'),
                  Text('1905 puntos - 97 lecturas',
                      style: TextStyle(fontSize: 13)),
                ],
              ),
            ],
          ),
          TournamentPositionArrow(
            number: 2,
            arrowPositionDirection: ArrowPositionDirection.up,
          ),
        ],
      ),
    );
  }
}

class TournamentPositionArrow extends StatelessWidget {
  const TournamentPositionArrow(
      {Key? key, required this.number, required this.arrowPositionDirection})
      : super(key: key);
  final int number;
  final ArrowPositionDirection arrowPositionDirection;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          number.toString(),
          style: TextStyle(color: buildColor(context, arrowPositionDirection)),
        ),
        ArrowPosition(
          arrowPositionDirection: arrowPositionDirection,
        )
      ],
    );
  }

  Color buildColor(
      BuildContext context, ArrowPositionDirection arrowPositionDirection) {
    final lightTheme = Theme.of(context).brightness == Brightness.light;
    switch (arrowPositionDirection) {
      case ArrowPositionDirection.up:
        return lightTheme ? successColor : successDarkColor;
      case ArrowPositionDirection.down:
        return lightTheme ? errorColor : errorDarkColor;
      case ArrowPositionDirection.none:
        return lightTheme ? onSurfaceVariantColor : onSurfaceVariantDarkColor;
    }
  }
}
