import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../data/api/api_exception.dart';
import '../data/repository/upload_file_repo.dart';
import '../data/models/body/multipart.dart';

class ImageController extends GetxController implements GetxService {
  UploadFileRepo uploadFileRepo;

  ImageController({required this.uploadFileRepo});

  Uint8List? _image;

  Uint8List? get image => _image;

  void uploadImage(MultipartBody multipartBody, String filename) async {
    Response response =
        await uploadFileRepo.uploadFile(multipartBody, filename: filename);

    if (response.statusCode == 200) {
    } else {
      ApiException.checkException(response.statusCode);
    }
  }

  void getImageByName(String filemame) async {
    Response response = await uploadFileRepo.getFileByName(filemame);

    if (response.statusCode == 200) {
      _image = Uint8List.fromList(response.body.codeUnits);
      update();
    } else {
      ApiException.checkException(response.statusCode);
    }
  }

  updateImage(Uint8List image) {
    _image = image;
    update();
  }

  clearImage() {
    _image = null;
    update();
  }
}
