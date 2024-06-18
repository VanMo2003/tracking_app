import 'package:flutter/material.dart';
import 'package:traking_app/helper/route_helper.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/views/widgets/button_widget.dart';
import 'package:traking_app/views/widgets/dropdown_language_widget.dart';
import 'package:get/get.dart';
import 'package:traking_app/views/widgets/dialog_widget.dart';

import '../../../../../controllers/auth_controller.dart';

import '../../../../../controllers/post_controller.dart';
import '../../../../../controllers/theme_controller.dart';
import '../../../../../helper/loading_helper.dart';
import '../../../../../models/body/posts/content.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/icons.dart';
import '../../../../../utils/styles.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  TextEditingController contentPostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var safe = MediaQuery.of(context).padding.top;

    return GetBuilder<AuthController>(
      builder: (controller) {
        return Container(
          height: size.height,
          width: size.width * 0.6,
          color: ColorResources.getWhiteColor(),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: size.height * 0.3,
                  width: size.width * 0.6,
                  color: ColorResources.getPrimaryColor().withOpacity(0.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,
                        backgroundColor: ColorResources.getWhiteColor(),
                        child: controller.user!.image != null
                            ? Image.asset(controller.user!.image!)
                            : Icon(
                                Icons.person,
                                size: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,
                                color: ColorResources.getBlackColor(),
                              ),
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      Text(
                        controller.user!.username ?? KeyLanguage.username.tr,
                        style: robotoBlack.copyWith(
                          color: ColorResources.getWhiteColor(),
                          fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                        ),
                      ),
                      Text(
                        "( ${controller.user!.displayName ?? KeyLanguage.displayName.tr} )",
                        style: robotoRegular.copyWith(
                          color:
                              ColorResources.getBlackColor().withOpacity(0.5),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  height: size.height * 0.68,
                  width: size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          ButtonCustomWidget(
                            label: KeyLanguage.infoPerson.tr,
                            onTap: () {
                              Get.toNamed(RouteHelper.getInfoUserRoute());
                            },
                          ),
                          PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return _menuItems(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_SIZE_SMALL),
                                color: ColorResources.getGreyColor()
                                    .withOpacity(0.5),
                              ),
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    KeyLanguage.post.tr,
                                    style: robotoBlack,
                                  ),
                                  Image.asset(
                                    IconUtil.back,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ButtonCustomWidget(
                            label: Get.find<ThemeController>().darkTheme
                                ? KeyLanguage.dark.tr
                                : KeyLanguage.light.tr,
                            onTap: () async {
                              await animatedLoading();
                              Get.find<ThemeController>().toggleTheme();
                              animatedNoLoading();
                              widget.scaffoldKey.currentState?.closeDrawer();
                            },
                          ),
                        ],
                      ),
                      ButtonCustomWidget(
                        label: KeyLanguage.logout.tr,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return showDialogQuestion(
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
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: safe / 2 + 10,
                left: 5,
                child: const DropdownLangue(),
              )
            ],
          ),
        );
      },
    );
  }

  void logout() async {
    await animatedLoading();

    Get.find<AuthController>().logout().then(
      (value) {
        if (value == 200) {
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

  List<PopupMenuEntry<String>> _menuItems(BuildContext context) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: KeyLanguage.posts.tr,
        child: ButtonCustomWidget(
          label: KeyLanguage.posts.tr,
          onTap: () {
            Get.toNamed(RouteHelper.getPostRoute());
          },
        ),
      ),
      PopupMenuItem<String>(
        value: KeyLanguage.addPost.tr,
        child: ButtonCustomWidget(
          label: KeyLanguage.addPost.tr,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return showDialogAdd(
                  context: context,
                  onAdd: () {
                    Content content = Content(
                      id: 0,
                      date: DateTime.now().millisecondsSinceEpoch,
                      content: contentPostController.text,
                      user: Get.find<AuthController>().user,
                    );
                    widget.scaffoldKey.currentState?.closeDrawer();
                    Get.find<PostController>().addContent(content);
                  },
                  controller: contentPostController,
                  textButton: KeyLanguage.add.tr,
                  hintText: KeyLanguage.postContent.tr,
                );
              },
            );
          },
        ),
      ),
    ];
  }
}
