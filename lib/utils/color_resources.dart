import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme_controller.dart';

class ColorResources {
  static Color getPrimaryColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFFF74D9)
        : Color(0xFFE054B8);
  }

  static Color getPrimaryTextColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF34495E)
        : Color(0xFF2C3F50);
  }

  static Color getSecondaryHeaderColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFaaa818)
        : Color(0xFFCFEC7E);
  }

  static Color getGreyColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFEBF1F1)
        : Color(0xFFBEC3C7);
  }

  static Color getGreyBaseGray1() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFd3d3d8)
        : Color(0xFF8E8E93);
  }

  static Color getLightGray() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xdbdbdb)
        : Color(0xFFF3F3F3);
  }

  static Color getAcceptBtn() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF065802)
        : Color(0xFF95CD41);
  }

  static Color getGreyBaseGray3() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF757575)
        : Color(0xFFC7C7CC);
  }

  static Color getGreyBaseGray4() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFe3e3e8)
        : Color(0xFFD1D1D6);
  }

  static Color getGreyBaseGray6() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFb2b5c8)
        : Color(0xFFF2F2F7);
  }

  static Color getSearchBg() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF585a5c)
        : Color(0xFFF4F7FC);
  }

  static Color getBackgroundColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF343636)
        : Color(0xFFFAFAFA);
  }

  static Color getBlackAndWhite() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFFFFFFF)
        : Color(0xFF606060);
  }

  static Color getWhiteAndBlack() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF000000)
        : Color(0xFFFFFFFF);
  }

  static Color getLightAndDark() {
    return Get.find<ThemeController>().darkTheme
        ? Theme.of(Get.context!).cardColor
        : Color(0xFF000000);
  }

  static Color getOccupationCardColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF3c3c3c)
        : Color(0xFFFFFFFF);
  }

  static Color getHintColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF98a1ab)
        : Color(0xFF808080);
  }

  static Color getGreyBunkerColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFE4E8EC)
        : Color(0xFF25282B);
  }

  static Color getTextColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFE4E8EC)
        : Color(0xFF25282B);
  }

  static Color getAcceptTextColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF25282B)
        : Color(0xFFE4E8EC);
  }

  static Color getNoteTextColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF25282B)
        : Color(0xFF14684E);
  }

  ////
  ///
  static Color getWhiteColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF000000)
        : Color(0xFFFFFFFF);
  }

  static Color getBlackColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFFFFFFF)
        : Color(0xFF000000);
  }

  static Color getTransactionTitleColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF71a8c1)
        : Color(0xFF174061);
  }

  static Color getTransactionTrilingColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF84b1cc)
        : Color(0xFF344968);
  }

  static Color getWebsiteTextColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF84b1cc)
        : Color(0xFF344968);
  }

  static Color getBalanceTextColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFd7d7d7)
        : Color(0xFF393939);
  }

  static Color getShadoColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFededed)
        : Color(0xFF848484);
  }

  //card.
  static Color getAddMoneyCardColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF398343)
        : Color(0xFFACD9B3);
  }

  static Color getCashOutCardColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFf57a00)
        : Color(0xFFFFCB66);
  }

  static Color getRequestMoneyCardColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFa900a0)
        : Color(0xFFF6BDE9);
  }

  static Color getReferFriendCardColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF0083cf)
        : Color(0xFFADE4FD);
  }

  static Color getOthersCardColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF3137c9)
        : Color(0xFFD0C5FF);
  }

  static Color getShadowColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFeeeeee)
        : Color(0xFF757575);
  }

  //onboarding
  static Color getOnboardingBgColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF4a5361)
        : Color(0xFFD1D5DB);
  }

  static Color getOnboardGreyColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFe9e8f5)
        : Color(0xFF6D6D78);
  }

  static Color getDividerColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFd9d9d9)
        : Color(0xFF434343);
  }

  static Color getSupportScreenTextColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFe6e6e6)
        : Color(0xFF484848);
  }

  static Color getLightGrey() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF686868)
        : Color(0xFFF8F8F8);
  }

  static Color getOtpFieldColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFF6a6e81)
        : Color(0xFFF2F2F7);
  }

  static Color getRedColor() {
    return Get.find<ThemeController>().darkTheme
        ? Color(0xFFbd0a00)
        : Color(0xFFff795b);
  }

  static const gradientButton = LinearGradient(
    colors: [
      Color(0xff4facfe),
      Color(0xff00f2fe),
    ],
  );
}
