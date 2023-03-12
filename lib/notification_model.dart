import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'Prayer_Time',
          channelName: 'Prayer_Time',
          channelDescription: 'prayer time for the current prayer...',
          importance: NotificationImportance.Max,
          onlyAlertOnce: true,
        ),
      ],
      debug: true,
    );
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    required TimeOfDay time,
  }) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'Prayer_Time',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        repeats: true,
        hour: time.hour,
        millisecond: 0,
        second: 0,
        minute: time.minute,
      ),
    );
  }

  static Future<void> showAlertOnlyNotification({
    required final String title,
    required final String body,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 0,
          channelKey: 'Prayer_Time',
          title: title,
          body: body,
          notificationLayout: notificationLayout,
        ),
        schedule: scheduled
            ? NotificationInterval(
                interval: interval,
                timeZone:
                    await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                preciseAlarm: true)
            : null);
  }

  static void stopNotification() async {
    await AwesomeNotifications().cancel(0);
  }
}

// import 'package:Betal/main.dart';
// import 'package:Betal/shared/components/constants.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationModel {
//   static Future initializeNotification(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialization =
//         const AndroidInitializationSettings('mipmap/ic_launcher');
//     var iosInitialization = const DarwinInitializationSettings();
//     var initializationSettings = InitializationSettings(
//         android: androidInitialization, iOS: iosInitialization);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   static Future showNotification(
//       {var id = 0,
//       required String title,
//       required String body,
//       required String prayer,
//       required FlutterLocalNotificationsPlugin
//           flutterLocalNotificationsPlugin}) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'Prayer Time $prayer',
//       'prayer time',
//       playSound: false,
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//     var notification = NotificationDetails(
//         android: androidNotificationDetails,
//         iOS: const DarwinNotificationDetails());
//     await flutterLocalNotificationsPlugin.show(0, title, body, notification);
//   }

//   static Future scheduleNotification(
//       {var id = 0,
//       required String title,
//       required String body,
//       required FlutterLocalNotificationsPlugin
//           flutterLocalNotificationsPlugin}) async {
//     const sound = 'ahmed_alnafis.mp3';
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'Prayer Time',
//       'prayer time',
//       playSound: true,
//       importance: Importance.high,
//       priority: Priority.max,
//       sound: RawResourceAndroidNotificationSound(sound.split('.').first),
//     );
//     var notification = NotificationDetails(
//         android: androidNotificationDetails,
//         iOS: const DarwinNotificationDetails(sound: sound));
//     await flutterLocalNotificationsPlugin.periodicallyShow(
//       0,
//       title,
//       body,
//       RepeatInterval.everyMinute,
//
//       ///it doesn't work as you want...........
//       notification,
//     );
//   }
//
//   static Future scheduleWithNoSoundNotification(
//       {var id = 0,
//       required String title,
//       required String body,
//       required FlutterLocalNotificationsPlugin
//           flutterLocalNotificationsPlugin}) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         const AndroidNotificationDetails(
//       'Prayer Time',
//       'prayer time',
//       playSound: false,
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//     var notification = NotificationDetails(
//         android: androidNotificationDetails,
//         iOS: const DarwinNotificationDetails());
//     await flutterLocalNotificationsPlugin.periodicallyShow(
//       0,
//       title,
//       body,
//       RepeatInterval.everyMinute,
//       notification,
//     );
//   }
//
//   static void stopNotification() async {
//     await flutterLocalNotificationsPlugin.cancel(0);
//   }
// }
