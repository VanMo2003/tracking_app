import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traking_app/controllers/upload_file_controller.dart';
import 'package:traking_app/helper/route_helper.dart';
import 'package:traking_app/services/firebase_service.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/views/widgets/button_drawer_widget.dart';
import 'package:traking_app/views/screens/home_user/post/widget/dialog_add_post.dart';
import 'package:traking_app/views/widgets/dropdown_language_widget.dart';
import 'package:get/get.dart';
import 'package:traking_app/views/widgets/dialog_widget.dart';

import '../../controllers/auth_controller.dart';

import '../../controllers/theme_controller.dart';
import '../../helper/loading_helper.dart';
import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../../utils/asset_util.dart';
import '../../utils/styles.dart';
import '../screens/home_user/notification/notifications.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  TextEditingController contentPostController = TextEditingController();
  RxBool isOpenMenuPost = false.obs;
  File? selectedFile;

  @override
  void initState() {
    super.initState();
    if (Get.find<ImageController>().image == null) {
      // Get.find<UploadFileController>().getFileByName("1719300911.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var safe = MediaQuery.of(context).padding.top;

    return GetBuilder<AuthController>(
      builder: (authController) {
        return Container(
          height: size.height,
          width: size.width * 0.8,
          color: ColorResources.getWhiteColor(),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: safe,
                    left: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AssetUtil.background_drawer),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: size.height * 0.3,
                  width: size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,
                        backgroundColor: ColorResources.getWhiteColor(),
                        child: authController.user!.image != null
                            ? Image.asset(authController.user!.image!)
                            : Icon(
                                Icons.person,
                                size: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,
                                color: ColorResources.getBlackColor(),
                              ),
                      ),
                      const SizedBox(
                          height: Dimensions.PADDING_SIZE_OVER_LARGE),
                      RichText(
                        text: TextSpan(
                          style: robotoBold.copyWith(
                            color: Theme.of(context).cardColor,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
                          ),
                          children: [
                            TextSpan(
                              text: authController.user!.username ??
                                  KeyLanguage.username.tr,
                            ),
                            TextSpan(
                              text:
                                  " (${authController.user!.displayName ?? KeyLanguage.displayName.tr})",
                              style: robotoBold.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                color:
                                    Theme.of(context).cardColor.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        authController.user!.email ??
                            KeyLanguage.displayName.tr,
                        style: robotoBlack.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: Theme.of(context).cardColor.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.3,
                left: 0,
                child: Container(
                  height: size.height * 0.7,
                  width: size.width * 0.8,
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Column(
                    children: [
                      ButtonDrawerWidget(
                        label: KeyLanguage.infoPerson.tr,
                        onTap: () {
                          Get.toNamed(RouteHelper.getInfoUserRoute());
                        },
                        icon: Image.asset(
                          AssetUtil.person,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      ButtonDrawerWidget(
                        onTap: () {
                          Get.toNamed(RouteHelper.getPostRoute());
                        },
                        label: KeyLanguage.post.tr,
                        icon: Icon(
                          Icons.list,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      ButtonDrawerWidget(
                        label: Get.find<ThemeController>().darkTheme
                            ? KeyLanguage.dark.tr
                            : KeyLanguage.light.tr,
                        onTap: () async {
                          await animatedLoading();
                          Get.find<ThemeController>().toggleTheme();
                          animatedNoLoading();
                          widget.scaffoldKey.currentState?.closeDrawer();
                        },
                        icon: Icon(
                          Get.find<ThemeController>().darkTheme
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      ButtonDrawerWidget(
                        label: KeyLanguage.notification.tr,
                        onTap: () {
                          Get.to(const NotificationScreent());
                        },
                        icon: Icon(
                          Icons.notifications,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      const Spacer(),
                      ButtonDrawerWidget(
                        label: KeyLanguage.logout.tr,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return dialogQuestionWidget(
                                context,
                                KeyLanguage.logout.tr,
                                KeyLanguage.logoutQuestion.tr,
                                () {
                                  logout();
                                },
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: safe + 5,
                right: 25,
                child: const DropdownLangueWidget(),
              )
            ],
          ),
        );
      },
    );
  }

  Future _pickImageFromGallery() async {
    final resultImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (resultImage == null) return;

    selectedFile = File(resultImage.path);
    Uint8List image = File(resultImage.path).readAsBytesSync();
    Get.find<ImageController>().updateImage(image);
  }

  void logout() async {
    await animatedLoading();

    Get.find<AuthController>().logout().then(
      (value) {
        if (value == 200) {
          FirebaseService.removeCurrentUserToken();
          Get.find<AuthController>().clearData();
          Get.offNamed(RouteHelper.getSignInRoute());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(KeyLanguage.errorAnUnknow.tr),
            ),
          );
        }
      },
    );
    animatedNoLoading();
  }

  void addPost() {
    showDialog(
      context: context,
      builder: (context) {
        return AddPostDialogWidget(
          controller: contentPostController,
          onTap: () {
            _pickImageFromGallery();
          },
          selectedFile: selectedFile,
        );
      },
    );
  }
}
