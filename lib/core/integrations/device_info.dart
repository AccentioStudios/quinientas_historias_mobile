import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../helpers/device_info_helper.dart';

class DeviceInfo implements DeviceInfoHelper {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  @override
  Future<String> getDeviceName() async {
    try {
      if (kIsWeb) {
        final WebBrowserInfo webBrowserInfo = await _deviceInfo.webBrowserInfo;
        return webBrowserInfo.userAgent ?? '';
      }
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        return androidInfo.model ?? '';
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.utsname.machine ?? '';
      }
    } on PlatformException {
      return 'Invalid PlatformException';
    }
    return 'Invalid PlatformException';
  }

  @override
  Future<String> getAppVersion() async {
    try {
      return (await PackageInfo.fromPlatform()).version;
    } on PlatformException {
      return 'Invalid PlatformException';
    }
  }

  @override
  Future<String> getBuildNumber() async {
    try {
      return (await PackageInfo.fromPlatform()).buildNumber;
    } on PlatformException {
      return 'Invalid PlatformException';
    }
  }
}
