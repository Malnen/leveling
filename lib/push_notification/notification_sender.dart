import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:leveling/push_notification/push_notification_manager.dart';

class NotificationSender {
  static Future<void> sendNotification() async {
    final Uri uri = Uri.parse('http://172.20.2.3:9970/sendNotification');

    Map<String, Object> body = {
      'token': PushNotificationManager.fcmToken,
      'data': <String,String> {
        'imageUrl': 'https://i.ytimg.com/vi/6HRyUiYthAk/maxresdefault.jpg',
        'messageText': 'Skonfigurowałeś już te powiadomienia?',
        'messageTitle': 'Jak tam chłopie'
      }
    };

    final encoding = Encoding.getByName('utf-8');
    final header = {'Content-Type': 'application/json'};

    await http.post(
      uri,
      headers: header,
      body: jsonEncode(body),
      encoding: encoding,
    );
  }
}
