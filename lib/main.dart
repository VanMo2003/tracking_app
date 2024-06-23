import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/app_binding.dart';
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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // if (ResponsiveHelper.isMobilePhone()) {
  //   HttpOverrides.global = MyHttpOverrides();
  // }

  // setPathUrlStrategy();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  try {
    if (GetPlatform.isMobile) {
      await NotificationHelper.init();
      await NotificationHelper.initialize();
      FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
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
