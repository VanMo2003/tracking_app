import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/loading_controller.dart';
import 'package:traking_app/controllers/search_controller.dart';
import 'package:traking_app/controllers/tracking_controller.dart';
import 'package:traking_app/helper/date_converter.dart';
import 'package:traking_app/models/body/user.dart';
import 'package:traking_app/models/response/user_res.dart';
import 'package:traking_app/networks/repository/auth_repo.dart';
import 'package:traking_app/models/response/token_response.dart';
import 'package:traking_app/utils/language/key_language.dart';

import '../helper/snackbar_helper.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo}) : _user = UserRes();

  UserRes? _user;

  UserRes? get user => _user;

  Future<int> login(String username, String password) async {
    Get.find<LoadingController>().loading();

    Response response = await authRepo.login(username, password);

    if (response.statusCode == 200) {
      TokenResponse tokenResponse = TokenResponse.fromJson(response.body);

      authRepo.saveUserToken(tokenResponse.accessToken!);
    } else {
      authRepo.removeUserToken();
    }

    Get.find<LoadingController>().noLoading();
    update();
    return response.statusCode!;
  }

  Future<int> registor(User user) async {
    Response response = await authRepo.registor(user);

    if (response.statusCode == 200) {
      debugPrint('Đăng ký thành công');
    } else {
      debugPrint('Tài khoản đã tồn tại');
    }
    update();
    return response.statusCode!;
  }

  Future<int> getCurrentUser() async {
    Response response = await authRepo.getCurrentUser();
    if (response.statusCode == 200) {
      _user = UserRes.fromJson(response.body);
    } else if (response.statusCode == 401) {
      clearData();
    } else {
      // showCustomSnackBar("Đã xảy ra lỗi không xác định");
    }
    update();
    return response.statusCode!;
  }

  Future<int> changeInfoUser(UserRes userNew) async {
    Response response = await authRepo.changeInfoUser(userNew);
    if (response.statusCode == 200) {
      _user = UserRes.fromJson(response.body);
    } else if (response.statusCode == 401) {
      clearData();
    } else {
      showCustomSnackBar(KeyLanguage.errorAnUnknow.tr);
    }
    update();
    return response.statusCode!;
  }

  Future<int> checkIn() async {
    Response response = await authRepo.checkIn(_user!.id.toString());
    if (response.statusCode == 200) {
      showCustomSnackBar(
        "${KeyLanguage.attendanceSuccess.tr} : ${DateConverter.formatDate(DateTime.now())}",
        isError: false,
      );
    } else if (response.statusCode == 500) {
      clearData();
    } else {
      showCustomSnackBar(KeyLanguage.attendanced.tr);
    }
    update();
    return response.statusCode!;
  }

  Future<int> logout() async {
    Response response = await authRepo.logout();
    if (response.statusCode == 200) {
      authRepo.removeUserToken();
    } else if (response.statusCode == 401) {
      clearData();
    } else {}
    update();
    return response.statusCode!;
  }

  void clearData() {
    _user = null;
  }
}
