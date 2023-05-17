import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/mixins/error_handling.dart';
import 'package:quinientas_historias/features/profiles_module/school_profile/ui/bloc/cubit/school_profile_cubit.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../invites/send/send_invite_provider.dart';
import '../../../../user_managment/user_management_provider.dart';
import '../components/teams_profile_leaderboard_team_list.dart';
import '../widgets/school_profile_cards_widget.dart';
import '../widgets/school_profile_header_widget.dart';

class SchoolProfilePage extends StatefulWidget with ErrorHandling {
  const SchoolProfilePage({super.key});

  @override
  State<SchoolProfilePage> createState() => _SchoolProfilePageState();
}

class _SchoolProfilePageState extends State<SchoolProfilePage> {
  @override
  void didChangeDependencies() {
    getSchoolData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchoolProfileCubit, SchoolProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: [
              if (state.school?.canEdit == true)
                TextButton.icon(
                  onPressed: () =>
                      openInviteCaptain(context, schoolId: state.school?.id),
                  icon: SvgPicture.asset('assets/icons/user-plus.svg'),
                  label: Text(
                    'Invitar capitanes',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
              if (state.school?.canEdit == true)
                TextButton.icon(
                  onPressed: () => openEditTeam(context, state),
                  icon: SvgPicture.asset('assets/icons/edit-icon.svg'),
                  label: Text(
                    'Editar Equipo',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
              const SizedBox(width: 8),
            ],
          ),
          body: RefreshIndicator(
              onRefresh: () async {
                getSchoolData();
              },
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SchoolProfileHeader(
                          state: state,
                        ),
                        const SizedBox(height: Constants.space41),
                        SchoolCards(
                          state: state,
                        ),
                        TeamsProfileLeaderboardTeamList(
                          state: state,
                        ),
                      ],
                    )),
        );
      },
    );
  }

  void openInviteCaptain(BuildContext context, {required int? schoolId}) {
    if (schoolId != null) {
      SendInviteProvider.open(context,
              schoolId: schoolId, typeUserToInvite: Role.captain)
          .then((refresh) {
        if (refresh == true) {
          getSchoolData();
        }
      });
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg: 'Error: No tienes escuela, entra en contacto con nosotros.');
    }
  }

  void openEditTeam(BuildContext context, SchoolProfileState state) {
    UserManagementProvider()
        .openEditSchool(context, school: state.school!.toEntity())
        .then((refresh) {
      if (refresh == true) {
        getSchoolData();
      }
    });
  }

  Future<dynamic> getSchoolData() {
    return context
        .read<SchoolProfileCubit>()
        .getProfile()
        .onError<HttpFailure>((error, stackTrace) => widget.handleError(
              context,
              error,
              btnLabel: 'Intentar nuevamente',
              linkBtnLabel: 'Volver al home',
              linkBtnOnTap: () {
                Navigator.of(context, rootNavigator: true)
                    .popUntil((route) => route.isFirst);
                Navigator.of(context).pushNamed(Routes.home);
              },
            ).then((refresh) {
              if (refresh != null) {
                if (refresh) {
                  getSchoolData();
                }
              }
            }));
  }
}
