import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/entities/school_entity.dart';
import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/data/entities/tournament_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/widgets/group_avatar.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/role_widget.dart';
import '../../../../../core/utils/constants.dart';

import '../../../../user_managment/user_management_provider.dart';
import '../bloc/cubit/send_invites_cubit.dart';
import '../widgets/team_list_item.dart';

class ChooseTeamForInvitePage extends StatefulWidget
    with ErrorHandling, SheetMessages {
  const ChooseTeamForInvitePage(
      {super.key,
      required this.school,
      required this.tournament,
      this.role = Role.reader});
  final School school;
  final Tournament tournament;
  final Role role;
  @override
  State<ChooseTeamForInvitePage> createState() =>
      _ChooseTeamForInvitePageState();
}

class _ChooseTeamForInvitePageState extends State<ChooseTeamForInvitePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getTeams(widget.school.id);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getTeams(widget.school.id),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Elige el equipo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            RoleWidget(
              roles: const [
                Role.admin,
                Role.prof,
              ],
              child: TextButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Nuevo Equipo"),
                onPressed: () {
                  createNewTeamFlow(context);
                },
              ),
            ),
          ],
        ),
        body: SafeArea(child: SingleChildScrollView(
          child: BlocBuilder<SendInvitesCubit, SendInvitesState>(
            builder: (context, state) {
              return state.isLoading
                  ? SizedBox(
                      height: MediaQuery.sizeOf(context).height -
                          MediaQuery.of(context).viewInsets.top -
                          80,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : PaddingColumn(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.space16,
                          vertical: Constants.space16),
                      children: [
                          Text(
                            'Selecciona el equipo al que quieres invitar nuevos ${formatRole(widget.role)}.',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Headline(label: 'Equipos'),
                          ...state.profTeams.map(
                            (team) => Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Constants.space16),
                              child: GroupListItem(
                                  avatarWidget: GroupAvatar(
                                    avatarUrl: team.avatarUrl,
                                    type: GroupAvatarType.team,
                                  ),
                                  label: AutoSizeText(
                                    team.name,
                                    textAlign: TextAlign.left,
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(fontSize: 15),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    chooseTeam(context, team);
                                  }),
                            ),
                          ),
                        ]);
            },
          ),
        )),
      ),
    );
  }

  void createNewTeamFlow(BuildContext context) {
    UserManagementProvider()
        .openRegisterTeam(context,
            school: widget.school, tournamentId: widget.tournament.id)
        .then((team) {
      getTeams(widget.school.id);
      if (team != null) {
        widget.showCompactMessage(context,
            title: "Equipo creado",
            btnLabel: "Si, quiero",
            secondaryBtnLabel: "No, gracias",
            contentBuilder: (BuildContext context) {
          return PaddingColumn(
            padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
            children: [
              const SizedBox(height: Constants.space16),
              GroupAvatar(
                  width: 52,
                  height: 52,
                  type: GroupAvatarType.team,
                  avatarUrl: team.avatarUrl),
              const SizedBox(height: Constants.space16),
              Text(
                "El equipo ${team.name} ha sido creado.\n\n¿Deseas elegir este equipo para continuar?",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          );
        }).then((value) {
          if (value == true) {
            chooseTeam(context, team);
          }
        });
      }
    });
  }

  String formatRole(Role role) {
    switch (role) {
      case Role.reader:
        return 'lectores';
      case Role.prof:
        return 'profesores';
      case Role.captain:
        return 'capitanes';
      case Role.editor:
        return 'editores';
      case Role.jury:
        return 'jurados';
      default:
        return 'usuarios';
    }
  }

  void chooseTeam(BuildContext context, Team team) {
    Navigator.of(context).pop(team);
  }

  getTeams(int schoolId) {
    context
        .read<SendInvitesCubit>()
        .getTeamsFromProf(schoolId)
        .onError<HttpFailure>((error, stackTrace) {
      widget.handleError(context, error);
    });
  }
}
