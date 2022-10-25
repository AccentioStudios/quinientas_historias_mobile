import 'package:flutter/material.dart';

import '../../../../core/helpers/secure_storage_helper.dart';
import '../../../../core/integrations/alice_service.dart';
import '../../../../core/integrations/device_info.dart';
import '../../../../core/integrations/platform_environments.dart';
import '../../../../core/routes/routes.dart';

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
            onTap: () => AliceService.instance.showInspector(),
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
    SecureStorageHelper.deleteAll();
    Navigator.of(context, rootNavigator: true)
        .popUntil((route) => route.isFirst);
    Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
  }
}
