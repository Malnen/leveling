import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:leveling/push_notification/local_notification_manager.dart';
import 'package:leveling/push_notification/notification_sender.dart';
import 'package:leveling/push_notification/push_notification_manager.dart';
import 'package:leveling/widgets/notification_example.dart';
import 'package:leveling/widgets/stream_builder_example.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationManager.init();
  await LocalNotificationManager.initializePlugin();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leveling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Oj leveling'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = '';
  String body = '';

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      title = message.notification?.title ?? message.data['messageTitle'] ?? '';
      body = message.notification?.body ?? message.data['messageText'] ?? '';
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }

      LocalNotificationManager.showNotification(
        id: title.hashCode.toString(),
        text: body,
        title: title,
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(tabs: <Tab>[
            Tab(text: 'Notifications'),
            Tab(text: 'Stream Builder'),
          ]),
        ),
        body: TabBarView(children: <Widget>[
          NotificationExample(
            title: title,
            body: body,
          ),
          StreamBuilderExample(),
        ]),
      ),
    );
  }
}
