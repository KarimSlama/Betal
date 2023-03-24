import 'package:Betal/shared/components/constants.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class PrayerNotification {
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelKey: 'prayer time',
            channelName: 'prayer time',
            channelDescription: 'Notification tests as alerts',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
            defaultColor: Colors.deepPurple,
            ledColor: Colors.deepPurple,
            soundSource: selectedSound != null
                ? '$selectedSound'
                : 'resource://raw/mohamed_marwan',
          )
        ],
        debug: true);
  }

  static Future<void> showTestNotification(title, body) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'prayer time',
        title: title,
        body: '$body',
        autoDismissible: true,
        displayOnBackground: true,
        displayOnForeground: true,
      ),
    );
  }

  static Future<void> createNotification(title, body, hour, minute) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'prayer time',
          title: '$title',
          body: '$body',
          autoDismissible: true,
          displayOnBackground: true,
          displayOnForeground: true,
        ),
        schedule: NotificationCalendar(
          repeats: true,
          hour: hour,
          minute: minute,
          second: 0,
          millisecond: 0,
        ));
  }

  static Future<void> createAlertNotification(title, body, hour, minute) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'prayer time',
        title: title,
        body: '$body',
        autoDismissible: true,
        displayOnBackground: true,
        displayOnForeground: true,
      ),
      schedule: NotificationCalendar(
        repeats: true,
        hour: hour,
        minute: minute,
        second: 0,
        millisecond: 0,
      ),
    );
  }

  static Future<void> cancelNotification() async {
    await AwesomeNotifications().cancelAll();
  }
}
