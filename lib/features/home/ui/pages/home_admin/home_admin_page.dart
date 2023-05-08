import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/routes/auto_router.dart';
import '../../../../../core/ui/widgets/chip.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/story_cover.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../invites/send/send_invite_provider.dart';
import '../../../../reading_module/reading_story/reading_story_provider.dart';
import '../../../data/entities/dashboard_entity.dart';
import '../../bloc/cubit/home_cubit.dart';
import '../../widgets/hero_header_widget.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key, required this.state});
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: Constants.space18,
                      right: Constants.space18,
                      top: Constants.space21),
                  child: Column(
                    children: [
                      CustomChip(
                        svgIconPath: 'assets/icons/user-plus-outline-icon.svg',
                        title: 'Invitar Capitanes',
                        body:
                            'Invita a capitanes para que formen equipos en la escuela',
                        onTap: () {
                          navigateToInviteCaptains(context,
                              schoolId: state.dashboard?.user.school?.id);
                        },
                      ),
                      const SizedBox(height: Constants.space16),
                      CustomChip(
                        svgIconPath: 'assets/icons/user-plus-outline-icon.svg',
                        title: 'Invitar Lectores',
                        body:
                            'Invita a lectores a formar parte de un equipo particular',
                        onTap: () {
                          navigateToInviteReaders(context,
                              schoolId: state.dashboard?.user.school?.id);
                        },
                      ),
                      const SizedBox(height: Constants.space16),
                      CustomChip(
                        svgIconPath:
                            'assets/icons/challenge-minigame-outline-icon.svg',
                        title: 'Administrador de retos (SAR)',
                        body:
                            'Crea, elimina y edita retos en el sistema. Inicialos en modo de pruebas y revisa su funcionamiento.',
                        onTap: () {
                          _navigateToChallengeAdmin(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // MySummaryCarousel(state: state),
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
            ]);
      },
    );
  }

  void _navigateToChallengeAdmin(BuildContext context) {
    AutoRouter.of(context).push(ChallengesAdminRoute());
  }

  void _navigateToExploreStories(BuildContext context, {String? search}) {
    AutoRouter.of(context).push(ExploreStoriesRoute(search: search));
  }

  void _navigateToStoryPage(BuildContext context, Story story) {
    ReadingStoryProvider.openStory(context, storyId: story.id);
  }

  void navigateToInviteCaptains(BuildContext context,
      {required int? schoolId}) {
    if (schoolId != null) {
      SendInviteProvider.open(context,
              schoolId: schoolId, typeUserToInvite: Role.captain)
          .then((refresh) {
        if (refresh == true) {
          // getDashboardFunction();
        }
      });
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg: 'Error: No tienes escuela, entra en contacto con nosotros.');
    }
  }

  void navigateToInviteReaders(BuildContext context, {required int? schoolId}) {
    if (schoolId != null) {
      SendInviteProvider.inviteReadersProf(context, schoolId: schoolId)
          .then((refresh) {
        if (refresh == true) {
          // getDashboardFunction();
        }
      });
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg: 'Error: No tienes escuela, entra en contacto con nosotros.');
    }
  }
}
