import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/mixins/error_handling.dart';
import 'package:quinientas_historias/core/utils/constants.dart';
import 'package:quinientas_historias/features/profiles_module/user_profile/ui/bloc/cubit/user_profile_cubit.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/user_avatar.dart';

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
          body: RefreshIndicator(
            onRefresh: () async {
              getUserData();
            },
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: <Widget>[
                      UserAvatar(
                        user: state.user!,
                        width: 140,
                        height: 140,
                      ),
                      const SizedBox(
                        width: Constants.space18,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Future<dynamic> getUserData() {
    var completer = Completer();
    context.read<UserProfileCubit>().getUserData(
      onSuccess: () {
        completer.complete();
      },
      onError: (error) {
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
