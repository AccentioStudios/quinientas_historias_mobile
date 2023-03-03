import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/data/models/leaderboard_model.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/leaderboard_list_item_widget.dart';
import '../../../../core/ui/widgets/user_avatar.dart';
import '../../../../core/utils/constants.dart';
import '../../../profiles_module/user_profile/user_profile_provider.dart';
import '../bloc/cubit/tournament_cubit.dart';
import '../widgets/no_item_found_widget.dart';

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
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return PagedListView.separated(
      physics: const BouncingScrollPhysics(),
      pagingController: _pagingController,
      shrinkWrap: true,
      builderDelegate: PagedChildBuilderDelegate<LeaderboardModel>(
        noItemsFoundIndicatorBuilder: (context) => const NoItemFound(),
        firstPageErrorIndicatorBuilder: (context) => const PageErrorIndicator(),
        itemBuilder: (context, item, index) => UserLeaderboardListItem(
          user: item.user!,
          position: item.position,
        ),
      ),
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

class UserLeaderboardListItem extends StatelessWidget {
  const UserLeaderboardListItem(
      {super.key, required this.user, required this.position});

  final User user;
  final int position;

  @override
  Widget build(BuildContext context) {
    return LeaderboardListItem(
      onTap: () => navigateToUserProfile(context, user),
      avatarWidget: UserAvatar(
        user: user,
      ),
      label: Flex(
        direction: Axis.horizontal,
        children: [
          AutoSizeText.rich(
            TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 15),
              children: <TextSpan>[
                TextSpan(
                  text: '#$position ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '${user.firstName} ${user.lastName}'),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          user.role == Role.captain
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
              text: 'user.score ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const TextSpan(text: 'puntos - '),
            TextSpan(
              text: 'user.readed',
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

  navigateToUserProfile(BuildContext context, User? user) {
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
}
