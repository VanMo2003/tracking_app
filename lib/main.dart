import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/app_binding.dart';
import 'package:traking_app/helper/route_helper.dart';
import 'package:traking_app/services/language_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      debugShowCheckedModeBanner: false,
      title: "Tracking App",
      navigatorKey: Get.key,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      locale: LanguageService.locale,
      fallbackLocale: LanguageService.fallbackLocale,
      translations: LanguageService(),
      initialRoute: RouteHelper.getSplashRoute(),
      getPages: RouteHelper.routes,
      initialBinding: AppBinding(),
    );
  }
}
