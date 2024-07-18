// ignore_for_file: unused_field

import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../views/custom_snackbar.dart';
import '/utils/app_constant.dart';
import '/utils/color_resources.dart';
import '/utils/asset_util.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '/utils/language/key_language.dart';

import '../../controllers/auth_controller.dart';
import '../../helper/route_helper.dart';
import '../../utils/dimensions.dart';
import '../../utils/styles.dart';

class SplashScreent extends StatefulWidget {
  const SplashScreent({super.key});

  @override
  State<SplashScreent> createState() => _SplashScreentState();
}

class _SplashScreentState extends State<SplashScreent> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_onConnectivityChange);
  }

  void _onConnectivityChange(ConnectivityResult result) async {
    if (result != ConnectivityResult.wifi) {
      if (isFirstTime) {
        showCustomSnackBar(KeyLanguage.noInternet.tr, duration: 6000);
      } else {
        showCustomSnackBar(KeyLanguage.noInternet.tr);
      }
    } else {
      if (isFirstTime) {
        await _route();
        hideSnackBar();
      }
      showCustomSnackBar(KeyLanguage.hasInternet.tr, isError: false);
      isFirstTime = false;
    }
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
            Image.asset(AssetUtil.trackingLogo, scale: 0.8),
            const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            Text(AppConstant.APP_NAME,
                style: robotoMedium.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  color: ColorResources.getPrimaryColor(),
                )),
          ],
        )),
      ),
    );
  }

  Future<void> _route() async {
    String? checkTokenLogin =
        await Get.find<AuthController>().authRepo.getUserToken();
    if (checkTokenLogin != null) {
      Get.find<AuthController>().getCurrentUser().then(
        (value) {
          if (value == 200) {
            if (Get.find<AuthController>().isAdmin) {
              Get.offAllNamed(RouteHelper.getHomeAdminRoute());
            } else {
              Get.offAllNamed(RouteHelper.getHomeUserRoute());
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
