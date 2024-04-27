import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/controllers/loading_controller.dart';
import 'package:traking_app/networks/api/api_client.dart';
import 'package:traking_app/networks/repository/auth_repo.dart';
import 'package:traking_app/services/language_service.dart';
import 'package:traking_app/utils/app_constant.dart';
import 'controllers/splash_controller.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut(() => SplashController());

    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => LanguageService());
    Get.lazyPut(() => ApiClient(
        urlBase: AppConstant.BASE_URL, sharedPreferences: sharedPreferences));
    Get.lazyPut(() =>
        AuthRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
    Get.lazyPut(() => AuthController(authRepo: Get.find()));
    Get.lazyPut(() => LoadingController());
  }
}
