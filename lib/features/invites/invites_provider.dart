import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/data/entities/user_entity.dart';
import 'data/repositories/invites_repository.dart';
import 'data/useCases/invites_usecases.dart';
import 'ui/bloc/cubit/invites_cubit.dart';
import 'ui/pages/invites_page.dart';

class InvitesProvider extends StatelessWidget {
  const InvitesProvider({Key? key, this.typeUserToInvite = UserType.reader})
      : super(key: key);
  final UserType typeUserToInvite;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InvitesCubit(
          invitesUseCases: InvitesUseCases(repository: InvitesRepository())),
      child: InvitesPage(
        typeUserToInvite: typeUserToInvite,
      ),
    );
  }
}
