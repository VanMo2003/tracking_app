import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/views/screens/home_user/post/widget/button_add_post_widget.dart';
import 'package:traking_app/views/widgets/loading_widget.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/post_controller.dart';
import '../../../../controllers/upload_file_controller.dart';
import '../../../../helper/loading_helper.dart';
import '../../../../helper/snackbar_helper.dart';
import '../../../../models/body/multipart.dart';
import '../../../../models/body/posts/content.dart';
import '../../../../models/body/posts/media.dart';
import '../../../../utils/dimensions.dart';
import '../../../widgets/text_field_widget.dart';

class AddPostScreent extends StatefulWidget {
  const AddPostScreent({super.key});

  @override
  State<AddPostScreent> createState() => _AddPostScreentState();
}

class _AddPostScreentState extends State<AddPostScreent> {
  final TextEditingController contentController = TextEditingController();
  File? selectedFile;
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    Get.find<ImageController>().clearImage();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(KeyLanguage.addPost.tr),
          centerTitle: true,
        ),
        body: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldWidget(
                    autoFocus: true,
                    controller: contentController,
                    hintText: KeyLanguage.postContent.tr,
                  ),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  GetBuilder<ImageController>(
                    builder: (controller) {
                      if (controller.image == null) {
                        return GestureDetector(
                          onTap: () {
                            _pickImageFromGallery();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.image,
                                size: 32,
                              ),
                              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                              Text("Chọn ảnh"),
                            ],
                          ),
                        );
                      }
                      return GestureDetector(
                          onTap: () {
                            _pickImageFromGallery();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(controller.image!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ButtonAddPostWidget(
                        label: KeyLanguage.addPost.tr,
                        onPressed: () {
                          addPost();
                        },
                      ),
                      const SizedBox(
                        width: Dimensions.PADDING_SIZE_LARGE,
                      ),
                      ButtonAddPostWidget(
                        label: KeyLanguage.cancel.tr,
                        onPressed: () {
                          if (Get.find<ImageController>().image != null) {
                            Get.find<ImageController>().clearImage();
                          }
                          contentController.clear();
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addPost() async {
    if (key.currentState!.validate()) {
      await animatedLoading();

      late Content content;
      if (selectedFile != null) {
        String filename = "${Timestamp.fromDate(DateTime.now()).seconds}.png";
        content = Content(
          id: 0,
          date: DateTime.now().millisecondsSinceEpoch,
          content: contentController.text,
          user: Get.find<AuthController>().user,
          media: Media(
            id: 0,
            contentSize: 0,
            contentType: "string",
            extension: "string",
            filePath: "string",
            isVideo: true,
            name: filename,
          ),
        );

        Get.find<ImageController>().uploadImage(
          MultipartBody(file: selectedFile!),
          filename,
        );
      } else {
        debugPrint('no image');
        content = Content(
          id: 0,
          date: DateTime.now().millisecondsSinceEpoch,
          content: contentController.text,
          user: Get.find<AuthController>().user,
        );
      }

      Get.find<PostController>().addContent(content).then(
        (value) {
          if (value == 200) {
            showCustomSnackBar(KeyLanguage.addSuccess.tr, isError: false);
          } else if (value == 401) {
            showCustomSnackBar(KeyLanguage.errorUnauthentication.tr);
          }
        },
      );

      Get.find<ImageController>().clearImage();
      contentController.clear();
      Navigator.pop(context);
      animatedNoLoading();
    }
  }

  Future _pickImageFromGallery() async {
    final resultImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (resultImage == null) return;

    selectedFile = File(resultImage.path);
    Uint8List image = File(resultImage.path).readAsBytesSync();
    Get.find<ImageController>().updateImage(image);
  }
}
