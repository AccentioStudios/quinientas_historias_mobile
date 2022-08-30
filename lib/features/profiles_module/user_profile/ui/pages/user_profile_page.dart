import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/mixins/error_handling.dart';
import 'package:quinientas_historias/core/utils/constants.dart';
import 'package:quinientas_historias/features/profiles_module/user_profile/ui/bloc/cubit/user_profile_cubit.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/single_chip.dart';
import '../../../../../core/ui/widgets/user_avatar.dart';
import '../../user_profile_provider.dart';
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
              TextButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/edit-icon.svg'),
                label: Text(
                  'Editar Perfil',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
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
                : ListView(
                    children: <Widget>[
                      UserProfileHeader(
                        user: state.user!,
                      ),
                      UserCards(
                        state: state,
                      ),
                      UserFavorites(
                        state: state,
                      )
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
