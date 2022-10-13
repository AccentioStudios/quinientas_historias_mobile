import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/data/entities/invites_entity.dart';
import '../../core/data/entities/school_entity.dart';
import '../../core/data/entities/user_entity.dart';
import 'data/repositories/group_management_repositories.dart';
import 'data/repositories/user_management_repositories.dart';
import 'data/useCases/group_management_use_cases.dart';
import 'data/useCases/user_management_use_cases.dart';
import 'ui/cubit/group_management_cubit.dart';
import 'ui/cubit/user_management_cubit.dart';
import 'ui/edit/pages/edit_user_page.dart';
import 'ui/register/pages/register_reader_page.dart';
import 'ui/register/pages/register_team_page.dart';

class UserManagementProvider {
  final userManagementcubit = UserManagementCubit(
    userManagementUseCases: UserManagementUseCases(
      repository: UserManagementRepository(),
    ),
  );

  final groupManagementcubit = GroupManagementCubit(
    groupManagementUseCases: GroupManagementUseCases(
      repository: GroupManagementRepository(),
    ),
  );

  Future<bool?> openRegisterTeam(BuildContext context,
      {required School? school}) {
    if (school != null) {
      return Navigator.of(context, rootNavigator: true).push<bool>(
        MaterialPageRoute<bool>(
          builder: (context) => BlocProvider(
            create: (context) => groupManagementcubit,
            child: RegisterTeamPage(school: school),
          ),
        ),
      );
    }
    return Future.value(false);
  }

  Future<bool?> openRegisterReader(BuildContext context,
      {required Invite invite, required String code}) {
    const secureStorage = FlutterSecureStorage();
    secureStorage.deleteAll();

    return Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => BlocProvider(
          create: (context) => userManagementcubit,
          child: RegisterReaderPage(
            invitationCode: code,
            invite: invite,
          ),
        ),
      ),
    );
  }

  Future<bool?> openEditUser(BuildContext context, {required User user}) {
    return Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => BlocProvider(
          create: (context) => userManagementcubit,
          child: EditUserPage(
            user: user,
          ),
        ),
      ),
    );
  }
}
