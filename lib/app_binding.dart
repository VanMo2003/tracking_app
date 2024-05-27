import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/controllers/langue_controller.dart';
import 'package:traking_app/controllers/loading_controller.dart';
import 'package:traking_app/controllers/search_controller.dart';
import 'package:traking_app/controllers/tracking_controller.dart';
import 'package:traking_app/networks/api/api_client.dart';
import 'package:traking_app/networks/repository/auth_repo.dart';
import 'package:traking_app/networks/repository/search_repo.dart';
import 'package:traking_app/networks/repository/tracking_repo.dart';
import 'package:traking_app/services/language_service.dart';
import 'package:traking_app/controllers/theme_controller.dart';
import 'package:traking_app/utils/app_constant.dart';
import 'controllers/splash_controller.dart';

// class AppBinding extends Bindings {
//   @override
//   Future<void> dependencies() async {
//     final sharedPreferences = await SharedPreferences.getInstance();

//     Get.lazyPut(() => sharedPreferences);
//     Get.lazyPut(() => SplashController());
//     Get.lazyPut(() => LanguageService());
//     Get.lazyPut(() => ApiClient(
//         urlBase: AppConstant.BASE_URL, sharedPreferences: sharedPreferences));
//     Get.lazyPut(() =>
//         AuthRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
//     Get.lazyPut(() => AuthController(authRepo: Get.find()));
//     Get.lazyPut(() => LoadingController());
//   }
// }

Future<void> binding() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => LanguageService());
  Get.lazyPut(() =>
      ApiClient(urlBase: AppConstant.BASE_URL, sharedPreferences: Get.find()));

  // repository
  Get.lazyPut(
    () => AuthRepo(
      apiClient: Get.find(),
      sharedPreferences: Get.find(),
    ),
  );

  Get.lazyPut(
    () => TrackingRepo(
      apiClient: Get.find(),
      sharedPreferences: Get.find(),
    ),
  );
  Get.lazyPut(
    () => SearchRepo(
      apiClient: Get.find(),
    ),
  );

  // controller
  Get.lazyPut(() => SplashController());

  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));

  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));

  Get.lazyPut(() => LoadingController());

  Get.lazyPut(() => AuthController(authRepo: Get.find()));

  Get.lazyPut(() => TrackingController(trackingRepo: Get.find()));

  Get.lazyPut(() => SearchByPageController(searchRepo: Get.find()));
}
