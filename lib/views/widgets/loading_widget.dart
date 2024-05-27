import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:traking_app/utils/color_resources.dart';
import "package:get/get.dart";

import '../../controllers/loading_controller.dart';

Widget loading(Widget child) {
  return Stack(
    children: [
      child,
      GetBuilder<LoadingController>(
        builder: (controller) {
          return Visibility(
            visible: controller.isLoading,
            child: Container(
              color: Colors.white.withOpacity(0.4),
              child: Center(
                child: SpinKitSquareCircle(
                  color: ColorResources.getPrimaryColor(),
                  size: 50.0,
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}


// SpinKitSquareCircle(
//   color: ColorResources.getPrimaryColor(),
//   size: 50.0,
// );
