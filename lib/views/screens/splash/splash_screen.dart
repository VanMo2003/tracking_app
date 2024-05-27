import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:traking_app/utils/app_constant.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/icons.dart';
import 'dart:developer' as developer;

import '../../../controllers/auth_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';
import '../home/home_screen.dart';

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
                  fontSize: 18,
                  color: ColorResources.COLOR_PRIMARY,
                )),
          ],
        )),
      ),
    );
  }

  void _route() async {
    String? checkTokenLogin = Get.find<AuthController>()
        .authRepo
        .sharedPreferences
        .getString(AppConstant.TOKEN);
    if (checkTokenLogin != null) {
      Get.find<AuthController>().getCurrentUser().then(
            (value) => {
              if (value == 200)
                {
                  Get.offAll(
                    const HomeScreen(),
                    transition: Transition.size,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  )
                }
              else
                {Get.offNamed(RouteHelper.getSignInRoute())}
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
