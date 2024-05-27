import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/loading_controller.dart';
import 'package:traking_app/utils/dimensions.dart';

import '../../../../helper/loading_helper.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/language/key_language.dart';
import '../../../../utils/styles.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: GestureDetector(
        onTap: () async {
          await animatedLoading();
          Get.find<LoadingController>().noLoading();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_OVER_LARGE),
          height: size.height * 0.06,
          decoration: BoxDecoration(
            color: ColorResources.getPrimaryColor(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              KeyLanguage.attendance.tr,
              style: robotoMedium.copyWith(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
