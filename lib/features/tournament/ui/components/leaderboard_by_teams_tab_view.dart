import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/data/entities/leaderboard_entity.dart';
import '../../../../core/data/entities/team_entity.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/group_avatar.dart';
import '../../../../core/ui/widgets/leaderboard_list_item_widget.dart';
import '../../../../core/utils/constants.dart';
import '../../../profiles_module/team_profile/team_profile_provider.dart';
import '../bloc/cubit/tournament_cubit.dart';
import '../widgets/no_item_found_widget.dart';

class LeaderboardByTeamsTabView extends StatefulWidget with ErrorHandling {
  const LeaderboardByTeamsTabView(
      {Key? key, required this.tournamentId, required this.cubit})
      : super(key: key);

  final TournamentCubit cubit;
  final int tournamentId;

  @override
  State<LeaderboardByTeamsTabView> createState() =>
      _LeaderboardByTeamsTabViewState();
}

class _LeaderboardByTeamsTabViewState extends State<LeaderboardByTeamsTabView>
    with AutomaticKeepAliveClientMixin<LeaderboardByTeamsTabView> {
  final _pagingController = PagingController<int, Leaderboard>(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController
        .removePageRequestListener((pageKey) => _fetchPage(pageKey));
    _pagingController.dispose();

    super.dispose();
  }

  @override
  bool get wantKeepAlive => false;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return PagedListView.separated(
      physics: const BouncingScrollPhysics(),
      pagingController: _pagingController,
      shrinkWrap: true,
      builderDelegate: PagedChildBuilderDelegate<Leaderboard>(
        noItemsFoundIndicatorBuilder: (context) => const NoItemFound(),
        firstPageErrorIndicatorBuilder: (context) => const PageErrorIndicator(),
        itemBuilder: (context, item, index) => TeamLeaderboardListItem(
          team: item.team!,
          rankPlace: item.rankPlace,
          userPoints: item.userPoints,
          userReads: item.userReads,
        ),
      ),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: Constants.space12);
      },
    );
  }

  _fetchPage(int pageKey) {
    if (mounted) {
      widget.cubit.getLeaderboard(widget.tournamentId, pageKey, 'byTeams',
          onSuccess: (newPage) {
        final previouslyFetchedItemsCount =
            _pagingController.itemList?.length ?? 0;
        final isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
        final newItems = newPage.itemList;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }, onError: (e) {
        _pagingController.error = e;
      });
    }
  }
}

class TeamLeaderboardListItem extends StatelessWidget {
  const TeamLeaderboardListItem({
    super.key,
    required this.team,
    required this.rankPlace,
    required this.userPoints,
    required this.userReads,
  });

  final Team team;
  final int userPoints;
  final int userReads;
  final int rankPlace;

  @override
  Widget build(BuildContext context) {
    return LeaderboardListItem(
      onTap: () => navigateToTeamProfile(context, team),
      avatarWidget: GroupAvatar(
        avatarUrl: team.avatarUrl,
        type: GroupAvatarType.team,
      ),
      label: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: AutoSizeText.rich(
              TextSpan(
                style:
                    DefaultTextStyle.of(context).style.copyWith(fontSize: 15),
                children: <TextSpan>[
                  TextSpan(
                    text: '#$rankPlace ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '${team.name} '),
                ],
              ),
              minFontSize: 14,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      secondaryLabel: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 15),
          children: <TextSpan>[
            TextSpan(
              text: userPoints.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const TextSpan(text: ' puntos  '),
            TextSpan(
              text: userReads.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const TextSpan(
              text: ' leídos',
            ),
          ],
        ),
      ),
    );
  }

  navigateToTeamProfile(BuildContext context, Team? team) {
    if (team != null) {
      Navigator.pushNamed(
        context,
        Routes.teamProfile,
        arguments: TeamProfileArguments(
          team.id,
        ),
      );
    }
  }
}
