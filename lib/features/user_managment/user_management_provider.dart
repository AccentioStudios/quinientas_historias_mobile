import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'ui/existingUser/confirmation_existing_user_accept_invite.dart';
import 'ui/register/pages/register_school_page.dart';

import '../../core/data/dto/team_profile_dto.dart';
import '../../core/data/dto/user_profile_dto.dart';
import '../../core/data/entities/invites_entity.dart';
import '../../core/data/entities/school_entity.dart';
import '../../core/data/entities/team_entity.dart';
import '../../core/integrations/secure_storage_service.dart';
import 'data/repositories/group_management_repositories.dart';
import 'data/repositories/user_management_repositories.dart';
import 'data/useCases/group_management_use_cases.dart';
import 'data/useCases/user_management_use_cases.dart';
import 'ui/cubit/group_management_cubit.dart';
import 'ui/cubit/user_management_cubit.dart';
import 'ui/edit/pages/edit_school_page.dart';
import 'ui/edit/pages/edit_team_page.dart';
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

  Future<Team?> openRegisterTeam(BuildContext context,
      {required School? school,
      required int tournamentId,
      bool? join = false}) {
    if (school != null) {
      return Navigator.of(context, rootNavigator: true).push<Team>(
        MaterialPageRoute<Team>(
          builder: (context) => BlocProvider(
            create: (context) => groupManagementcubit,
            child: RegisterTeamPage(
                school: school, tournamentId: tournamentId, join: join),
          ),
        ),
      );
    }
    return Future.value(null);
  }

  Future<School?> openRegisterSchool(BuildContext context,
      {bool? join = false}) {
    return Navigator.of(context, rootNavigator: true).push<School>(
      MaterialPageRoute<School>(
        builder: (context) => BlocProvider(
          create: (context) => groupManagementcubit,
          child: RegisterSchoolPage(join: join),
        ),
      ),
    );
  }

  Future<bool?> openEditTeam(BuildContext context,
      {required TeamProfileDto team}) {
    return Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => BlocProvider(
          create: (context) => groupManagementcubit,
          child: EditTeamPage(
            team: team,
          ),
        ),
      ),
    );
  }

  Future<bool?> openEditSchool(BuildContext context, {required School school}) {
    return Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => BlocProvider(
          create: (context) => groupManagementcubit,
          child: EditSchoolPage(
            school: school,
          ),
        ),
      ),
    );
  }

  Future<bool?> openRegisterReader(BuildContext context,
      {required Invite invite, bool? autoNavigateToHome}) {
    GetIt.I<SecureStorageService>().deleteAll();
    return Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => BlocProvider(
          create: (context) => userManagementcubit,
          child: RegisterReaderPage(
            invite: invite,
            autoNavigateToHome: autoNavigateToHome,
          ),
        ),
      ),
    );
  }

  Future<bool?> openAcceptInvite(BuildContext context,
      {required Invite invite}) {
    if (invite.invitedId != null) {
      return Navigator.of(context, rootNavigator: true).push<bool>(
        MaterialPageRoute<bool>(
          builder: (context) => BlocProvider(
            create: (context) => userManagementcubit,
            child: ConfirmationExistingUserAcceptInvite(
              invite: invite,
            ),
          ),
        ),
      );
    }
    return Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => BlocProvider(
          create: (context) => userManagementcubit,
          child: RegisterReaderPage(
            invite: invite,
          ),
        ),
      ),
    );
  }

  Future<bool?> openEditUser(BuildContext context,
      {required UserProfileDto user}) {
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
