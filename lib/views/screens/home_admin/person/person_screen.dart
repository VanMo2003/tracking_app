import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/controllers/theme_controller.dart';
import 'package:traking_app/services/firebase_service.dart';
import 'package:traking_app/views/widgets/loading_widget.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/utils/styles.dart';
import '../../home_user/info_user/info_user_screen.dart';

import '../../../../helper/loading_helper.dart';
import '../../../../helper/route_helper.dart';
import '../../../widgets/dialog_widget.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/dimensions.dart';
import '../../../widgets/dropdown_language_widget.dart';

class PersonScreent extends StatefulWidget {
  const PersonScreent({super.key});

  @override
  State<PersonScreent> createState() => _PersonScreentState();
}

class _PersonScreentState extends State<PersonScreent> {
  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: GetBuilder<AuthController>(builder: (controller) {
        var user = controller.user!;
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
          ),
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: Dimensions.RADIUS_SIZE_OVER_LARGE,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: user.image != null
                        ? Image.asset(user.image!)
                        : Icon(
                            Icons.person,
                            size: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,
                            color: Theme.of(context).cardColor,
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
                    KeyLanguage.infoPerson.tr,
                    const Icon(Icons.person),
                    () {
                      Get.to(const InfoUserScreent());
                    },
                  ),
                  const SizedBox(height: Dimensions.SIZE_BOX_HEIGHT_DEFAULT),
                  button(
                    "${KeyLanguage.light.tr}/${KeyLanguage.dark.tr}",
                    Icon(
                      Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: ColorResources.getBlackColor(),
                    ),
                    () {
                      changeTheme();
                    },
                  ),
                  const Spacer(),
                  button(
                    KeyLanguage.logout.tr,
                    const Icon(Icons.logout),
                    () {
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
                  ),
                ],
              ),
              const Positioned(
                right: 0,
                child: DropdownLangueWidget(),
              )
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

  void changeTheme() async {
    await animatedLoading();
    Get.find<ThemeController>().toggleTheme();

    animatedNoLoading();
  }
}
