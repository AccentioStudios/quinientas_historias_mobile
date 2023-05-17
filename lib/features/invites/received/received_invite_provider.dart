import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/invites_repository.dart';
import '../data/useCases/invites_usecases.dart';
import 'ui/cubit/received_invites_cubit.dart';
import 'ui/pages/received_invites_page.dart';

@RoutePage<bool?>()
class ReceivedInviteProvider extends StatelessWidget {
  const ReceivedInviteProvider(
      {super.key,
      @PathParam('role') required this.role,
      @PathParam('inviteId') required this.inviteId,
      @QueryParam('code') this.code});
  final String? role;
  final int? inviteId;
  final String? code;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceivedInvitesCubit(
          invitesUseCases: InvitesUseCases(repository: InvitesRepository())),
      child: ReceivedInvitesPage(
        code: code ?? '',
        inviteId: inviteId ?? 0,
      ),
    );
  }

  static open(BuildContext? context,
      {required int inviteId,
      String? email,
      required String code,
      required String role}) {
    if (context != null) {
      Navigator.of(context).push<void>(MaterialPageRoute<void>(
          builder: (context) => ReceivedInviteProvider(
                role: role,
                code: code,
                inviteId: inviteId,
              )));
    }
  }
}
