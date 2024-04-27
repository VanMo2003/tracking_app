import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/loading_controller.dart';
import 'package:traking_app/models/user_model.dart';
import 'package:traking_app/networks/repository/auth_repo.dart';
import 'package:traking_app/networks/response/token_response.dart';
import 'package:flutter/foundation.dart' as Foundation;

import '../helper/snackbar_helper.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  User? _user = null;

  User? get user => _user;

  Future<int> login(String username, String password) async {
    Get.find<LoadingController>().loading();

    Response response = await authRepo.login(username, password);

    if (response.statusCode == 200) {
      TokenResponse tokenResponse = TokenResponse.fromJson(response.body);
      authRepo.saveUserToken(tokenResponse.accessToken!);
    } else {}

    Get.find<LoadingController>().noLoading();
    update();
    return response.statusCode!;
  }

  Future<int> getCurrentUser() async {
    Response response = await authRepo.getCurrentUser();
    if (response.statusCode == 200) {
      _user = User.fromJson(response.body);
    } else if (response.statusCode == 401) {
      clearData();
    } else {
      showCustomSnackBar(response.statusText ?? "error");
    }
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

  void clearData() {
    _user = null;
  }
}
