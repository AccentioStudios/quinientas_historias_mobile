import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/data/entities/school_entity.dart';
import 'package:quinientas_historias/core/data/entities/tournament_entity.dart';
import 'package:quinientas_historias/features/invites/send/ui/pages/choose_school_for_invite_page.dart';
import 'package:quinientas_historias/features/invites/send/ui/pages/choose_tournament_for_invite_page.dart';

import '../../../core/data/entities/team_entity.dart';
import '../../../core/data/entities/user_entity.dart';
import '../data/repositories/invites_repository.dart';
import '../data/useCases/invites_usecases.dart';
import 'ui/bloc/cubit/send_invites_cubit.dart';
import 'ui/pages/choose_team_for_invite_page.dart';
import 'ui/pages/send_invites_page.dart';

@RoutePage<bool?>()
class SendInviteProvider extends StatelessWidget {
  const SendInviteProvider({
    super.key,
    this.typeUserToInvite = Role.reader,
    required this.team,
    required this.schoolId,
    this.tournamentId,
  });
  final Role typeUserToInvite;
  final Team? team;
  final int? schoolId;
  final int? tournamentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendInvitesCubit(
          invitesUseCases: InvitesUseCases(repository: InvitesRepository())),
      child: SendInvitesPage(
        typeUserToInvite: typeUserToInvite,
        schoolId: schoolId,
        team: team,
        tournamentId: tournamentId,
      ),
    );
  }

  static Future<bool?> open(
    BuildContext context, {
    Team? team,
    int? schoolId,
    int? tournamentId,
    Role typeUserToInvite = Role.reader,
  }) {
    return Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => SendInviteProvider(
          schoolId: schoolId,
          tournamentId: tournamentId,
          team: team,
          typeUserToInvite: typeUserToInvite,
        ),
      ),
    );
  }

  static Future<Team?> chooseTeamForInviteProfAndAdmin(BuildContext context,
      {required int schoolId}) {
    return Navigator.of(context, rootNavigator: true).push<Team>(
      MaterialPageRoute<Team>(
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

  static Future<School?> chooseSchoolForInviteAdmin(BuildContext context,
      {Role role = Role.reader}) {
    return Navigator.of(context, rootNavigator: true).push<School>(
      MaterialPageRoute<School>(
        builder: (context) => BlocProvider(
          create: (context) => SendInvitesCubit(
              invitesUseCases:
                  InvitesUseCases(repository: InvitesRepository())),
          child: ChooseSchoolForInvitePage(
            role: role,
          ),
        ),
      ),
    );
  }

  static Future<Tournament?> chooseTournamentForInviteAdmin(
      BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<Tournament>(
      MaterialPageRoute<Tournament>(
        builder: (context) => BlocProvider(
          create: (context) => SendInvitesCubit(
              invitesUseCases:
                  InvitesUseCases(repository: InvitesRepository())),
          child: const ChooseTournamentForInvitePage(),
        ),
      ),
    );
  }
}
