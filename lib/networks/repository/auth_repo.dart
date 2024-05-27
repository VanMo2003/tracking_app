import 'package:shared_preferences/shared_preferences.dart';
import 'package:traking_app/models/body/search_body.dart';
import 'package:traking_app/models/request/token_request.dart';
import 'package:traking_app/models/body/user_body.dart';
import 'package:traking_app/models/response/user_res.dart';
import 'package:traking_app/networks/api/api_client.dart';
import 'package:traking_app/utils/app_constant.dart';
import 'package:get/get.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login(String username, String password) async {
    var token = "Basic Y29yZV9jbGllbnQ6c2VjcmV0";
    var languageCode = sharedPreferences.getString(AppConstant.LANGUAGE_CODE);

    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded",
      AppConstant.LOCALIZATION_KEY: languageCode ?? 'vi',
      "Authorization": token,
    };

    return await apiClient.postDataLogin(
      AppConstant.LOGIN_URI,
      TokenRequest(
        username: username,
        password: password,
        clientId: "core_client",
        clientSecret: "secret",
        grantType: "password",
      ).toJson(),
      header,
    );
  }

  Future<Response> registor(UserBody user) async {
    return await apiClient.postData(AppConstant.REGISTOR_URI, user.toJson());
  }

  Future<Response> getCurrentUser() async {
    return await apiClient.getData(AppConstant.GET_USER);
  }

  Future<Response> changeInfoUser(UserRes user) async {
    return await apiClient.postData(AppConstant.UPDATE_MYSELF, user);
  }

  Future<Response> logout() async {
    return await apiClient.deleteData(AppConstant.LOG_OUT);
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = "Bearer $token";
    apiClient.updateHeader("Bearer $token", null,
        sharedPreferences.getString(AppConstant.LANGUAGE_CODE) ?? "vi", 0);
    return await sharedPreferences.setString(
        AppConstant.TOKEN, "Bearer $token");
  }

  Future<bool> removeUserToken() async {
    return await sharedPreferences.remove(AppConstant.TOKEN);
  }
}
