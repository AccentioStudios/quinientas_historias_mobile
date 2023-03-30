import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import '../../../../core/ui/widgets/group_avatar.dart';
import '../../../../core/ui/widgets/headline.dart';
import '../../../../core/utils/constants.dart';
import '../../data/entities/dashboard_entity.dart';
import '../bloc/cubit/home_cubit.dart';
import 'my_summary_challenge_card.dart';
import 'my_summary_group_card.dart';

class MySummaryCarousel extends StatelessWidget {
  const MySummaryCarousel({super.key, required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: Constants.space18),
          child: Headline(label: 'Mi resumen'),
        ),
        SizedBox(
          height: 134,
          width: double.infinity,
          child: CarouselSlider(
            items: [
              ...buildSummaryChallengesCards(state),
              buildSummaryTeamCard(state),
              buildSummarySchoolCard(state),
            ],
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              viewportFraction: 0.7,
              padEnds: false,
              aspectRatio: 277 / 130,
              enableInfiniteScroll: false,
            ),
          ),
        ),
      ]),
    );
  }

  List<Widget> buildSummaryChallengesCards(HomeState state) {
    final List<Widget> list = [];
    final List<MySummaryChallenge> challenges = [];
    challenges.addAll(
        (state.dashboard?.mySummary.whereType<MySummaryChallenge>())
                ?.toList() ??
            []);

    challenges.add(MySummaryChallenge(
      summaryTitle: 'El juego de la semana',
      summaryDescription: '¡Juega y gana puntos!',
      points: 12,
      challengeType: ChallengeType.minigame,
      userChallengeId: '11',
    ));

    challenges.add(MySummaryChallenge(
      summaryTitle: 'Reto de lecturas',
      summaryDescription: 'Lee 7 lecturas diarias y gana puntos extras',
      challengeType: ChallengeType.steps,
      userChallengeId: '11',
      points: null,
      steps: 7,
      stepsCompleted: 1,
    ));

    for (final challenge in challenges) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: Constants.space18),
        child: MySummaryChallengeCard(
          summaryChallenge: challenge,
        ),
      ));
    }
    return list;
  }

  Widget buildSummaryTeamCard(HomeState state) {
    final team = (state.dashboard?.mySummary
            .firstWhereOrNull((e) => e.groupType == GroupType.team))
        as MySummaryGroup?;
    if (team != null) {
      return Padding(
        padding: const EdgeInsets.only(left: Constants.space18),
        child: MySummaryGroupCard(
          type: GroupAvatarType.team,
          groupName: team.groupName,
          userPoints: team.points,
          userReads: team.userReads,
          rankPlace: team.rankPlace,
          avatarUrl: team.avatarUrl,
          groupId: team.groupId,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget buildSummarySchoolCard(HomeState state) {
    final school = (state.dashboard?.mySummary
            .firstWhereOrNull((e) => e?.groupType == GroupType.school))
        as MySummaryGroup?;
    if (school != null) {
      return Padding(
        padding: const EdgeInsets.only(left: Constants.space18),
        child: MySummaryGroupCard(
          type: GroupAvatarType.school,
          groupName: school.groupName,
          userPoints: school.points,
          userReads: school.userReads,
          rankPlace: school.rankPlace,
          avatarUrl: school.avatarUrl,
          groupId: school.groupId,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
