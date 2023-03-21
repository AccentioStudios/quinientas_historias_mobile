import 'package:custom_nested_scroll_view/custom_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/data/entities/tournament_entity.dart';
import '../../../../core/libs/extended_tab_view.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/ui/widgets/headline.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/cubit/tournament_cubit.dart';
import '../components/leaderboard_all_tab_view.dart';
import '../components/leaderboard_by_teams_tab_view.dart';
import '../components/leaderboard_tabs.dart';

class TournamentPageDetails extends StatefulWidget with ErrorHandling {
  const TournamentPageDetails({Key? key, required this.tournament})
      : super(key: key);

  final Tournament tournament;

  @override
  State<TournamentPageDetails> createState() => _TournamentPageDetailsState();
}

class _TournamentPageDetailsState extends State<TournamentPageDetails>
    with TickerProviderStateMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // context.read<TournamentCubit>().getTournament(
    //       widget.tournament.id,
    //       onError: (error) => widget.handleError(context, error),
    //     );
  }

  @override
  void initState() {
    super.initState();
    // context.read<TournamentCubit>().hideOrShowMyTeamTab();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentCubit, TournamentState>(
      builder: (context, state) {
        // final me = state.listPage?.itemList.where((item) => item.user?.id == 1);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              body: CustomNestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              CustomSliverOverlapAbsorber(
                handle: CustomNestedScrollView.sliverOverlapAbsorberHandleFor(
                    context),
                sliver: SliverAppBar(
                  floating: true,
                  expandedHeight: 200,
                  flexibleSpace:
                      TournamentDetailsHeader(tournament: widget.tournament),
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
              LeaderboardTabs(state: state),
              // if (me != null)
              //   UserLeaderboardListItem(
              //     user: me.user!,
              //     position: me.position,
              //   ),
            ],
            body: Builder(
              builder: (context) => ExtendedTabBarView(
                children: <Widget>[
                  if (state.teamTabShowed)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.space16),
                      child: LeaderboardByTeamsTabView(
                        tournamentId: widget.tournament.id,
                        cubit: context.read<TournamentCubit>(),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.space16),
                    child: LeaderboardAllTabView(
                      tournamentId: widget.tournament.id,
                      cubit: context.read<TournamentCubit>(),
                    ),
                  ),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}

class TournamentDetailsHeader extends StatelessWidget {
  const TournamentDetailsHeader({
    super.key,
    required this.tournament,
  });

  final Tournament tournament;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTournamentCountdownWidget(),
          const SizedBox(height: 2),
          Text(
            tournament.name ?? 'Torneo',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
      expandedTitleScale: 1.5,
      titlePadding: const EdgeInsets.all(Constants.space18),
      background: Image.asset(
        'assets/images/cover-tournament-placeholder-image.png',
        fit: BoxFit.cover,
      ),
    );
  }

  _getTournamentCountdownWidget() {
    int days = getTournamentDayLeft(tournament);
    return RichText(
        text: TextSpan(
      style: const TextStyle(fontSize: 10),
      children: [
        WidgetSpan(
          alignment: PlaceholderAlignment.top,
          baseline: TextBaseline.alphabetic,
          child: Padding(
            padding: const EdgeInsets.only(right: Constants.space4),
            child: SizedBox(
              width: 10,
              height: 10,
              child: days > 0
                  ? SvgPicture.asset('assets/icons/hourglass-outline-icon.svg')
                  : SvgPicture.asset(
                      'assets/icons/check-circle-outline-icon.svg'),
            ),
          ),
        ),
        days > 0
            ? TextSpan(text: 'Quedan $days dias')
            : const TextSpan(text: 'Torneo Terminado')
      ],
    ));
  }

  int getTournamentDayLeft(Tournament tournament) {
    var endDate = tournament.endsAt;
    var today = DateTime.now();
    var to = DateTime(endDate.year, endDate.month, endDate.day);

    var daysDifferenceFromTodayDate =
        (to.difference(today).inHours / 24).round();

    if (daysDifferenceFromTodayDate.isNegative ||
        daysDifferenceFromTodayDate.abs() == 0) {
      return 0;
    }

    return daysDifferenceFromTodayDate;
  }
}