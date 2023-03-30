import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/widgets/group_avatar.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/utils/constants.dart';
import '../../send_invite_provider.dart';
import '../bloc/cubit/send_invites_cubit.dart';
import '../widgets/team_list_item.dart';

class ChooseTeamForInvitePage extends StatefulWidget with ErrorHandling {
  const ChooseTeamForInvitePage({super.key, required this.schoolId});
  final int schoolId;

  @override
  State<ChooseTeamForInvitePage> createState() =>
      _ChooseTeamForInvitePageState();
}

class _ChooseTeamForInvitePageState extends State<ChooseTeamForInvitePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getTeams(widget.schoolId);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getTeams(widget.schoolId),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Elige el equipo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(child: SingleChildScrollView(
          child: BlocBuilder<SendInvitesCubit, SendInvitesState>(
            builder: (context, state) {
              return state.isLoading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height -
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
                          const Text(
                            'Selecciona el equipo al que quieres invitar nuevos lectores.\n\nLos equipos listados abajos son los equipos pertenecientes a la escuela donde eres profesor:',
                            style: TextStyle(fontSize: 16),
                          ),
                          const Headline(label: 'Equipos'),
                          ...state.profTeams.map(
                            (team) => Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Constants.space16),
                              child: TeamListItem(
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

  void chooseTeam(BuildContext context, Team team) {
    SendInviteProvider.open(context, team: team).then((value) {});
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
