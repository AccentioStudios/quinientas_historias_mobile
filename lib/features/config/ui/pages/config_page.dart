import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/integrations/device_info.dart';
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
    const secureStorage = FlutterSecureStorage();
    secureStorage.deleteAll();
    Navigator.of(context, rootNavigator: true)
        .popUntil((route) => route.isFirst);
    Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
  }
}
