import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/app_binding.dart';
import 'package:traking_app/controllers/langue_controller.dart';
import 'package:traking_app/helper/route_helper.dart';
import 'package:traking_app/services/language_service.dart';
import 'package:traking_app/controllers/theme_controller.dart';

import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'utils/app_constant.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // if (ResponsiveHelper.isMobilePhone()) {
  //   HttpOverrides.global = MyHttpOverrides();
  // }

  // setPathUrlStrategy();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // try {
  //   if (GetPlatform.isMobile) {
  //     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //         FlutterLocalNotificationsPlugin();
  //     await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  //     FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  //   }
  // } catch (e) {}

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
