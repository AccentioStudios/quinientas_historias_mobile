// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/features/profiles_module/team_profile/ui/bloc/cubit/team_profile_cubit.dart';

import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constants.dart';

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
          body: RefreshIndicator(
            onRefresh: () async {
              getTeamData();
            },
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      AppBar(
                        elevation: 0,
                        actions: <Widget>[
                          GestureDetector(
                            onTap: () {
                              //CODIGO
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/user-plus.svg'),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: Constants.space18, left: 10.0),
                                  child: Text("Invitar lectores",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: onSurfaceMutedTextDarkColor)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 44.0),
                      SizedBox(
                        height: 140,
                        width: 140,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            CircleAvatar(
                              backgroundColor: onSurfaceMutedTextDarkColor,
                              child: CircleAvatar(
                                radius: 68,
                                backgroundImage:
                                    AssetImage("assets/images/logo-equipo.png"),
                              ),
                            ),
                            Positioned(
                                bottom: -28,
                                right: -28,
                                child: RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 0,
                                  shape: CircleBorder(),
                                  child: Container(
                                    height: 64,
                                    width: 64,
                                    color: Colors.transparent,
                                    child: SvgPicture.asset(
                                        'assets/icons/plus.svg'),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 22.0),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          state.data?.name ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
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
