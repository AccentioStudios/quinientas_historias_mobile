import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/data/entities/school_entity.dart';
import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/ui/widgets/single_chip.dart';
import '../../../../core/utils/constants.dart';
import '../../../invites/send/send_invite_provider.dart';
import '../../../profiles_module/school_profile/school_profile_provider.dart';
import '../../../profiles_module/user_profile/user_profile_provider.dart';
import '../../../user_managment/user_management_provider.dart';
import '../bloc/cubit/home_cubit.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/step_card_item.dart';

class HomeCaptainTier0Layout extends StatelessWidget with SheetMessages {
  const HomeCaptainTier0Layout(
      {Key? key, required this.state, required this.getDashboardFunction})
      : super(key: key);
  final HomeState state;
  final Function getDashboardFunction;
  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    const TextStyle normal = TextStyle(fontSize: 16);

    return ListView(
      padding: const EdgeInsets.only(top: 0),
      physics: const BouncingScrollPhysics(),
      children: [
        Tier0Header(
          state: state,
          userProfileOnTap: () {
            _navigateToMyProfilePage(context, state.dashboard?.user);
          },
        ),
        PaddingColumn(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
          children: [
            const SizedBox(height: Constants.space21),
            SingleChip(
              primaryLabel: 'Mi escuela',
              secondaryLabel: state.dashboard?.user.school?.name ?? '',
              onTap: () {
                _navigateToMySchoolPage(context, state.dashboard?.user.school);
              },
            ),
            const SizedBox(height: Constants.space8),
            SizedBox(
              width: 126,
              height: 135,
              child: SvgPicture.asset('assets/images/book-trophy-image.svg'),
            ),
            const SizedBox(height: Constants.space18),
            const Text(
              'Bienvenido a 500Historias',
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Constants.space8),
            const Text(
              'Como capitan de equipo debes crear tu equipo para invitar a otros lectores y ganar juntos el torneo',
              style: normal,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Constants.space21),
            _StepsCardsTier0(
              state: state,
              openRegisterTeam: () =>
                  openRegisterTeam(context, state.dashboard?.user.school),
            ),
            const SizedBox(height: Constants.space30),
          ],
        ),
      ],
    );
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

  void openRegisterTeam(BuildContext context, School? school) {
    UserManagementProvider()
        .openRegisterTeam(context, school: state.dashboard!.user.school)
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

class Tier0Header extends StatelessWidget {
  const Tier0Header(
      {Key? key, required this.state, required this.userProfileOnTap})
      : super(key: key);
  final HomeState state;
  final GestureTapCallback? userProfileOnTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 84 + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(children: [
        HomeAppBar(
          user: state.dashboard?.user,
          onTap: userProfileOnTap,
          hideStreak: true,
        ),
      ]),
    );
  }
}
