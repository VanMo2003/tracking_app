import 'dart:io';

import 'package:get/get.dart';

import 'package:traking_app/networks/api/api_client.dart';
import 'package:traking_app/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/body/multipart.dart';

class UploadFileRepo {
  ApiClient apiClient;
  SharedPreferences sharedPreferences;

  UploadFileRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> uploadFile(MultipartBody multipartBody,
      {String? filename}) async {
    String token = sharedPreferences.getString(AppConstant.TOKEN) ??
        "Basic Y29yZV9jbGllbnQ6c2VjcmV0";
    Map<String, String> header = {
      "Content-Type": "multipart/form-data",
      "Authorization": token,
    };
    return await apiClient.postMultipartData(
      AppConstant.UPLOAD_FILE,
      multipartBody,
      headers: header,
      filename: filename,
    );
  }

  Future<Response> getFileByName(String filename) async {
    return await apiClient.getData(
      "${AppConstant.GET_FILE_BY_NAME}/$filename",
    );
  }
}
