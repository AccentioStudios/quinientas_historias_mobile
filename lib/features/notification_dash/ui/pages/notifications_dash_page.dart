import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/integrations/secure_storage_service.dart';
import '../../../../core/integrations/device_info.dart';
import '../../../../core/routes/routes.dart';

class NotificationsDashPage extends StatelessWidget {
  const NotificationsDashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(children: const [
        ListTile(
          title: Text('Notificacion Titulo'),
          subtitle: Text('Notificacion Body'),
        ),
      ]),
    );
  }

  Future<String> getAppVersion() {
    return DeviceInfo().getAppVersion();
  }

  void logout(BuildContext context) {
    GetIt.I<SecureStorageService>().deleteAll();
    Navigator.of(context, rootNavigator: true)
        .popUntil((route) => route.isFirst);
    Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
  }
}
