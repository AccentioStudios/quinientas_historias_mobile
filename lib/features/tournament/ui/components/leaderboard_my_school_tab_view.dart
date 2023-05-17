import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:quinientas_historias/features/profiles_module/team_profile/team_profile_provider.dart';

import '../../../../core/data/entities/leaderboard_entity.dart';
import '../../../../core/data/entities/team_entity.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/group_avatar.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/cubit/tournament_cubit.dart';
import '../../../../core/ui/widgets/leaderboard_list_item_widget.dart';
import '../widgets/no_item_found_widget.dart';

class LeaderboardMySchoolTabView extends StatefulWidget with ErrorHandling {
  const LeaderboardMySchoolTabView(
      {super.key, required this.tournamentId, required this.cubit});

  final TournamentCubit cubit;
  final int tournamentId;

  @override
  State<LeaderboardMySchoolTabView> createState() =>
      _LeaderboardMySchoolTabViewState();
}

class _LeaderboardMySchoolTabViewState extends State<LeaderboardMySchoolTabView>
    with AutomaticKeepAliveClientMixin<LeaderboardMySchoolTabView> {
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
        itemBuilder: (context, item, index) => LeaderboardListItem(
          onTap: () => navigateToTeamProfile(item.team),
          avatarWidget: GroupAvatar(
            avatarUrl: item.team?.avatarUrl,
            type: GroupAvatarType.team,
          ),
          label: Flex(
            direction: Axis.horizontal,
            children: [
              AutoSizeText.rich(
                TextSpan(
                  style:
                      DefaultTextStyle.of(context).style.copyWith(fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                      text: '#${item.rankPlace} ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '${item.team?.name}'),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          secondaryLabel: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 15),
              children: <TextSpan>[
                TextSpan(
                  text: '${item.team?.score} ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const TextSpan(text: 'puntos'),
              ],
            ),
          ),
          // trailingWidget: TournamentPositionArrow(
          //   number: item.changePosition.number,
          //   arrowPositionDirection: item.changePosition.type,
          // ),
        ),
      ),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: Constants.space12);
      },
    );
  }

  navigateToTeamProfile(Team? team) {
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

  _fetchPage(int pageKey) {
    if (mounted) {
      widget.cubit.getLeaderboard(widget.tournamentId, pageKey, 'school',
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
