import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/ui/widgets/outlined_card.dart';
import 'package:quinientas_historias/core/utils/constants.dart';

import '../../cubit/challenges_admin_cubit.dart';

@RoutePage()
class ChallengesAdminHomePage extends StatefulWidget {
  const ChallengesAdminHomePage({super.key, this.testMode});
  final String? testMode;

  @override
  State<ChallengesAdminHomePage> createState() =>
      _ChallengesAdminHomePageState();
}

class _ChallengesAdminHomePageState extends State<ChallengesAdminHomePage> {
  late Timer? timer = Timer.periodic(const Duration(seconds: 5), (_) {
    context.read<ChallengesAdminCubit>().checkHealth();
  });

  @override
  void initState() {
    super.initState();
    _checkHealth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema Administrador de Retos'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<ChallengesAdminCubit, ChallengesAdminState>(
        builder: (BuildContext context, state) {
          return ListView(
              physics: const AlwaysScrollableScrollPhysics()
                  .applyTo(const BouncingScrollPhysics()),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: Constants.space18,
                      right: Constants.space18,
                      bottom: Constants.space18),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: OutlinedCard(
                          child: Flex(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              direction: Axis.horizontal,
                              children: [
                                Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: state.health?.auth.ok == true
                                        ? Colors.green
                                        : Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: Constants.space12),
                                const Flexible(
                                    child: Text('Salud del sistema de Auth')),
                                // circular widget with green color if system is healthy or red if not
                              ]),
                        ),
                      ),
                      const SizedBox(width: Constants.space12),
                      Expanded(
                        child: OutlinedCard(
                          child: Flex(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              direction: Axis.horizontal,
                              children: [
                                Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: state.health?.retos.ok == true
                                        ? Colors.green
                                        : Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: Constants.space12),
                                const Flexible(
                                    child: Text('Salud del sistema de Retos')),
                                // circular widget with green color if system is healthy or red if not
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  enabled: state.health?.retos.ok == true,
                  title: const Text('Registar nuevo reto'),
                  subtitle: const Text('Registra un nuevo reto en el sistema'),
                  trailing: const Icon(Icons.add),
                  onTap: () => _navigateToRegisterNewChallenge(context),
                ),
                ListTile(
                  enabled: state.health?.retos.ok == true,
                  title: const Text('Ver lista de retos'),
                  subtitle:
                      const Text('Busca retos e inícialos en modo de pruebas.'),
                  trailing: const Icon(Icons.search),
                  onTap: () => _navigateToExploreChallenges(context),
                ),
              ]);
        },
      ),
    );
  }

  void _navigateToRegisterNewChallenge(BuildContext context) {
    context.router.pushNamed('/challenge/admin/register');
  }

  void _navigateToExploreChallenges(BuildContext context) {
    context.router.pushNamed('/challenge/admin/explore');
  }

  void _checkHealth() {
    context.read<ChallengesAdminCubit>().checkHealth();
    // rerun every 5 seconds and cancel the previous one
    if (timer != null) {
      timer?.cancel();
    }
    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      context.read<ChallengesAdminCubit>().checkHealth();
    });
  }
}
