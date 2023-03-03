import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/entities/user_entity.dart';
import '../../../core/helpers/secure_storage_helper.dart';
import '../data/repositories/invites_repository.dart';
import '../data/useCases/invites_usecases.dart';
import 'ui/cubit/received_invites_cubit.dart';
import 'ui/pages/received_invites_page.dart';

class ReceivedInviteProvider extends StatelessWidget {
  const ReceivedInviteProvider(
      {Key? key,
      this.typeUserToInvite = Role.reader,
      required this.email,
      required this.code})
      : super(key: key);
  final Role typeUserToInvite;
  final String email;
  final String code;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceivedInvitesCubit(
          invitesUseCases: InvitesUseCases(repository: InvitesRepository())),
      child: ReceivedInvitesPage(
        code: code,
        email: email,
      ),
    );
  }

  static open(BuildContext? context,
      {GlobalKey<NavigatorState>? navigatorKey,
      required String email,
      required String code}) {
    final navigator = navigatorKey != null
        ? navigatorKey.currentState
        : Navigator.of(context!, rootNavigator: true);

    if (navigator != null) {
      SecureStorageHelper.deleteAll();

      navigator.push<void>(MaterialPageRoute<void>(
          builder: (context) => ReceivedInviteProvider(
                code: code,
                email: email,
              )));
    }
  }
}
