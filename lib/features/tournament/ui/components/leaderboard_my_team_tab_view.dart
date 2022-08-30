import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/data/models/leaderboard_model.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/ui/widgets/user_avatar.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/cubit/tournament_cubit.dart';
import '../../../../core/ui/widgets/leaderboard_list_item_widget.dart';

class LeaderboardMyTeamTabView extends StatefulWidget with ErrorHandling {
  const LeaderboardMyTeamTabView({Key? key, required this.cubit})
      : super(key: key);

  final TournamentCubit cubit;

  @override
  State<LeaderboardMyTeamTabView> createState() =>
      _LeaderboardMyTeamTabViewState();
}

class _LeaderboardMyTeamTabViewState extends State<LeaderboardMyTeamTabView>
    with AutomaticKeepAliveClientMixin<LeaderboardMyTeamTabView> {
  final _pagingController =
      PagingController<int, LeaderboardModel>(firstPageKey: 1);

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
  Widget build(BuildContext context) {
    return PagedListView.separated(
      physics: const BouncingScrollPhysics(),
      pagingController: _pagingController,
      shrinkWrap: true,
      builderDelegate: PagedChildBuilderDelegate<LeaderboardModel>(
        itemBuilder: (context, item, index) => LeaderboardListItem(
          avatarWidget: UserAvatar(
            user: item.user!,
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
                      text: '#${item.position} ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text: '${item.user?.firstName} ${item.user?.lastName}'),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              item.user?.type == UserType.captain
                  ? Padding(
                      padding: const EdgeInsets.only(left: Constants.space4),
                      child: SizedBox(
                        width: 12,
                        height: 12,
                        child: SvgPicture.asset('assets/icons/star-icon.svg'),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
          secondaryLabel: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 15),
              children: <TextSpan>[
                TextSpan(
                  text: '${item.user?.score} ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const TextSpan(text: 'puntos - '),
                TextSpan(
                  text: '${item.user?.readed}',
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
          trailingWidget: TournamentPositionArrow(
            number: item.changePosition.number,
            arrowPositionDirection: item.changePosition.type,
          ),
          // product: product,
          // onTap: (product) {
          //   _openProductDetails(context, product, widget.cubit);
          // },
        ),
        // firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
        //   error: _pagingController.error,
        //   onTryAgain: () => _pagingController.refresh(),
        // ),
        // noItemsFoundIndicatorBuilder: (context) =>
        //     EmptyListIndicator(),
      ),
      // itemBuilder: (context, index) => const LeaderboardListItem(),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: Constants.space12);
      },
    );
  }

  _fetchPage(int pageKey) {
    if (mounted) {
      widget.cubit.getLeaderboard(pageKey, 'myTeam', onSuccess: (newPage) {
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
