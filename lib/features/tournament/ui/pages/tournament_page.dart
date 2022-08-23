import 'package:custom_nested_scroll_view/custom_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/libs/extended_tab_view.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/ui/widgets/headline.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/cubit/tournament_cubit.dart';
import '../components/leaderboard_all_tab_view.dart';
import '../components/leaderboard_my_school_tab_view.dart';
import '../components/leaderboard_my_team_tab_view.dart';
import '../components/leaderboard_tabs.dart';
import '../widgets/tournament_header_widget.dart';

class TournamentPage extends StatefulWidget with ErrorHandling {
  const TournamentPage({Key? key}) : super(key: key);

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TournamentCubit>().getCurrentTournament(
          onError: (error) => widget.handleError(context, error),
        );
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentCubit, TournamentState>(
      builder: (context, state) {
        return Scaffold(
            body: CustomNestedScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CustomSliverOverlapAbsorber(
              handle: CustomNestedScrollView.sliverOverlapAbsorberHandleFor(
                  context),
              sliver: TournamentHeaderWidget(
                state: state,
              ),
            ),
            const SliverToBoxAdapter(
              child: PaddingColumn(
                padding: EdgeInsets.symmetric(horizontal: Constants.space16),
                children: [
                  // Headline(
                  //   marginTop: Constants.space21,
                  //   label: 'Podio de escuelas',
                  // ),
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
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.space16),
                  child: LeaderboardMyTeamTabView(
                    cubit: context.read<TournamentCubit>(),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.space16),
                  child: LeaderboardMySchoolTabView(
                    cubit: context.read<TournamentCubit>(),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.space16),
                  child: LeaderboardAllTabView(
                    cubit: context.read<TournamentCubit>(),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
