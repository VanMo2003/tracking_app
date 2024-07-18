import 'dart:developer';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

import '../utils/dimensions.dart';
import '../utils/language/key_language.dart';
import 'date_converter_hepler.dart';

class ValidationHelper {
  static String? validNull(String? value) {
    if (GetUtils.isNull(value != "" ? value : null)) {
      return KeyLanguage.validNull.tr;
    }
    return null;
  }

  static String? validEmail(String? value) {
    if (GetUtils.isNull(value != "" ? value : null)) {
      return KeyLanguage.validNull.tr;
    }
    if (!GetUtils.isEmail(value!)) {
      return KeyLanguage.validEmail.tr;
    }
    return null;
  }

  static String? validPassword(String? value) {
    if (GetUtils.isNull(value != "" ? value : null)) {
      return KeyLanguage.validNull.tr;
    }
    if (!GetUtils.isLengthBetween(
      value!,
      Dimensions.MIN_LENGTH_PASSWORD,
      Dimensions.MAX_LENGTH_PASSWORD,
    )) {
      return KeyLanguage.validPassword.tr;
    }
    return null;
  }

  static String? validDOB(String? value) {
    if (GetUtils.isNull(value != "" ? value : null)) {
      return KeyLanguage.validNull.tr;
    }
    try {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      dateFormat.parse(value!);
    } catch (e) {
      return "yyyy-MM-dd";
    }
    int yearNow = int.parse(
      DateConverter.dateToStringformat(DateTime.now()).split("-")[0],
    );
    int yearPick = int.parse(value.split("-")[0]);

    if (yearNow - yearPick < 18) {
      return "tuổi phải lớn hơn 18";
    }
    return null;
  }
}
