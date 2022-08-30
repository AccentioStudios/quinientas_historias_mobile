// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quinientas_historias/core/utils/constants.dart';
import 'package:quinientas_historias/features/profiles_module/team_profile/ui/bloc/cubit/team_profile_cubit.dart';
import 'package:quinientas_historias/features/profiles_module/team_profile/ui/components/user_profile_leaderboard_team_list.dart';
import 'package:quinientas_historias/features/profiles_module/team_profile/ui/widgets/team_profile_header_widget.dart';

import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../invites/invites_provider.dart';

class TeamProfilePage extends StatefulWidget with ErrorHandling {
  const TeamProfilePage({Key? key}) : super(key: key);

  @override
  State<TeamProfilePage> createState() => _TeamProfilePageState();
}

class _TeamProfilePageState extends State<TeamProfilePage> {
  @override
  void didChangeDependencies() {
    getTeamData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamProfileCubit, TeamProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: <Widget>[
              TextButton.icon(
                label: Text(
                  'Invitar Lectores',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(
                          builder: (_) => const InvitesProvider(
                                typeUserToInvite: UserType.reader,
                              )));
                },
                icon: SvgPicture.asset('assets/icons/user-plus.svg'),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: RefreshIndicator(
              onRefresh: () async {
                getTeamData();
              },
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(physics: BouncingScrollPhysics(), children: [
                      TeamProfileHeaderWidget(state: state),
                      PaddingColumn(
                        padding:
                            EdgeInsets.symmetric(horizontal: Constants.space16),
                        children: const <Widget>[
                          Headline(
                            marginTop: Constants.space41,
                            label: 'Tablero de posiciones del equipo',
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: Constants.space18,
                            right: Constants.space18,
                            bottom: Constants.space21),
                        child: UserProfileLeaderboardTeamList(state: state),
                      )
                    ])),
        );
      },
    );
  }

  Future<dynamic> getTeamData() {
    var completer = Completer();
    context.read<TeamProfileCubit>().getTeamProfileData(
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
              getTeamData();
            }
          }
        });
        completer.completeError(error);
      },
    );
    return completer.future;
  }
}
