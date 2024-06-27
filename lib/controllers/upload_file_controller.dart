import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/helper/snackbar_helper.dart';
import 'package:traking_app/networks/repository/upload_file_repo.dart';
import '../models/body/multipart.dart';

class ImageController extends GetxController implements GetxService {
  UploadFileRepo uploadFileRepo;

  ImageController({required this.uploadFileRepo});

  Uint8List? _image;

  Uint8List? get image => _image;

  Future<int> uploadImage(MultipartBody multipartBody, String filename) async {
    Response response =
        await uploadFileRepo.uploadFile(multipartBody, filename: filename);

    if (response.statusCode == 200) {
      debugPrint("upload thành công");
    } else if (response.statusCode == 401) {
      showCustomSnackBar("Không có quyền truy cấp");
    } else {
      showCustomSnackBar("Lỗi k xác định");
    }

    return response.statusCode!;
  }

  Future<int> getImageByName(String filemame) async {
    Response response = await uploadFileRepo.getFileByName(filemame);

    if (response.statusCode == 200) {
      debugPrint('get thành công');
      _image = Uint8List.fromList(response.body.codeUnits);
      update();
    } else if (response.statusCode == 401) {
      showCustomSnackBar("Không có quyền truy cấp");
    } else {
      showCustomSnackBar("Lỗi k xác định");
    }

    return response.statusCode!;
  }

  updateImage(Uint8List image) {
    _image = image;
    update();
  }

  clearImage() {
    debugPrint('clear image');
    _image = null;
    update();
  }
}
