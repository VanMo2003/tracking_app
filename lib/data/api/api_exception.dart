import 'package:get/get.dart';
import '/controllers/auth_controller.dart';
import '/helper/route_helper.dart';
import '../../views/custom_snackbar.dart';
import '/utils/language/key_language.dart';

class ApiException {
  static void checkException(int? statusCode, {String? err}) {
    if (statusCode == 401) {
      Get.find<AuthController>().clearData();
      Get.offAllNamed(RouteHelper.signIn);
      showCustomSnackBar(KeyLanguage.errorUnauthentication.tr);
    } else if (statusCode == 400) {
      showCustomSnackBar(KeyLanguage.errorWrongUsernameOrPassword.tr);
    } else {
      showCustomSnackBar(
        err ?? KeyLanguage.errorServer.tr,
        duration: err == null ? 10 : null,
      );
    }
  }
}
