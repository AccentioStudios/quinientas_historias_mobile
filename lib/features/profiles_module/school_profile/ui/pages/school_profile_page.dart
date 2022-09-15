import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/mixins/error_handling.dart';
import 'package:quinientas_historias/features/profiles_module/school_profile/ui/bloc/cubit/school_profile_cubit.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/constants.dart';
import '../components/teams_profile_leaderboard_team_list.dart';
import '../widgets/school_profile_cards_widget.dart';
import '../widgets/school_profile_header_widget.dart';

class SchoolProfilePage extends StatefulWidget with ErrorHandling {
  const SchoolProfilePage({Key? key}) : super(key: key);

  @override
  State<SchoolProfilePage> createState() => _SchoolProfilePageState();
}

class _SchoolProfilePageState extends State<SchoolProfilePage> {
  // @override
  // void didChangeDependencies() {
  //   getSchoolData();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchoolProfileCubit, SchoolProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: RefreshIndicator(
              onRefresh: () async {
                getSchoolData();
              },
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SchoolProfileHeader(
                          state: state,
                        ),
                        const SizedBox(height: Constants.space41),
                        SchoolCards(
                          state: state,
                        ),
                        // TeamsProfileLeaderboardTeamList(
                        //   state: state,
                        // ),
                      ],
                    )),
        );
      },
    );
  }

  Future<dynamic> getSchoolData() {
    var completer = Completer();
    context.read<SchoolProfileCubit>().getSchoolProfileData(
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
              getSchoolData();
            }
          }
        });
        completer.completeError(error);
      },
    );
    return completer.future;
  }
}
