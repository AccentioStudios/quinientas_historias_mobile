import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/data/entities/school_entity.dart';
import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../../core/routes/auto_router.dart';
import '../../../../../core/ui/widgets/chip.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/story_cover.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../invites/send/send_invite_provider.dart';
import '../../../../reading_module/reading_story/reading_story_provider.dart';
import '../../../../user_managment/user_management_provider.dart';
import '../../../data/entities/dashboard_entity.dart';
import '../../bloc/cubit/home_cubit.dart';
import '../../widgets/hero_header_widget.dart';
import '../../widgets/step_card_item.dart';

class HomeProfPage extends StatelessWidget {
  const HomeProfPage(
      {super.key, required this.state, required this.getDashboardFunction});
  final HomeState state;
  final Function getDashboardFunction;

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
                    const Headline(label: 'Profesor'),
                    state.dashboard?.user.school != null
                        ? Column(
                            children: [
                              CustomChip(
                                svgIconPath:
                                    'assets/icons/school-outline-icon.svg',
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
                                svgIconPath:
                                    'assets/icons/user-plus-outline-icon.svg',
                                title: 'Invitar Capitanes',
                                body:
                                    'Invita a capitanes para que formen equipos en la escuela',
                                onTap: () {
                                  navigateToInviteCaptains(context,
                                      schoolId:
                                          state.dashboard?.user.school?.id);
                                },
                              ),
                              const SizedBox(height: Constants.space16),
                              CustomChip(
                                svgIconPath:
                                    'assets/icons/user-plus-outline-icon.svg',
                                title: 'Invitar Lectores',
                                body:
                                    'Invita a lectores a formar parte de un equipo particular',
                                onTap: () {
                                  navigateToInviteReaders(context,
                                      school: state.dashboard?.user.school);
                                },
                              ),
                            ],
                          )
                        : _FirstStepsListing(
                            getDashboardFunction: getDashboardFunction,
                            state: state,
                          ),
                  ],
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
      SendInviteProvider.chooseTournamentForInviteAdmin(
        context,
      ).then((tournament) {
        if (tournament != null) {
          SendInviteProvider.open(context,
                  tournamentId: tournament.id,
                  schoolId: schoolId,
                  typeUserToInvite: Role.captain)
              .then((refresh) {
            if (refresh == true) {
              // getDashboardFunction();
            }
          });
        }
      });
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg: 'Error: No tienes escuela, entra en contacto con nosotros.');
    }
  }

  void navigateToInviteReaders(BuildContext context,
      {required School? school}) {
    if (school != null) {
      SendInviteProvider.chooseTournamentForInviteAdmin(
        context,
      ).then((tournament) {
        if (tournament == null) {
          Fluttertoast.cancel();
          Fluttertoast.showToast(
              msg:
                  'Error: No hay torneo seleccionado, entra en contacto con nosotros.');
          return;
        }
        SendInviteProvider.chooseTeamForInviteProfAndAdmin(context,
                school: school, tournament: tournament)
            .then((team) {
          if (team != null) {
            SendInviteProvider.open(
              context,
              team: team,
              tournamentId: team.tournament?.id,
              typeUserToInvite: Role.reader,
            ).then((value) {});
          }
        });
      });
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg:
              'Error: No hay escuela seleccionada, entra en contacto con nosotros.');
    }
  }

  void _navigateToMySchoolPage(BuildContext context, School? mySchool) {
    if (mySchool != null) {
      AutoRouter.of(context).push(SchoolProfileRoute(schoolId: mySchool.id));
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
                openRegisterSchool: () {
                  openRegisterSchool(context);
                }),
            const SizedBox(height: Constants.space30),
          ],
        ),
      ],
    );
  }

  void openRegisterSchool(BuildContext context) {
    UserManagementProvider()
        .openRegisterSchool(context, join: true)
        .then((newSchool) {
      if (newSchool != null) {
        showInviteCaptainsMessage<bool>(context).then((bool? value) {
          if (value == true) {
            SendInviteProvider.open(context,
                    schoolId: newSchool.id, typeUserToInvite: Role.captain)
                .then((refresh) {
              if (refresh == true) {
                getDashboardFunction();
              }
            });
          }
          getDashboardFunction();
        });
      } else {
        Fluttertoast.cancel();
        Fluttertoast.showToast(
            msg: 'Error: No tienes escuela, entra en contacto con nosotros.');
      }
    });
  }
}

class _StepsCardsTier0 extends StatelessWidget {
  const _StepsCardsTier0(
      {required this.state, required this.openRegisterSchool});
  final HomeState state;
  final Function openRegisterSchool;

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
                      heightFactor: 0.3,
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
                      'Recibiste una invitación para 500Historias y te registraste como profesor.',
                  done: true,
                  onTap: () {},
                ),
                const SizedBox(height: Constants.space16),
                StepCardItem(
                  title: 'Registrar escuela',
                  body:
                      'Registra tu escuela para que tus alumnos puedan participar.',
                  ctaLabel: 'Click aquí para registrar tu escuela',
                  done: state.dashboard?.user.school != null,
                  onTap: () {
                    openRegisterSchool();
                  },
                ),
                const SizedBox(height: Constants.space16),
                Opacity(
                  opacity: state.dashboard?.user.school != null ? 1 : 0.3,
                  child: StepCardItem(
                    title: 'Invita al capitán',
                    body:
                        'Invita a un capitán para que forme un equipo en la escuela. El capitán podrá invitar a los lectores.',
                    ctaLabel: 'Click aquí para invitar al capitán',
                    done: false,
                    onTap: state.dashboard?.user.school != null
                        ? () {
                            openRegisterSchool();
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
