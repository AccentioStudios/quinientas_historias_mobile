import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubit/tournament_admin_cubit.dart';

@RoutePage()
class TournamentAdminHomePage extends StatefulWidget {
  const TournamentAdminHomePage({super.key});

  @override
  State<TournamentAdminHomePage> createState() =>
      _TournamentAdminHomePageState();
}

class _TournamentAdminHomePageState extends State<TournamentAdminHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrador de Torneos'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<TournamentAdminCubit, TournamentAdminState>(
        builder: (BuildContext context, state) {
          return ListView(
              physics: const AlwaysScrollableScrollPhysics()
                  .applyTo(const BouncingScrollPhysics()),
              children: [
                ListTile(
                  title: const Text('Registar nuevo Torneo'),
                  subtitle:
                      const Text('Registra un nuevo torneo en el sistema'),
                  trailing: const Icon(Icons.add),
                  onTap: () => _navigateToRegisterNewTournament(context),
                ),
                // ListTile(
                //   title: const Text('Ver lista de Torneos'),
                //   subtitle:
                //       const Text('Revisa la lista de torneos y administralos.'),
                //   trailing: const Icon(Icons.search),
                //   onTap: () => _navigateToExploreTournament(context),
                // ),
              ]);
        },
      ),
    );
  }

  void _navigateToRegisterNewTournament(BuildContext context) {
    context.router.pushNamed('/tournament/admin/register');
  }

  // void _navigateToExploreTournament(BuildContext context) {
  //   context.router.pushNamed('/tournament/admin/explore');
  // }
}
