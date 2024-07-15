import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:get/get.dart';
import '/controllers/auth_controller.dart';
import '/helper/route_helper.dart';
import '/services/firebase_service.dart';

class NotificationHelper {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final _analytics = FirebaseAnalytics.instance;
  static final onClickNotification = BehaviorSubject<String>();

  // ontap local notification foreground
  static void onNotification(NotificationResponse notificationResponse) {
    // onClickNotification.add(notificationResponse.input!);
    Get.toNamed(RouteHelper.getMessage(), arguments: notificationResponse);
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
  }

  static Future getDeviceToken() async {
    final token = await _firebaseMessaging.getToken();
    log('device token : $token');
    if (Get.find<AuthController>().user != null) {
      await FirebaseService.saveUserToken(token!);
      log('save to firestore');
    }

    // also save if token changes
    _firebaseMessaging.onTokenRefresh.listen(
      (event) async {
        if (Get.find<AuthController>().user != null) {
          await FirebaseService.saveUserToken(token!);
          log('save to firestore');
        }
      },
    );
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

  // show a simple notifications
  static Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "your channel id",
      "your channel name",
      channelDescription: "your channel description",
      importance: Importance.max,
      priority: Priority.high,
      ticker: "ticker",
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  static Future sendMessage() async {
    await FirebaseMessaging.instance.sendMessage(
      to: "f0b0LVMWTVuPs7FvXxnEhz:APA91bFWGwYsMqP0xpStxf2Wxe-zBk2dBe4A6lwV2VRMx-rOgeDZH7rcxG1WtIo2wW_GI7JVSJuaY-WgyjCFWz4OAxPgsjA10sCPqMHPVPxcxVA09hr6GMLCbPYCJuYIOadqLmFYr1t6",
      data: {
        "hello": "data",
      },
    );
  }
}
