import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/entities/school_entity.dart';
import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/data/entities/team_entity.dart';
import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/headline.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/ui/widgets/story_cover.dart';
import '../../../../core/utils/constants.dart';
import '../../../explore/explore_provider.dart';
import '../../../profiles_module/school_profile/school_profile_provider.dart';
import '../../../profiles_module/team_profile/team_profile_provider.dart';
import '../../../profiles_module/user_profile/user_profile_provider.dart';
import '../../../reading_module/daily_challenge/daily_challange_provider.dart';
import '../../../reading_module/reading_story/reading_story_provider.dart';
import '../bloc/cubit/home_cubit.dart';
import '../components/header_card_component.dart';
import 'home.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout(
      {Key? key, required this.state, required this.getDashboardFunction})
      : super(key: key);
  final HomeState state;
  final Function getDashboardFunction;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 0),
      physics: const BouncingScrollPhysics(),
      children: [
        HeaderCard(
          state: state,
          userProfileOnTap: () {
            _navigateToMyProfilePage(context, state.dashboard?.user);
          },
          dailyChallengeOnTap: () {
            _navigateToDailyChallengePage(
                context, state, context.read<HomeCubit>());
          },
        ),
        const SizedBox(height: Constants.space21),
        PaddingColumn(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (state.dashboard != null)
                  if (state.dashboard!.user.team != null)
                    HomePositionsChip(
                      onTap: () {
                        _navigateToMyTeamPage(
                            context, state.dashboard?.user.team);
                      },
                      label: 'Mi equipo',
                      position: state.dashboard!.teamRank.toString(),
                      content: state.dashboard?.user.team?.name ?? '',
                    ),
                const SizedBox(width: Constants.space18),
                if (state.dashboard != null)
                  if (state.dashboard!.user.school != null)
                    HomePositionsChip(
                      onTap: () {
                        _navigateToMySchoolPage(
                            context, state.dashboard?.user.school);
                      },
                      label: 'Mi escuela',
                      position: state.dashboard!.schoolRank.toString(),
                      content: state.dashboard?.user.school?.name ?? '',
                    ),
              ],
            ),
            Headline(
              label: 'Explorar Lecturas',
              linkText: 'Ver más',
              onTap: () => _navigateToExploreStories(context),
            ),
            if (state.dashboard != null)
              if (state.dashboard?.exploreStories != null)
                GridView.count(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: Constants.space12,
                  mainAxisSpacing: Constants.space12,
                  childAspectRatio: 109 / 147,
                  crossAxisCount: 3,
                  children: [
                    ...state.dashboard!.exploreStories
                        .map((story) => StoryCover(
                              story: story,
                              onTap: () {
                                _navigateToStoryPage(context, story);
                              },
                            )),
                  ],
                )
          ],
        ),
        const SizedBox(height: Constants.space41 + 70)
      ],
    );
  }

  void _navigateToExploreStories(BuildContext context) {
    ExploreStoriesProvider.open(context);
  }

  void _navigateToMySchoolPage(BuildContext context, School? mySchool) {
    if (mySchool != null) {
      Navigator.pushNamed(
        context,
        Routes.schoolProfile,
        arguments: SchoolProfileArguments(
          mySchool.id,
        ),
      );
    }
  }

  void _navigateToMyTeamPage(BuildContext context, Team? myTeam) {
    if (myTeam != null) {
      Navigator.pushNamed(
        context,
        Routes.teamProfile,
        arguments: TeamProfileArguments(
          myTeam.id,
        ),
      );
    }
  }

  void _navigateToMyProfilePage(BuildContext context, User? myUser) {
    if (myUser != null) {
      Navigator.pushNamed(
        context,
        Routes.userProfile,
        arguments: UserProfileArguments(
          myUser.id,
        ),
      );
    }
  }

  void _navigateToStoryPage(
    BuildContext context,
    Story story,
  ) {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (_) => ReadingStoryProvider(
              homeCubit: BlocProvider.of<HomeCubit>(context),
              storyId: story.id,
            )));
  }

  void _navigateToDailyChallengePage(
    BuildContext context,
    HomeState state,
    HomeCubit cubit, {
    bool softGenerateNewChallenge = false,
    bool forceGenerateNewChallenge = false,
  }) {
    Navigator.of(context).push(MaterialPageRoute(
        settings: const RouteSettings(name: Routes.dailyChallenge),
        builder: (context) => DailyChallangeProvider(
              homeCubit: cubit,
              dailyChallenge: state.dashboard?.dailyChallenge,
              softGenerateNewChallenge: softGenerateNewChallenge,
              forceGenerateNewChallenge: forceGenerateNewChallenge,
            )));
  }
}
