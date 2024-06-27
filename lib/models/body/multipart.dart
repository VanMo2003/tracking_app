import 'dart:io';

class MultipartBody {
  String key;
  File? file;

  MultipartBody({this.key = "uploadfile", required this.file});
}
