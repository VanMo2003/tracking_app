import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/loading_helper.dart';
import '../screens/widgets/dialog_widget.dart';
import '../views/custom_snackbar.dart';
import '/controllers/loading_controller.dart';
import '/controllers/post_controller.dart';
import '/controllers/search_controller.dart';
import '../data/models/body/user.dart';
import '../data/models/response/user_res.dart';
import '../data/api/api_exception.dart';
import '../data/repository/auth_repo.dart';
import '../data/models/response/token_res.dart';
import '/utils/language/key_language.dart';

import '../helper/date_converter_hepler.dart';
import '../helper/route_helper.dart';
import '../services/firebase_service.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo}) : _user = UserRes();

  UserRes? _user;
  bool _isAdmin = false;

  UserRes? get user => _user;
  bool get isAdmin => _isAdmin;

  Future<int> login(String username, String password) async {
    Get.find<LoadingController>().loading();

    Response response = await authRepo.login(username, password);

    if (response.statusCode == 200) {
      TokenResponse tokenResponse = TokenResponse.fromJson(response.body);
      authRepo.saveUserToken(tokenResponse.accessToken!);
    } else {
      ApiException.checkException(response.statusCode);
    }

    Get.find<LoadingController>().noLoading();
    update();
    return response.statusCode!;
  }

  Future<int> registor(User user) async {
    Response response = await authRepo.registor(user);

    if (response.statusCode == 200) {
      _user = UserRes.fromJson(response.body);
    } else {
      ApiException.checkException(response.statusCode);
    }
    update();
    return response.statusCode!;
  }

  Future<int> getCurrentUser() async {
    Response response = await authRepo.getCurrentUser();
    if (response.statusCode == 200) {
      _user = UserRes.fromJson(response.body);
      if (_user!.roles != null) {
        for (var element in _user!.roles!) {
          if (element.id == 3) {
            _isAdmin = true;
          }
        }
      }
    } else {
      ApiException.checkException(response.statusCode);
    }
    update();
    return response.statusCode!;
  }

  Future<int> updateMyself(UserRes userNew) async {
    Response response = await authRepo.updateMyself(userNew);
    if (response.statusCode == 200) {
      _user = UserRes.fromJson(response.body);
      Get.find<PostController>().clearData();
    } else {
      ApiException.checkException(response.statusCode);
    }
    update();
    return response.statusCode!;
  }

  void updateInfoUser(UserRes userNew) async {
    Response response = await authRepo.updateUserById(userNew);
    if (response.statusCode == 200) {
      if (Get.find<SearchByPageController>().listResult != null) {
        for (var element in Get.find<SearchByPageController>().listResult!) {
          if (element.id == userNew.id) {
            int index =
                Get.find<SearchByPageController>().listResult!.indexOf(element);
            Get.find<SearchByPageController>()
              ..listResult![index] = userNew
              ..update();
            showCustomSnackBar(KeyLanguage.updateSuccess.tr, isError: false);
          }
        }
      }
    } else {
      ApiException.checkException(response.statusCode);
    }
    update();
  }

  Future<void> checkIn() async {
    Response response = await authRepo.checkIn(_user!.id.toString());
    if (response.statusCode == 200) {
      showCustomSnackBar(
        "${KeyLanguage.attendanceSuccess.tr} : ${DateConverter.formatDate(DateTime.now())}",
        isError: false,
      );
    } else {
      ApiException.checkException(response.statusCode,
          err: KeyLanguage.attendanced.tr);
    }
    update();
  }

  void logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return dialogQuestionWidget(
          context,
          KeyLanguage.logout.tr,
          KeyLanguage.logoutQuestion.tr,
          () async {
            await animatedLoading();
            Response response = await authRepo.logout();
            if (response.statusCode == 200) {
              authRepo.removeUserToken();
              FirebaseService.removeCurrentUserToken();
              clearData();
              update();
              Get.offNamed(RouteHelper.getSignInRoute());
            } else {
              ApiException.checkException(response.statusCode);
            }
            animatedNoLoading();
          },
        );
      },
    );
  }

  Future<int> lock(int id) async {
    Response response = await authRepo.lock(id);
    if (response.statusCode == 200) {
      Get.find<SearchByPageController>()
        ..listResult!.where((element) => element.id == id).first.active = false
        ..update();
    } else {
      ApiException.checkException(response.statusCode);
    }
    update();
    return response.statusCode!;
  }

  void clearData() {
    _user = UserRes();
    _isAdmin = false;
  }
}
