import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/auth_controller.dart';
import '../../../theme/theme_controller.dart';
import '../../../views/custom_loading.dart';
import '/utils/language/key_language.dart';
import '/utils/styles.dart';
import '../../home_user/info_user/info_user_screen.dart';

import '../../../helper/loading_helper.dart';
import '../../widgets/dialog_widget.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/dimensions.dart';
import '../../widgets/dropdown_language_widget.dart';

class PersonScreent extends StatefulWidget {
  const PersonScreent({super.key});

  @override
  State<PersonScreent> createState() => _PersonScreentState();
}

class _PersonScreentState extends State<PersonScreent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingWidget(
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
                        Get.find<AuthController>().logout(context);
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
      ),
    );
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
