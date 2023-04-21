import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> initAwesomeNotification() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'main_channel',
          channelName: 'Main Channel',
          channelDescription: 'Main channel notifications',
          enableLights: true,
          importance: NotificationImportance.Max,
          playSound: true,
          // icon: "assets/logo.png"
        )
      ],
    );
  }

  Future<void> requestPermission() async {
    AwesomeNotifications().isNotificationAllowed().then((allowed) {
      if (!allowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  Future<void> showNotification(
      int id, String channelKey, String title, String body) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
      ),
    );
  }

  Future<void> showScheduledNotification(
    int id,
    String channelKey,
    String title,
    String body,
    int day,
    int month,
    int year,
    int hour,
    int minute,
    String image
  ) async {
   
    String localTZ = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: channelKey,
          title: title,
          body: body,
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture: image
        ),
        
        schedule: NotificationCalendar(
            hour: hour,
            minute: minute,
            day: day,
            month: month,
            year: year,
            repeats: false),
          
            );

  }
}
