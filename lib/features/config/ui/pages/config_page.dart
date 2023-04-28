import 'package:alice_lightweight/alice.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quinientas_historias/core/mixins/bottom_sheet_messages.dart';

import '../../../../core/integrations/secure_storage_service.dart';
import '../../../../core/integrations/device_info.dart';
import '../../../../core/integrations/platform_environments.dart';
import '../../../../core/routes/auto_router.dart';
import '../../../../core/routes/routes.dart';

@RoutePage()
class ConfigPage extends StatelessWidget with SheetMessages {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraciones'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(children: [
        ListTile(
          title: const Text('Versión'),
          subtitle: FutureBuilder(
            future: getAppVersion(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              var data = snapshot.data != null
                  ? 'v${snapshot.data}'
                  : 'No se pudo detectar la versión';
              return Text(data);
            },
          ),
        ),
        if (PlatformEnvironment.env != 'prod')
          ListTile(
            onTap: () => openTestGame(context),
            title: const Text(
              'Minijuego Testing (SAR)',
            ),
            subtitle:
                const Text('Abrir Minijuego para probar capacidades del SAR'),
            trailing: const Icon(Icons.gamepad),
          ),
        if (PlatformEnvironment.env != 'prod')
          ListTile(
            onTap: () => GetIt.I<Alice>().showInspector(),
            title: const Text(
              'Alice (Debug HTTP requests)',
            ),
            subtitle: const Text('Abrir inspector de requests http'),
            trailing: const Icon(Icons.search),
          ),
        ListTile(
          onTap: () => logout(context),
          title: Text(
            'Cerrar sesión',
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }

  openTestGame(BuildContext context) async {
    final challengeResult = await AutoRouter.of(context).push(ChallengesRoute(
      url: 'http://localhost:5500/?userId=1196',
      name: 'Test Game',
      description: 'Test Desc',
      id: '1',
    ));
    if (challengeResult == true) {
      // ignore: use_build_context_synchronously
      showMessage(context,
          title: 'Minijuego testing',
          content:
              'Has completado el minijuego de testing con resultado positivo');
    } else {
      // ignore: use_build_context_synchronously
      showMessage(context,
          title: 'Minijuego testing',
          content:
              'Has completado el minijuego de testing con resultado negativo');
    }
  }

  Future<String> getAppVersion() {
    return DeviceInfo().getAppVersion();
  }

  void logout(BuildContext context) {
    GetIt.I<SecureStorageService>().deleteAll();
    context.router.navigate(AuthRoute());
  }
}
