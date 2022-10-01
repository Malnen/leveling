import 'package:flutter/material.dart';
import 'package:leveling/push_notification/notification_sender.dart';

class NotificationExample extends StatelessWidget {
  final String title;
  final String body;

  const NotificationExample({
    required this.title,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const ElevatedButton(
            child: Text('Send notification'),
            onPressed: NotificationSender.sendNotification,
          ),
          if (title.isNotEmpty) Text('Title: $title'),
          if (body.isNotEmpty) Text('Body: $body'),
        ],
      ),
    );
  }
}
