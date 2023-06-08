import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/data/dto/auth_dto.dart';
import 'package:quinientas_historias/core/integrations/secure_storage_service.dart';

import '../../../../core/data/entities/tournament_entity.dart';
import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/utils/constants.dart';

class TournamentHeaderWidget extends StatelessWidget {
  const TournamentHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const paddingHeader = EdgeInsets.symmetric(
        horizontal: Constants.space18, vertical: Constants.space18);
    return SliverToBoxAdapter(
      child: Container(
        height: 158 + MediaQuery.of(context).padding.top,
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              title: const Text('Torneos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              centerTitle: true,
              actions: [
                FutureBuilder<JwtPayload?>(
                    future: SecureStorageService().getSessionData(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox.shrink();
                      }
                      final role = snapshot.data!.role;
                      if (role != Role.admin) {
                        return const SizedBox.shrink();
                      }
                      return TextButton.icon(
                          onPressed: () {
                            _navigateToTournamentAdmin(context);
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Nuevo Torneo'));
                    }),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: paddingHeader,
                  child: Row(
                    children: [
                      SizedBox(
                        child: SvgPicture.asset(
                            'assets/icons/tournament-icon.svg'),
                      ),
                      const SizedBox(width: Constants.space21),
                      const Flexible(
                        child: Text(
                          'Compite con otras escuelas y sube de posición con tu equipo para ganar el torneo',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _navigateToTournamentAdmin(BuildContext context) {
    // AutoRouter.of(context).push(TournamentAdminRoute());
    context.router.pushNamed('/tournament/admin/register');
  }

  int calculatePercentageTournament(Tournament tournament) {
    var initDate = tournament.startAt;
    var endDate = tournament.endsAt;
    var today = DateTime.now();

    var from = DateTime(initDate.year, initDate.month, initDate.day);
    var to = DateTime(endDate.year, endDate.month, endDate.day);

    var daysDifferenceFromTodayDate =
        (to.difference(today).inHours / 24).round();

    var daysDifferenceFromInitDate = (to.difference(from).inHours / 24).round();

    return (daysDifferenceFromTodayDate * 100 / daysDifferenceFromInitDate)
        .round();
  }

  int getTournamentDayLeft(Tournament tournament) {
    var endDate = tournament.endsAt;
    var today = DateTime.now();
    var to = DateTime(endDate.year, endDate.month, endDate.day);

    var daysDifferenceFromTodayDate =
        (to.difference(today).inHours / 24).round();

    return daysDifferenceFromTodayDate;
  }
}

// Widget that only shows if the user has the role required
class RoleWidgetBuilder extends StatelessWidget {
  const RoleWidgetBuilder({
    super.key,
    required this.role,
    this.child,
    this.builder,
  }) : assert(
          child == null && builder == null,
          'You have to pass the child or the builder',
        );
  final Role role;
  final Widget? child;
  final AsyncWidgetBuilder<JwtPayload?>? builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<JwtPayload?>(
        future: SecureStorageService().getSessionData(),
        builder: builder ??
            (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }
              final role = snapshot.data!.role;
              if (role != role) {
                return const SizedBox.shrink();
              }
              return child!;
            });
  }
}
