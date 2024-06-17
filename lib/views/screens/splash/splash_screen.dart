import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:traking_app/utils/app_constant.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/icons.dart';

import '../../../controllers/auth_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _route();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(IconUtil.tracking_logo, scale: 0.8),
            const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            Text(AppConstant.APP_NAME,
                style: robotoMedium.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  color: ColorResources.COLOR_PRIMARY,
                )),
          ],
        )),
      ),
    );
  }

  void _route() async {
    String? checkTokenLogin =
        await Get.find<AuthController>().authRepo.getUserToken();
    if (checkTokenLogin != null) {
      Get.find<AuthController>().getCurrentUser().then(
        (value) {
          if (value == 200) {
            if (Get.find<AuthController>().isAdmin) {
              Get.offAllNamed(RouteHelper.getHomeAdminRoute());
            } else {
              Get.offAllNamed(RouteHelper.getHomeRoute());
            }
          } else {
            Get.offNamed(RouteHelper.getSignInRoute());
          }
        },
      );
    } else {
      await Future.delayed(
        const Duration(milliseconds: 2000),
        () {
          Get.offNamed(RouteHelper.signIn);
        },
      );
    }
  }
}
