import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:traking_app/helper/route_helper.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/views/screens/home/drawer/widgets/custom_button.dart';
import 'package:traking_app/views/screens/home/drawer/widgets/dropdown_language.dart';
import 'package:get/get.dart';
import 'package:traking_app/views/widgets/loading_widget.dart';

import '../../../../../controllers/auth_controller.dart';

import '../../../../../controllers/loading_controller.dart';
import '../../../../../controllers/theme_controller.dart';
import '../../../../../helper/loading_helper.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/styles.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

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
                        controller.user!.username ?? "username",
                        style: robotoBold.copyWith(
                          color: ColorResources.getWhiteColor(),
                          fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                        ),
                      ),
                      Text(
                        "( ${controller.user!.displayName ?? "display name"} )",
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
                          CustomButton(
                            label: KeyLanguage.infoUser.tr,
                            onTap: () {
                              Get.toNamed(RouteHelper.getInfoUser());
                            },
                          ),
                          CustomButton(
                            label: KeyLanguage.changePassword.tr,
                            onTap: () {
                              Get.toNamed(RouteHelper.getChangePassword());
                            },
                          ),
                          CustomButton(
                            label: Get.find<ThemeController>().darkTheme
                                ? KeyLanguage.dark.tr
                                : KeyLanguage.light.tr,
                            onTap: () async {
                              await animatedLoading();
                              Get.find<ThemeController>().toggleTheme();
                              Get.find<LoadingController>().noLoading();
                              widget.scaffoldKey.currentState?.closeDrawer();
                            },
                          ),
                        ],
                      ),
                      CustomButton(
                        label: KeyLanguage.logout.tr,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Đăng xuất'),
                                content: const Text('Bạn có muốn đăng xuất?'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text('Hủy'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // SystemChannels.platform.invokeMethod(
                                      //     'SystemNavigator.pop'); // thoát app
                                      logout();
                                    },
                                    child: const Text('Có'),
                                  ),
                                ],
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
    Navigator.of(context).pop(false);

    await animatedLoading();

    Get.find<AuthController>().logout().then(
      (value) {
        if (value == 200) {
          Get.offNamed(RouteHelper.getSignInRoute());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Đã có lỗi xảy ra vui lòng thử lại")));
        }
      },
    );
    Get.find<LoadingController>().noLoading();
  }
}
