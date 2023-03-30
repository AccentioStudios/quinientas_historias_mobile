import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/data/entities/leaderboard_entity.dart';
import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/group_avatar.dart';
import '../../../../core/ui/widgets/user_avatar.dart';
import '../../../../core/utils/constants.dart';
import '../../../profiles_module/user_profile/user_profile_provider.dart';
import '../bloc/cubit/tournament_cubit.dart';
import '../../../../core/ui/widgets/leaderboard_list_item_widget.dart';
import '../widgets/no_item_found_widget.dart';

class LeaderboardAllTabView extends StatefulWidget with ErrorHandling {
  const LeaderboardAllTabView(
      {Key? key, required this.tournamentId, required this.cubit})
      : super(key: key);

  final TournamentCubit cubit;
  final int tournamentId;

  @override
  State<LeaderboardAllTabView> createState() => _LeaderboardAllTabViewState();
}

class _LeaderboardAllTabViewState extends State<LeaderboardAllTabView>
    with AutomaticKeepAliveClientMixin<LeaderboardAllTabView> {
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
          onTap: () => _navigateToUserProfile(context, item.user),
          avatarWidget: UserAvatar(
            user: item.user,
            userDivision: item.userDivision,
            avatarUrl: item.user?.avatarUrl,
          ),
          label: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: AutoSizeText.rich(
                  TextSpan(
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontSize: 15),
                    children: <TextSpan>[
                      TextSpan(
                        text: '#${item.rankPlace} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              '${item.user?.firstName} ${item.user?.lastName}'),
                    ],
                  ),
                  maxLines: 1,
                  maxFontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          secondaryLabel: item.user?.team != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: GroupAvatar(
                          width: 10,
                          height: 10,
                          type: GroupAvatarType.team,
                          avatarUrl: item.user?.team?.avatarUrl,
                        ),
                      ),
                      Expanded(
                        child: AutoSizeText.rich(
                          TextSpan(
                            style: DefaultTextStyle.of(context)
                                .style
                                .copyWith(fontSize: 14),
                            children: [
                              TextSpan(
                                text: '${item.user?.team?.name}',
                              ),
                            ],
                          ),
                          maxLines: 1,
                          maxFontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          trailingWidget: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(
                  fontSize: 15,
                  height: 1.4,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              children: <TextSpan>[
                TextSpan(
                  text: '${item.userPoints} ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const TextSpan(
                    text: 'puntos\n', style: TextStyle(fontSize: 14)),
                TextSpan(
                    text: item.userReads.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                const TextSpan(text: ' leídos', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: Constants.space12);
      },
    );
  }

  void _navigateToUserProfile(BuildContext context, User? user) {
    if (user != null) {
      Navigator.pushNamed(
        context,
        Routes.userProfile,
        arguments: UserProfileArguments(
          user.id,
        ),
      );
    }
  }

  _fetchPage(int pageKey) {
    if (mounted) {
      widget.cubit.getLeaderboard(widget.tournamentId, pageKey, 'all',
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
