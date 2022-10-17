import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/entities/user_entity.dart';
import '../data/repositories/invites_repository.dart';
import '../data/useCases/invites_usecases.dart';
import 'ui/bloc/cubit/send_invites_cubit.dart';
import 'ui/pages/send_invites_page.dart';

class SendInviteProvider extends StatelessWidget {
  const SendInviteProvider(
      {Key? key,
      this.typeUserToInvite = UserType.reader,
      required this.teamId,
      required this.schoolId})
      : super(key: key);
  final UserType typeUserToInvite;
  final int? teamId;
  final int? schoolId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendInvitesCubit(
          invitesUseCases: InvitesUseCases(repository: InvitesRepository())),
      child: SendInvitesPage(
        typeUserToInvite: typeUserToInvite,
        schoolId: schoolId,
        teamId: teamId,
      ),
    );
  }

  static Future<bool?> open(BuildContext context,
      {int? teamId, int? schoolId}) {
    return Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => SendInviteProvider(
          schoolId: schoolId,
          teamId: teamId,
        ),
      ),
    );
  }
}
