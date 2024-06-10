import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/utils/color_resources.dart';
import '../utils/dimensions.dart';
import '../utils/styles.dart';

void showCustomSnackBar(String message, {bool isError = true}) {
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      duration: const Duration(seconds: 2),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      content: Text(
        message,
        style: robotoMedium.copyWith(
          color: ColorResources.getWhiteColor(),
        ),
      ),
    ));
  }
}
