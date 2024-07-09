import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/views/widgets/button_primary_widget.dart';

import '../../../../helper/date_converter_hepler.dart';
import '../../../../helper/loading_helper.dart';
import '../../../../helper/snackbar_helper.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/language/key_language.dart';
import '../../../../utils/styles.dart';

class AttendanceScreent extends StatelessWidget {
  const AttendanceScreent({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_OVER_LARGE,
        ),
        child: ButtonPrimaryWidget(
          label: KeyLanguage.attendance.tr,
          onTap: () async {
            await animatedLoading();
            Get.find<AuthController>().checkIn().then(
              (value) {
                if (value == 200) {
                  showCustomSnackBar(
                    "${KeyLanguage.attendanceSuccess.tr} : ${DateConverter.formatDate(DateTime.now())}",
                    isError: false,
                  );
                } else {
                  showCustomSnackBar(KeyLanguage.attendanced.tr);
                }
              },
            );
            animatedNoLoading();
          },
        ),
      ),
    );
  }
}
