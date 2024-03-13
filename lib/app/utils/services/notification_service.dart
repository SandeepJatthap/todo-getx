import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as timezone;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> showNotification(int id, String title, String description,
      DateTime dateTime, Color priority, int remindIn) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      description,
      timezone.TZDateTime.from(dateTime, timezone.local).add(
        Duration(minutes: remindIn),
      ),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'todo channel',
          'todo channel',
          channelDescription: "todo reminder",
          playSound: true,
          color: priority,
          icon: '@mipmap/ic_launcher',
          importance: Importance.max,
          priority: Priority.max,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> cancelNotitication(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
