import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quinientas_historias/core/ui/widgets/padding_column.dart';

import '../../../../../core/data/entities/school_entity.dart';
import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/helpers/shared_preferences_helper.dart';
import '../../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../../core/routes/auto_router.dart';
import '../../../../../core/ui/widgets/chip.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/utils/constants.dart';

import '../../../../../core/data/entities/story_entity.dart';

import '../../../../../core/ui/widgets/story_cover.dart';
import '../../../../invites/send/send_invite_provider.dart';
import '../../../../reading_module/reading_story/reading_story_provider.dart';
import '../../../../user_managment/user_management_provider.dart';
import '../../../data/entities/dashboard_entity.dart';
import '../../bloc/cubit/home_cubit.dart';
import '../../widgets/hero_header_widget.dart';
import '../../widgets/my_summary_carousel.dart';
import '../../widgets/step_card_item.dart';

class HomeCaptainPage extends StatelessWidget {
  const HomeCaptainPage({super.key, required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics()
              .applyTo(const BouncingScrollPhysics()),
          slivers: [
            HomeReaderHeader(user: state.dashboard?.user),
            SliverToBoxAdapter(
              child: PaddingColumn(
                padding:
                    const EdgeInsets.symmetric(horizontal: Constants.space18),
                children: [
                  const Headline(label: 'Capitán'),
                  state.dashboard?.user.team != null
                      ? CustomChip(
                          svgIconPath:
                              'assets/icons/user-plus-outline-icon.svg',
                          title: 'Invitar Lectores',
                          body:
                              'Invita a lectores a formar parte de un equipo particular',
                          onTap: () {
                            navigateToInviteReaders(context,
                                schoolId: state.dashboard?.user.school?.id,
                                myTeam: state.dashboard?.user.team);
                          },
                        )
                      : _FirstStepsListing(
                          getDashboardFunction: () {},
                          state: state,
                        )
                ],
              ),
            ),
            MySummaryCarousel(state: state),
            if (state.dashboard?.recomendedStories != null)
              ...state.dashboard!.recomendedStories.map(
                (RecomendedStoriesDasboardDto e) {
                  return SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.space18),
                          child: Headline(
                            label: e.recomendationTitle,
                            secondaryLabel: e.recomendationDescription,
                          ),
                        ),
                        if (e.data.isNotEmpty)
                          SizedBox(
                            height: 165,
                            child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    const SizedBox(width: Constants.space18),
                                    ...e.data.map((Story story) => Padding(
                                          padding: const EdgeInsets.only(
                                              right: Constants.space12),
                                          child: StoryCover(
                                            story: story,
                                            onTap: () {
                                              _navigateToStoryPage(
                                                  context, story);
                                            },
                                          ),
                                        )),
                                    const SizedBox(width: Constants.space18),
                                  ],
                                )),
                          ),
                      ],
                    ),
                  );
                },
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: Constants.space30),
                child: Container(
                  decoration: BoxDecoration(
                    // border 1px at the bottom and the top
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      _navigateToExploreStories(context);
                    },
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: Constants.space18),
                    title: Text(
                      'Ver todas las lecturas',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
                child: SizedBox(height: Constants.space41)),
          ],
        );
      },
    );
  }

  void _navigateToStoryPage(BuildContext context, Story story) {
    ReadingStoryProvider.openStory(context, storyId: story.id);
  }

  void _navigateToExploreStories(BuildContext context, {String? search}) {
    AutoRouter.of(context).push(ExploreStoriesRoute(search: search));
  }

  void navigateToInviteReaders(BuildContext context,
      {int? schoolId, Team? myTeam}) {
    // the invitation save the tournamentId in SharedPreferences for this particular case
    if (schoolId != null && myTeam?.tournament?.id != null && myTeam != null) {
      SendInviteProvider.open(
        context,
        schoolId: schoolId,
        team: myTeam,
        tournamentId: myTeam.tournament?.id,
        typeUserToInvite: Role.reader,
      ).then((refresh) {
        // getDashboardFunction();
      });
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg:
              'Error: No tienes escuela, o equipo. Intenta crear uno o entra en contacto con nosotros.');
    }
  }
}

class _FirstStepsListing extends StatelessWidget with SheetMessages {
  const _FirstStepsListing(
      {required this.state, required this.getDashboardFunction});
  final HomeState state;
  final Function getDashboardFunction;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 0),
      physics: const BouncingScrollPhysics(),
      children: [
        PaddingColumn(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
          children: [
            const SizedBox(height: Constants.space21),
            _StepsCardsTier0(
                state: state,
                openRegisterTeam: () {
                  final tournamentId = SharedPreferencesHelper.instance
                      .getInt('captainTournamentId');

                  if (tournamentId != null) {
                    openRegisterTeam(
                        context, state.dashboard?.user.school, tournamentId);
                  } else {
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                        msg:
                            "Error: No tienes torneo. Entra en contacto con nosotros.");
                  }
                }),
            const SizedBox(height: Constants.space30),
          ],
        ),
      ],
    );
  }

  void openRegisterTeam(
      BuildContext context, School? school, int tournamentId) {
    UserManagementProvider()
        .openRegisterTeam(context,
            school: state.dashboard!.user.school, tournamentId: tournamentId)
        .then((newTeam) {
      if (newTeam != null) {
        showInviteReadersMessage<bool>(context).then((bool? value) {
          if (value == true) {
            SendInviteProvider.open(context, team: newTeam)
                .then((value) => getDashboardFunction());
          }
          getDashboardFunction();
        });
      }
    });
  }
}

class _StepsCardsTier0 extends StatelessWidget {
  const _StepsCardsTier0({required this.state, required this.openRegisterTeam});
  final HomeState state;
  final Function openRegisterTeam;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topLeft,
              child: FractionallySizedBox(
                heightFactor: 1,
                child: Container(
                  width: 5,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: Constants.borderRadius16),
                  clipBehavior: Clip.antiAlias,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: FractionallySizedBox(
                      heightFactor: 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 10,
            child: Column(
              children: [
                StepCardItem(
                  title: 'Primer acceso',
                  body:
                      'Recibiste una invitacion para 500Historias y te registraste como capitan',
                  done: true,
                  onTap: () {},
                ),
                const SizedBox(height: Constants.space16),
                StepCardItem(
                  title: 'Crear equpo',
                  body:
                      'Crea el equipo con el que vas a participar en el torneo',
                  ctaLabel: 'Click aquí para crear equipo',
                  done: state.dashboard?.user.team != null,
                  onTap: () {
                    openRegisterTeam();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
