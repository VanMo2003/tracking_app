import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:traking_app/app_binding.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:traking_app/controllers/langue_controller.dart';
import 'package:traking_app/helper/route_helper.dart';
import 'package:traking_app/services/language_service.dart';
import 'package:traking_app/controllers/theme_controller.dart';

import 'firebase_options.dart';
import 'helper/notification_helper.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'utils/app_constant.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    debugPrint('some notification Received in Background');
  }
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (GetPlatform.isMobile) {
    HttpOverrides.global = MyHttpOverrides();
  }

  try {
    if (GetPlatform.isMobile) {
      await NotificationHelper.init();
      await NotificationHelper.initialize();
      FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(
        (message) {
          debugPrint('to message : $message');
          Get.toNamed(RouteHelper.getMessage(), arguments: message);
        },
      );

      FirebaseMessaging.onMessage.listen(
        (message) {
          String payloadData = jsonEncode(message.data);
          debugPrint('got a message in foreground');
          if (message.notification != null) {
            NotificationHelper.showSimpleNotification(
              title: message.notification!.title!,
              body: message.notification!.body!,
              payload: payloadData,
            );
          }
        },
      );

      //handle in terminated state
      final RemoteMessage? message =
          await FirebaseMessaging.instance.getInitialMessage();
      if (message != null) {
        debugPrint('launched from terminated state');
        Future.delayed(
          Duration(seconds: 1),
          () {
            Get.toNamed(RouteHelper.getMessage(), arguments: message);
          },
        );
      }
    }
  } catch (e) {}

  await binding();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LanguageController>(
          builder: (languageController) {
            FlutterNativeSplash.remove();
            return GetMaterialApp(
              enableLog: true,
              debugShowCheckedModeBanner: false,
              title: AppConstant.APP_NAME,
              navigatorKey: Get.key,
              theme: themeController.darkTheme ? dark() : light(),
              themeMode: ThemeMode.system,
              locale: LanguageService.locale,
              fallbackLocale: LanguageService.fallbackLocale,
              translations: LanguageService(),
              initialRoute: RouteHelper.getSplashRoute(),
              getPages: RouteHelper.routes,
              defaultTransition: Transition.topLevel,
              transitionDuration: const Duration(milliseconds: 250),
            );
          },
        );
      },
    );
  }
}

/// hàm callback được cung cấp luôn trả về true,
/// thực sự bỏ qua mọi lỗi xác thực chứng chỉ.
/// Điều này thường được sử dụng trong quá trình phát triển để cho phép kết nối với các máy chủ có chứng chỉ tự ký,
/// vốn không được tin cậy mặc định vì lý do bảo mật
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
