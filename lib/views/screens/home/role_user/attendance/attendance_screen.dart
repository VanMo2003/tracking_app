import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/utils/dimensions.dart';

import '../../../../../helper/loading_helper.dart';
import '../../../../../utils/language/key_language.dart';
import '../../../../../utils/styles.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: GestureDetector(
        onTap: () async {
          await animatedLoading();
          Get.find<AuthController>().checkIn();
          animatedNoLoading();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_OVER_LARGE),
          height: size.height * 0.06,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          ),
          child: Center(
            child: Text(
              KeyLanguage.attendance.tr,
              style: robotoMedium.copyWith(
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
