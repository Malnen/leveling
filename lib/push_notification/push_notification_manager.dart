
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager {
  static late String fcmToken;

  static Future<void> init() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }
}
