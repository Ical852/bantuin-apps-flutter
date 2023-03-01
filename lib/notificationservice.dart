import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
    );

    @pragma('vm:entry-point')
    void notificationTapBackground(NotificationResponse notificationResponse) {
      // ignore: avoid_print
      print('notification(${notificationResponse.id}) action tapped: '
          '${notificationResponse.actionId} with'
          ' payload: ${notificationResponse.payload}');
      if (notificationResponse.input?.isNotEmpty ?? false) {
        // ignore: avoid_print
        print(
            'notification action tapped with input: ${notificationResponse.input}');
      }
    }

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "channel_id_5",
      "channel",
      enableLights: true,
      enableVibration: true,
      priority: Priority.high,
      importance: Importance.max,
      styleInformation: MediaStyleInformation(
        htmlFormatContent: true,
        htmlFormatTitle: true,
      ),
      icon: '@mipmap/ic_launcher',
      playSound: true,
    );

    await _flutterLocalNotificationsPlugin.show(
        message.data.hashCode,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          android: androidDetails,
        ));
  }
}