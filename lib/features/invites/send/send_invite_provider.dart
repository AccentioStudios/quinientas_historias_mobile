import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/entities/user_entity.dart';
import '../data/repositories/invites_repository.dart';
import '../data/useCases/invites_usecases.dart';
import 'ui/bloc/cubit/send_invites_cubit.dart';
import 'ui/pages/send_invites_page.dart';

class SendInviteProvider extends StatelessWidget {
  const SendInviteProvider({Key? key, this.typeUserToInvite = UserType.reader})
      : super(key: key);
  final UserType typeUserToInvite;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendInvitesCubit(
          invitesUseCases: InvitesUseCases(repository: InvitesRepository())),
      child: SendInvitesPage(
        typeUserToInvite: typeUserToInvite,
      ),
    );
  }

  static Future<bool?> open(
    BuildContext context,
  ) {
    return Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => const SendInviteProvider(),
      ),
    );
  }
}
