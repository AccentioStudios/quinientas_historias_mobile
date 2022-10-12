import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';

import '../../../../../core/failures/status_codes.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../user_managment/user_management_provider.dart';
import '../bloc/cubit/user_profile_cubit.dart';
import '../widgets/user_division_card.dart';
import '../widgets/user_profile_cards.dart';
import '../widgets/user_profile_favorites.dart';
import '../widgets/user_profile_header.dart';

class UserProfilePage extends StatefulWidget with ErrorHandling {
  const UserProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void didChangeDependencies() {
    getUserData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              if (state.isMyProfile)
                TextButton.icon(
                  onPressed: () {
                    openEditUser(context, state);
                  },
                  icon: SvgPicture.asset('assets/icons/edit-icon.svg'),
                  label: Text(
                    'Editar Perfil',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
              const SizedBox(width: 8),
            ],
            elevation: 0,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              getUserData();
            },
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.httpFailure?.statusCode == StatusCodes.notFound
                    ? const Center(
                        child: Text(
                          'El usuario no existe\n:\'c',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : ListView(
                        physics: const BouncingScrollPhysics(),
                        children: <Widget>[
                          const SizedBox(height: Constants.space21),
                          UserProfileHeader(
                            state: state,
                          ),
                          if (state.user?.type == UserType.captain ||
                              state.user?.type == UserType.reader)
                            Column(
                              children: [
                                const SizedBox(height: Constants.space41),
                                UserDivisionCard(
                                  state: state,
                                ),
                              ],
                            ),
                          const SizedBox(height: Constants.space16),
                          UserCards(
                            state: state,
                          ),
                          UserFavorites(
                            state: state,
                          ),
                        ],
                      ),
          ),
        );
      },
    );
  }

  void openEditUser(BuildContext context, UserProfileState state) {
    UserManagementProvider()
        .openEditUser(context, user: state.user!)
        .then((refresh) {
      if (refresh == true) {
        getUserData();
      }
    });
  }

  Future<dynamic> getUserData() {
    var completer = Completer();
    context.read<UserProfileCubit>().getUserData(
      onSuccess: () {
        completer.complete();
      },
      onError: (error) {
        if (error.statusCode == StatusCodes.notFound) {
          return completer.completeError(error);
        }
        widget.handleError<bool>(context, error,
            btnLabel: 'Intentar nuevamente',
            linkBtnLabel: 'Volver al home', linkBtnOnTap: () {
          Navigator.of(context, rootNavigator: true)
              .popUntil((route) => route.isFirst);
          Navigator.of(context).pushNamed(Routes.home);
        }).then((isRefresh) {
          if (isRefresh != null) {
            if (isRefresh) {
              getUserData();
            }
          }
        });
        completer.completeError(error);
      },
    );
    return completer.future;
  }
}
