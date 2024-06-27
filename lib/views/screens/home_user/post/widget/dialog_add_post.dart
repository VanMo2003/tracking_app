import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/post_controller.dart';
import '../../../controllers/upload_file_controller.dart';
import '../../../models/body/multipart.dart';
import '../../../models/body/posts/content.dart';
import '../../../models/body/posts/media.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/language/key_language.dart';
import '../text_field_widget.dart';

class AddPostDialogWidget extends StatelessWidget {
  const AddPostDialogWidget({
    super.key,
    required this.controller,
    required this.onTap,
    required this.selectedFile,
  });

  final TextEditingController controller;
  final void Function() onTap;
  final File? selectedFile;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: SizedBox(
          height: 300.0,
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: TextFieldWidget(
                  autoFocus: true,
                  controller: controller,
                  hintText: KeyLanguage.postContent.tr,
                ),
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              GetBuilder<ImageController>(
                builder: (controller) {
                  if (controller.image == null) {
                    return GestureDetector(
                      onTap: () {
                        onTap();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Chọn ảnh"),
                          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                          Icon(Icons.image),
                        ],
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      onTap();
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(controller.image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            ColorResources.getWhiteColor()),
                      ),
                      onPressed: () {
                        late Content content;
                        if (Get.find<ImageController>().image != null) {
                          if (selectedFile != null) {
                            String filename =
                                "${Timestamp.fromDate(DateTime.now()).seconds}.png";
                            content = Content(
                              id: 0,
                              date: DateTime.now().millisecondsSinceEpoch,
                              content: controller.text,
                              user: Get.find<AuthController>().user,
                              media: Media(name: filename),
                            );

                            Get.find<ImageController>().uploadImage(
                              MultipartBody(file: selectedFile!),
                              filename,
                            );
                          }
                        } else {
                          content = Content(
                            id: 0,
                            date: DateTime.now().millisecondsSinceEpoch,
                            content: controller.text,
                            user: Get.find<AuthController>().user,
                          );
                        }

                        Get.find<PostController>().addContent(content);

                        Get.find<ImageController>().clearImage();
                        controller.clear();
                        Navigator.pop(context);
                      },
                      child: Text(KeyLanguage.add.tr),
                    ),
                    const SizedBox(
                      width: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (Get.find<ImageController>().image != null) {
                          Get.find<ImageController>().clearImage();
                        }
                        controller.clear();
                        Navigator.pop(context);
                      },
                      child: Text(KeyLanguage.cancel.tr),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
