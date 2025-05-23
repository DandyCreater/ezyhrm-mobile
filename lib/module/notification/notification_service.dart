import 'dart:developer';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static NotificationService instance = NotificationService._();
  NotificationService._();
  factory NotificationService() => instance;

  static final _apiKey = "NGRiYjVhY2YtY2VjYy00MzliLWE4OGMtYzdmZjZiYzc3OTM4";
  static final _appId = "bc30eb66-43b3-4b60-9a6d-27e8912002c2";

  static Future<void> init() async {
    final notifIsDenied = await Permission.notification.isDenied;

    if (notifIsDenied) {
      log('request notification permission');
      final req = await Permission.notification.request();
      log('permission is enable=${req.isGranted}');
    }

    OneSignal.initialize(_appId);
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
    OneSignal.Notifications.addPermissionObserver((state) {
      log("push notif permission: $state");
    });
  }

  Future<void> setExternalUserId(String insatance, String userId) async {
    log('setExternalUserId: $insatance-$userId');
    await OneSignal.login("$insatance-$userId");
  }

  Future<void> removeExternalUserId() async {
    await OneSignal.logout();
  }
}
