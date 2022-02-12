import 'package:employee/core/notification_api.dart';
import 'package:employee/feature/presentation/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  initialization().then((value) => runApp(MyApp()));
}

onSelectNotification(String? payload) {
  print("fcm onSelecteNotificaiton");
  // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //   return NewScreen(
  //     payload: payload,
  //   );
  // }));
}

Future initialization() async {
// init of notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('flutter_devs');
  var initializationSettingsIOs = IOSInitializationSettings();
  var initSetttings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

  flutterLocalNotificationsPlugin.initialize(initSetttings,
      onSelectNotification: onSelectNotification);
  ////end of local notification

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  var fcmToken = await messaging.getToken();
  print("fcmToken : " + fcmToken.toString());

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      makeNotification(message);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.data.toString()}");
  makeNotification(message);
}

//making the notificaiton in both the cases.
makeNotification(RemoteMessage message) async {
  NotificationApi.init();
  NotificationApi.showNotification(
      id: 1,
      title: message.notification?.title!,
      body: "",
      payload: " my payload");
  NotificationApi.onNotification.stream.listen((payload) {
    print("fcm onclick on the notification");
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home: ApprovalScreen(),
      builder: EasyLoading.init(),
    );
  }
}
