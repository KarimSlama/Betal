import 'package:Betal/shared/components/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initializeNotification(flutterLocalNotificationsPlugin) async {
    var androidInitialization =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var iosInitialization = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitialization, iOS: iosInitialization);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showNotification(
      {var id = 100,
      required String title,
      required String body,
      DateTime? time,
      required FlutterLocalNotificationsPlugin
          flutterLocalNotificationsPlugin}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'prayer time',
      'prayer time',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('mohamed_marwan'),
      importance: Importance.high,
      priority: Priority.high,
      autoCancel: true,
    );
    var notification = NotificationDetails(
        android: androidNotificationDetails,
        iOS: const DarwinNotificationDetails(sound: 'mohamed_marwan'));
    await flutterLocalNotificationsPlugin.schedule(
        100, title, body, time!, notification);
  }

  static Future scheduleWithNoSoundNotification(
      {var id = 100,
      required String title,
      required String body,
      required DateTime time,
      required FlutterLocalNotificationsPlugin
          flutterLocalNotificationsPlugin}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'prayer_time',
      'prayer_time',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      playSound: false,
      autoCancel: true,
    );
    var notification = NotificationDetails(
        android: androidNotificationDetails,
        iOS: const DarwinNotificationDetails());
    await flutterLocalNotificationsPlugin.schedule(
        100, title, body, time, notification);
  }

  static void stopNotification() async {
    await flutterLocalNotificationsPlugin.cancel(100);
  }
}
