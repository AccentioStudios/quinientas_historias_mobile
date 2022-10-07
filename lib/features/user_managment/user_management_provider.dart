import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quinientas_historias/features/user_managment/data/repositories/user_management_repositories.dart';
import 'package:quinientas_historias/features/user_managment/data/useCases/user_management_use_cases.dart';
import 'package:quinientas_historias/features/user_managment/ui/cubit/user_management_cubit.dart';

import '../../core/data/entities/invites_entity.dart';
import 'ui/register/pages/register_reader_page.dart';

class UserManagementProvider {
  static openRegisterReader(BuildContext context,
      {required Invite invite, required String code}) {
    const secureStorage = FlutterSecureStorage();
    secureStorage.deleteAll();

    Navigator.of(context, rootNavigator: true).push<void>(
      MaterialPageRoute<void>(
        builder: (context) => BlocProvider(
          create: (context) => UserManagementCubit(
            userManagementUseCases: UserManagementUseCases(
              repository: UserManagementRepository(),
            ),
          ),
          child: RegisterReaderPage(
            invitationCode: code,
            invite: invite,
          ),
        ),
      ),
    );
  }
}




  // const UserManagementProvider(
  //     {Key? key,
  //     this.typeUserToInvite = UserType.reader,
  //     required this.email,
  //     required this.code})
  //     : super(key: key);
  // final UserType typeUserToInvite;
  // final String email;
  // final String code;