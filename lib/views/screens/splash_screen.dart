import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:traking_app/utils/app_constant.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/icons.dart';
import 'dart:developer' as developer;

import '../../controllers/splash_controller.dart';
import '../../helper/route_helper.dart';
import '../../utils/dimensions.dart';
import '../../utils/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();
    bool _firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi;
        isNotConnected
            ? SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? "Không có kết nối" : "Có kết nối",
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });
    _route();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        builder: (splashController) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
              child: splashController.hasConnection
                  ? Column(
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
                    )
                  : const Text("Không có kết nối"),
            ),
          );
        },
      ),
    );
  }

  void _route() async {
    await Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        Get.offNamed(RouteHelper.getSignInRoute());
      },
    );
  }
}
