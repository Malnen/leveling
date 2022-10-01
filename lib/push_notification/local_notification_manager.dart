import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationManager {
  static late FlutterLocalNotificationsPlugin _notifier = FlutterLocalNotificationsPlugin();

  static Future<void> initializePlugin() async {
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('notification_icon'),
    );

    _notifier = FlutterLocalNotificationsPlugin();
    await _notifier.initialize(
      initializationSettings,
    );
  }

  static Future<void> showNotification({
    required String id,
    String? title,
    String? text,
    String? payload,
  }) async {
    await _notifier.show(
      id.hashCode,
      title,
      text,
      _notificationDetails(text),
      payload: payload,
    );
  }

  static NotificationDetails _notificationDetails(String? text) {
    AndroidNotificationDetails? androidConfig;
    if (text != null) {
      androidConfig = AndroidNotificationDetails(
        'leveling id',
        'leveling name',
        importance: Importance.max,
        priority: Priority.max,
        showWhen: true,
        styleInformation: BigTextStyleInformation(text),
      );
    }

    return NotificationDetails(
      android: androidConfig,
    );
  }
}
