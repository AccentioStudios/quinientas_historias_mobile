import 'package:alice_lightweight/alice.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/integrations/secure_storage_service.dart';
import '../../../../core/integrations/device_info.dart';
import '../../../../core/integrations/platform_environments.dart';
import '../../../../core/routes/auto_router.dart';

@RoutePage()
class ConfigPage extends StatelessWidget {
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
            onTap: () => GetIt.I<Alice>().showInspector(),
            title: const Text(
              'Abrir Alice (Debug HTTP requests)',
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

  Future<String> getAppVersion() {
    return DeviceInfo().getAppVersion();
  }

  void logout(BuildContext context) {
    GetIt.I<SecureStorageService>().deleteAll();
    context.router.navigate(AuthRoute());
  }
}
