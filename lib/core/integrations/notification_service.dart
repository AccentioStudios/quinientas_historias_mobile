import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../libs/custom_notification.dart';
import '../routes/routes.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;
  late DarwinNotificationDetails iOSDetails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupDetails();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _setupDetails() {
    androidDetails = const AndroidNotificationDetails(
      '500h_notifications',
      '500 Historias Notificaciones',
      channelDescription: 'Canal de notificaciones del app 500 Historias',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );

    iOSDetails = const DarwinNotificationDetails();
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@drawable/ic_notification');
    const iOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    // Fazer: macOs, iOS, Linux...
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
        iOS: iOS,
      ),
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  @pragma('vm:entry-point')
  static notificationTapBackground(NotificationResponse notificationResponse) {
    if (notificationResponse.payload != null) {
      if (notificationResponse.payload!.isNotEmpty) {
        // Navigator.of(Routes.navigatorKey!.currentContext!)
        //     .pushNamed(notificationResponse.payload!);
      }
    }
  }

  showLocalNotification(CustomNotification notification) {
    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
        iOS: iOSDetails,
      ),
      payload: notification.payload,
    );
  }

  checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      if (details.notificationResponse != null) {
        notificationTapBackground(details.notificationResponse!);
      }
    }
  }
}
