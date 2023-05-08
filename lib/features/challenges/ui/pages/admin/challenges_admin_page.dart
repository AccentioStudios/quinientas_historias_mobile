import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/challenges_admin_cubit.dart';
import 'challenges_admin_register.dart';

class ChallengesAdminPage extends StatefulWidget {
  const ChallengesAdminPage({Key? key, this.testMode}) : super(key: key);
  final String? testMode;

  @override
  State<ChallengesAdminPage> createState() => _ChallengesAdminPageState();
}

class _ChallengesAdminPageState extends State<ChallengesAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar retos (SAR)'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
          physics: const AlwaysScrollableScrollPhysics()
              .applyTo(const BouncingScrollPhysics()),
          children: [
            ListTile(
              title: const Text('Registar nuevo reto'),
              subtitle: const Text('Registra un nuevo reto en el sistema'),
              trailing: const Icon(Icons.add),
              onTap: () => _navigateToRegisterNewChallenge(context),
            ),
            ListTile(
              title: const Text('Ver lista de retos'),
              subtitle:
                  const Text('Busca retos e inícialos en modo de pruebas.'),
              trailing: const Icon(Icons.search),
              onTap: () {},
            ),
          ]),
    );
  }

  void _navigateToRegisterNewChallenge(BuildContext context) {
    final cubit = context.read<ChallengesAdminCubit>();
    // Navigate passing BlocProvider.value to avoid creating a new instance of the cubit
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: cubit,
          child: const ChallengesAdminRegisterPage(),
        ),
      ),
    );

    // AutoRouter.of(context).push(CustomRoute(
    //   page: ChallengesAdminRegisterPage,
    //   customRouteBuilder: (context, child, page) {},
    // ));
  }
}
