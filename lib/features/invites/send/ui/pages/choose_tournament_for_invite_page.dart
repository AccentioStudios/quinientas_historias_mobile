import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/entities/tournament_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/role_widget.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/send_invites_cubit.dart';
import '../widgets/team_list_item.dart';

class ChooseTournamentForInvitePage extends StatefulWidget
    with ErrorHandling, SheetMessages {
  const ChooseTournamentForInvitePage({super.key});

  @override
  State<ChooseTournamentForInvitePage> createState() =>
      _ChooseTournamentForInvitePageState();
}

class _ChooseTournamentForInvitePageState
    extends State<ChooseTournamentForInvitePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getTournaments();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getTournaments(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Elige el torneo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            RoleWidget(
              roles: const [
                Role.admin,
                Role.prof,
              ],
              child: TextButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Nuevo Torneo"),
                onPressed: () {
                  createNewTournamentFlow(context);
                },
              ),
            ),
          ],
        ),
        body: SafeArea(child: SingleChildScrollView(
          child: BlocBuilder<SendInvitesCubit, SendInvitesState>(
            builder: (context, state) {
              return state.isLoading
                  ? SizedBox(
                      height: MediaQuery.sizeOf(context).height -
                          MediaQuery.of(context).viewInsets.top -
                          80,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : PaddingColumn(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.space16,
                          vertical: Constants.space16),
                      children: [
                          const Text(
                            'Selecciona el torneo:',
                            style: TextStyle(fontSize: 16),
                          ),
                          const Headline(label: 'Torneos'),
                          ...state.tournaments.map(
                            (tournament) => Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Constants.space16),
                              child: GroupListItem(
                                  avatarWidget: const SizedBox.shrink(),
                                  label: AutoSizeText(
                                    tournament.name ?? '',
                                    textAlign: TextAlign.left,
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(fontSize: 15),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    chooseTournament(context, tournament);
                                  }),
                            ),
                          ),
                        ]);
            },
          ),
        )),
      ),
    );
  }

  void createNewTournamentFlow(BuildContext context) {
    context.router.pushNamed('/tournament/admin/register').then((value) {
      getTournaments();
      // if (value != null) {
      //   if (value is Tournament) {
      //     widget.showCompactMessage(context,
      //         title: "Equipo creado",
      //         btnLabel: "Si, quiero",
      //         secondaryBtnLabel: "No, gracias",
      //         contentBuilder: (BuildContext context) {
      //       return PaddingColumn(
      //         padding:
      //             const EdgeInsets.symmetric(horizontal: Constants.space16),
      //         children: [
      //           const SizedBox(height: Constants.space16),
      //           Text(
      //             "El torneo ${value.name} ha sido creado.\n\n¿Deseas elegir este torneo para continuar?",
      //             textAlign: TextAlign.center,
      //             style: const TextStyle(fontSize: 16),
      //           ),
      //         ],
      //       );
      //     }).then((value) {
      //       if (value == true) {
      //         chooseTournament(context, value);
      //       }
      //     });
      //   }
      // }
    });
  }

  String formatRole(Role role) {
    switch (role) {
      case Role.reader:
        return 'lectores';
      case Role.prof:
        return 'profesores';
      case Role.captain:
        return 'capitanes';
      case Role.editor:
        return 'editores';
      case Role.jury:
        return 'jurados';
      default:
        return 'usuarios';
    }
  }

  void chooseTournament(BuildContext context, Tournament tournament) {
    Navigator.of(context).pop(tournament);
  }

  getTournaments() {
    context
        .read<SendInvitesCubit>()
        .getTournamentsForAdmin()
        .onError<HttpFailure>((error, stackTrace) {
      widget.handleError(context, error);
    });
  }
}
