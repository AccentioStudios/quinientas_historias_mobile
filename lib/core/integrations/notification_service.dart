import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../libs/custom_notification.dart';
import '../routes/routes.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;
  late DarwinNotificationDetails iOSDetails;

  NotificationService(BuildContext context) {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();

    localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    _setupDetails();
    _setupNotifications(context);
  }

  _setupNotifications(BuildContext context) async {
    await _setupTimezone();
    if (context.mounted) {
      await _initializeNotifications(context);
    }
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

  _initializeNotifications(BuildContext context) async {
    const android = AndroidInitializationSettings('@drawable/ic_notification');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const pinguino =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    // Fazer: macOs, iOS, Linux...
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
        iOS: darwin,
        macOS: darwin,
        linux: pinguino,
      ),
      onDidReceiveNotificationResponse: (notificationResponse) =>
          onDidReceiveNotificationResponse(context, notificationResponse),
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  void onDidReceiveNotificationResponse(
      BuildContext context, NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;

    if (payload != null) {
      // Convert string to map
      final Map<String, dynamic> payloadData = jsonDecode(payload);
      debugPrint('notification payload: $payloadData');
      if (payloadData.isNotEmpty) {
        if (payloadData.containsKey('route')) {
          if (Routes.shellNavigatorKey != null) {
            Navigator.of(
              Routes.shellNavigatorKey!.currentContext!,
            ).pushNamed(payloadData['route'], arguments: payloadData['args']);
          }
        }
      }
    }
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;

    if (payload != null) {
      // Convert string to map
      final Map<String, dynamic> payloadData = jsonDecode(payload);
      debugPrint('notification payload: $payloadData');
      if (payloadData.isNotEmpty) {
        if (payloadData.containsKey('route')) {
          if (Routes.shellNavigatorKey != null) {
            Navigator.of(
              Routes.shellNavigatorKey!.currentContext!,
            ).pushNamed(payloadData['route']);
          }
        }
      }
    }
  }

  showLocalNotification(CustomNotification notification) {
    // convert map to string
    final String payload = jsonEncode(notification.payload);

    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
        iOS: iOSDetails,
      ),
      payload: payload,
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
