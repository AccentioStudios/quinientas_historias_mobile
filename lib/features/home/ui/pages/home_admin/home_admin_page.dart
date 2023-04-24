import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/data/entities/school_entity.dart';
import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/chip.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/story_cover.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../invites/send/send_invite_provider.dart';
import '../../../../profiles_module/school_profile/school_profile_provider.dart';
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
                        svgIconPath: 'assets/icons/school-outline-icon.svg',
                        title: 'Mi escuela',
                        body: state.dashboard?.user.school?.name ??
                            'Error al obtener nombre de escuela',
                        onTap: () {
                          _navigateToMySchoolPage(
                              context, state.dashboard?.user.school);
                        },
                      ),
                      const SizedBox(height: Constants.space16),
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
              const SliverToBoxAdapter(
                  child: SizedBox(height: Constants.space41)),
            ]);
      },
    );
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

  void _navigateToMySchoolPage(BuildContext context, School? mySchool) {
    if (mySchool != null) {
      Navigator.pushNamed<void>(
        context,
        Routes.schoolProfile,
        arguments: SchoolProfileArguments(
          mySchool.id,
        ),
      ).then((value) {});
    }
  }
}
