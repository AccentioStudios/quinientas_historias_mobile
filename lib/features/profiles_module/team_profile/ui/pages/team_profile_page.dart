// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quinientas_historias/core/utils/constants.dart';
import 'package:quinientas_historias/features/profiles_module/team_profile/ui/bloc/cubit/team_profile_cubit.dart';
import 'package:quinientas_historias/features/profiles_module/team_profile/ui/widgets/team_profile_header_widget.dart';

import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../invites/send/send_invite_provider.dart';
import '../../../../user_managment/user_management_provider.dart';
import '../components/user_profile_leaderboard_team_list.dart';
import '../widgets/team_profile_cards_widget.dart';

class TeamProfilePage extends StatefulWidget with ErrorHandling {
  const TeamProfilePage({Key? key}) : super(key: key);

  @override
  State<TeamProfilePage> createState() => _TeamProfilePageState();
}

class _TeamProfilePageState extends State<TeamProfilePage> {
  @override
  void didChangeDependencies() {
    getTeamData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamProfileCubit, TeamProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: <Widget>[
              if (state.team?.canEdit == true)
                TextButton.icon(
                  label: Text(
                    'Invitar Lectores',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  onPressed: () {
                    openInviteReader(context, state.team?.toEntity());
                  },
                  icon: SvgPicture.asset('assets/icons/user-plus.svg'),
                ),
              if (state.team?.canEdit == true)
                TextButton.icon(
                  onPressed: () {
                    openEditTeam(context, state);
                  },
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
                getTeamData();
              },
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      physics: AlwaysScrollableScrollPhysics()
                          .applyTo(BouncingScrollPhysics()),
                      children: [
                        TeamProfileHeader(
                          state: state,
                        ),
                        const SizedBox(height: Constants.space41),
                        TeamCards(
                          state: state,
                        ),
                        UserProfileLeaderboardTeamList(
                          leaderboardList: state.team!.leaderboard!,
                        ),
                      ],
                    )),
        );
      },
    );
  }

  void openInviteReader(BuildContext context, Team? team) {
    SendInviteProvider.open(context, team: team).then((refresh) {
      if (refresh == true) {
        getTeamData();
      }
    });
  }

  void openEditTeam(BuildContext context, TeamProfileState state) {
    UserManagementProvider()
        .openEditTeam(context, team: state.team!)
        .then((refresh) {
      if (refresh == true) {
        getTeamData();
      }
    });
  }

  Future<dynamic> getTeamData() {
    var completer = Completer();
    context.read<TeamProfileCubit>().getTeamProfileData(
      onSuccess: () {
        completer.complete();
      },
      onError: (error) {
        widget.handleError<bool>(context, error,
            btnLabel: 'Intentar nuevamente',
            linkBtnLabel: 'Volver al home', linkBtnOnTap: () {
          Navigator.of(context, rootNavigator: true)
              .popUntil((route) => route.isFirst);
          Navigator.of(context).pushNamed(Routes.home);
        }).then((isRefresh) {
          if (isRefresh != null) {
            if (isRefresh) {
              getTeamData();
            }
          }
        });
        completer.completeError(error);
      },
    );
    return completer.future;
  }
}
