import 'package:flutter/material.dart';

import '../../../../core/helpers/secure_storage_helper.dart';
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
      body: ListView(children: [
        ListTile(
          title: const Text('Notificacion Titulo'),
          subtitle: Text('Notificacion Body'),
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
