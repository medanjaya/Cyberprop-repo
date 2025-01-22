import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationController {
  static Future<void> onNotificationCreatedMethod(
    BuildContext context,ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayMethod(
    BuildContext context,ReceivedNotification receivedNotification) async {}
  
    @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    BuildContext context,ReceivedNotification receivedNotification) async {}

      @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
  BuildContext context, ReceivedAction receivedNotification) async {}
}
