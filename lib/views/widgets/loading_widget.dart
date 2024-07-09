import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:traking_app/utils/color_resources.dart';
import "package:get/get.dart";

import '../../controllers/loading_controller.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({super.key, required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        child,
        GetBuilder<LoadingController>(
          builder: (controller) {
            return Visibility(
              visible: controller.isLoading,
              child: Container(
                height: size.height,
                color: Theme.of(context).cardColor.withOpacity(0.5),
                child: Center(
                  child: SpinKitSquareCircle(
                    color: Theme.of(context).primaryColor,
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
}
