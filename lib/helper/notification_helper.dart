import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationHelper {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final _analytics = FirebaseAnalytics.instance;
  static final onClickNotification = BehaviorSubject<String>();
  static void onNotification(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.input!);
  }

  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    await _analytics.logBeginCheckout();

    final token = await _firebaseMessaging.getToken();
    debugPrint('device token : $token');
  }

  static Future<void> initialize() async {
    var androidInitialize =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    var iosInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    // request notification permission for android 13 or above
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: onNotification,
      onDidReceiveBackgroundNotificationResponse: onNotification,
    );
  }

  static Future<void> showTextNotification(
      String title, String body, String payload) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '6ammart',
      '6ammart',
      // playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      ticker: "ticker",
      // sound: RawResourceAndroidNotificationSound('file_music'),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }
}
