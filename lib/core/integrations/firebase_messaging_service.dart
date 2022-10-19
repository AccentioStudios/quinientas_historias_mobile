import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../libs/custom_notification.dart';
import '../routes/routes.dart';
import 'notification_service.dart';

class FirebaseMessagingService {
  FirebaseMessagingService(this._notificationService);
  final NotificationService _notificationService;

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    _onMessage();
    _onMessageOpenedApp();
  }

  Future<String?> getDeviceFirebaseToken({String? vapidKey}) async {
    final token = await FirebaseMessaging.instance.getToken(vapidKey: vapidKey);
    debugPrint('=======================================');
    debugPrint('TOKEN: $token');
    debugPrint('=======================================');
    return Future.value(token);
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;

      if (notification != null && android != null) {
        _notificationService.showLocalNotification(
          CustomNotification(
            id: android.hashCode,
            title: notification.title ?? '500 Historias',
            body: notification.body!,
            payload: message.data['route'] ?? '',
          ),
        );
      }
      if (notification != null && apple != null) {
        _notificationService.showLocalNotification(
          CustomNotification(
            id: apple.hashCode,
            title: notification.title ?? '500 Historias',
            body: notification.body!,
            payload: message.data['route'] ?? '',
          ),
        );
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    final String route = message.data['route'] ?? '';
    if (route.isNotEmpty) {
      Routes.navigatorKey?.currentState?.pushNamed(route);
    }
  }
}
