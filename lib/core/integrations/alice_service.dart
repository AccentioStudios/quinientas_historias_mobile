// Singleton
import 'package:alice_lightweight/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AliceService {
  static final AliceService _instance = AliceService._internal();
  factory AliceService() {
    return _instance;
  }
  AliceService._internal();

  static late final Alice instance;
  static late final FlutterLocalNotificationsPlugin
      flutterLocalNotificationsPlugin;

  late GlobalKey<NavigatorState> navigatorKey;

  static void init(GlobalKey<NavigatorState> navigatorKey) {
    instance = Alice(navigatorKey: navigatorKey);
  }
}
