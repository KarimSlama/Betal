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
      'prayer time is coming',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('ahmed_alnafis'),
      importance: Importance.max,
    );
    var notification = NotificationDetails(
        android: androidNotificationDetails,
        iOS: const DarwinNotificationDetails(sound: 'ahmed_alnafis.caf'));
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
      'Prayer Time',
      'prayer time',
      playSound: false,
      importance: Importance.high,
      priority: Priority.high,
    );
    var notification = NotificationDetails(
        android: androidNotificationDetails,
        iOS: const DarwinNotificationDetails(sound: 'ahmed_alnafis.caf'));
    await flutterLocalNotificationsPlugin.schedule(
        100, title, body, time, notification);
  }

  static void stopNotification() async {
    await flutterLocalNotificationsPlugin.cancel(100);
  }
}
