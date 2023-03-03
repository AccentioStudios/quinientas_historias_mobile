import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/entities/team_entity.dart';
import '../../../core/data/entities/user_entity.dart';
import '../data/repositories/invites_repository.dart';
import '../data/useCases/invites_usecases.dart';
import 'ui/bloc/cubit/send_invites_cubit.dart';
import 'ui/pages/choose_team_for_invite_page.dart';
import 'ui/pages/send_invites_page.dart';

class SendInviteProvider extends StatelessWidget {
  const SendInviteProvider(
      {Key? key,
      this.typeUserToInvite = Role.reader,
      required this.team,
      required this.schoolId})
      : super(key: key);
  final Role typeUserToInvite;
  final Team? team;
  final int? schoolId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendInvitesCubit(
          invitesUseCases: InvitesUseCases(repository: InvitesRepository())),
      child: SendInvitesPage(
        typeUserToInvite: typeUserToInvite,
        schoolId: schoolId,
        team: team,
      ),
    );
  }

  static Future<bool?> open(BuildContext context,
      {Team? team, int? schoolId, Role typeUserToInvite = Role.reader}) {
    return Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => SendInviteProvider(
          schoolId: schoolId,
          team: team,
          typeUserToInvite: typeUserToInvite,
        ),
      ),
    );
  }

  static Future<bool?> inviteReadersProf(BuildContext context,
      {required int schoolId}) {
    return Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => BlocProvider(
          create: (context) => SendInvitesCubit(
              invitesUseCases:
                  InvitesUseCases(repository: InvitesRepository())),
          child: ChooseTeamForInvitePage(
            schoolId: schoolId,
          ),
        ),
      ),
    );
  }
}
