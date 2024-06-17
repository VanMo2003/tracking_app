import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/controllers/theme_controller.dart';
import 'package:traking_app/helper/widgets/loading_widget.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/utils/styles.dart';
import 'package:traking_app/views/screens/home/user/drawer/drawer.dart';
import 'package:traking_app/views/screens/home/user/drawer/screens/info_user_screen.dart';

import '../../../../../helper/loading_helper.dart';
import '../../../../../helper/route_helper.dart';
import '../../../../../helper/widgets/dialog_widget.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/dimensions.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  @override
  Widget build(BuildContext context) {
    return loadingWidget(
      GetBuilder<AuthController>(builder: (controller) {
        var user = controller.user!;
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: Dimensions.RADIUS_SIZE_OVER_LARGE,
                backgroundColor: ColorResources.getPrimaryColor(),
                child: user.image != null
                    ? Image.asset(user.image!)
                    : Icon(
                        Icons.person,
                        size: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,
                        color: ColorResources.getBlackColor(),
                      ),
              ),
              const SizedBox(height: Dimensions.SIZE_BOX_HEIGHT_DEFAULT),
              Text(
                user.displayName ?? KeyLanguage.displayName.tr,
                style: robotoBold.copyWith(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
                    color: ColorResources.getBlackColor()),
              ),
              const Divider(
                height: 2,
              ),
              const SizedBox(height: Dimensions.SIZE_BOX_HEIGHT_DEFAULT),
              button(
                "Thông tin cá nhân",
                const Icon(Icons.person),
                () {
                  Get.to(const InfoUserScreen());
                },
              ),
              const SizedBox(height: Dimensions.SIZE_BOX_HEIGHT_DEFAULT),
              button(
                "Sáng/Tối",
                Icon(
                  Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: ColorResources.getBlackColor(),
                ),
                () {
                  Get.find<ThemeController>().toggleTheme();
                },
              ),
              const SizedBox(height: Dimensions.SIZE_BOX_HEIGHT_DEFAULT),
              button(
                "Đăng xuất",
                Icon(Icons.logout),
                () {
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
              ),
            ],
          ),
        );
      }),
    );
  }

  void logout() async {
    await animatedLoading();

    Get.find<AuthController>().logout().then(
      (value) {
        if (value == 200) {
          debugPrint('1');
          Get.find<AuthController>().clearData();
          debugPrint('2');
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

  Widget button(String label, Widget icon, void Function() onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          ColorResources.getBlackColor(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: robotoBlack.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  color: ColorResources.getBlackColor()),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
