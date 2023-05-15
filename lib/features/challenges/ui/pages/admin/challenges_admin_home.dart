import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


@RoutePage()
class ChallengesAdminHomePage extends StatefulWidget {
  const ChallengesAdminHomePage({Key? key, this.testMode}) : super(key: key);
  final String? testMode;

  @override
  State<ChallengesAdminHomePage> createState() =>
      _ChallengesAdminHomePageState();
}

class _ChallengesAdminHomePageState extends State<ChallengesAdminHomePage> {
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
              onTap: () => _navigateToExploreChallenges(context),
            ),
          ]),
    );
  }

  void _navigateToRegisterNewChallenge(BuildContext context) {
    context.router.pushNamed('/challenge/admin/register');
  }

  void _navigateToExploreChallenges(BuildContext context) {
    context.router.pushNamed('/challenge/admin/explore');
  }
}
