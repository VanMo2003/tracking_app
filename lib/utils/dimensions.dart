import 'package:get/get.dart';

class Dimensions {
  static double fontSizeExtraSmall = Get.context!.width >= 1300 ? 14 : 10;
  static double fontSizeSmall = Get.context!.width >= 1300 ? 16 : 12;
  static double fontSizeDefault = Get.context!.width >= 1300 ? 18 : 14;
  static double fontSizeLarge = Get.context!.width >= 1300 ? 20 : 16;
  static double fontSizeExtraLarge = Get.context!.width >= 1300 ? 22 : 18;
  static double fontSizeOverLarge = Get.context!.width >= 1300 ? 28 : 24;

  static const double PADDING_SIZE_EXTRA_SMALL = 5.0;
  static const double PADDING_SIZE_SMALL = 10.0;
  static const double PADDING_SIZE_DEFAULT = 15.0;
  static const double PADDING_SIZE_LARGE = 20.0;
  static const double PADDING_SIZE_EXTRA_LARGE = 25.0;
  static const double PADDING_SIZE_EXTRA_EXTRA_LARGE = 32.0;
  static const double PADDING_SIZE_OVER_LARGE = 45.0;
  static const double PADDING_SIZE_EXTRA_OVER_LARGE = 55.0;

  static const double MARGIN_SIZE_EXTRA_SMALL = 4.0;
  static const double MARGIN_SIZE_SMALL = 8.0;
  static const double MARGIN_SIZE_DEFAULT = 12.0;
  static const double MARGIN_SIZE_LARGE = 20.0;
  static const double MARGIN_SIZE_EXTRA_LARGE = 25.0;
  static const double MARGIN_SIZE_BOX_LOGIN = 30.0;

  static const double SIZE_BOX_HEIGHT_EXTRA_SMALL = 5.0;
  static const double SIZE_BOX_HEIGHT_SMALL = 10.0;
  static const double SIZE_BOX_HEIGHT_DEFAULT = 15.0;
  static const double SIZE_BOX_HEIGHT_LARGE = 20.0;
  static const double SIZE_BOX_HEIGHT_EXTRA_LARGE = 25.0;
  static const double SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER = 30.0;

  static const double RADIUS_SMALL = 5.0;
  static const double RADIUS_DEFAULT = 10.0;
  static const double RADIUS_LARGE = 15.0;
  static const double RADIUS_EXTRA_LARGE = 20.0;
  static const double RADIUS_EXTRA_LARGE_OVER = 25.0;

  static const double FONT_SIZE_EXTRA_SMALL = 8.0;
  static const double FONT_SIZE_SMALL = 10.0;
  static const double FONT_SIZE_DEFAULT = 14.0;
  static const double FONT_SIZE_LARGE = 16.0;
  static const double FONT_SIZE_EXTRA_LARGE = 18.0;
  static const double FONT_SIZE_OVER_LARGE = 20.0;
  static const double FONT_SIZE_EXTRA_OVER_LARGE = 24.0;
  static const double FONT_SIZE_OVER_OVER_LARGE = 28.0;
  static const double FONT_SIZE_TITLE_LARGE = 32.0;

  static const double RADIUS_SIZE_VERY_SMALL = 4.0;
  static const double RADIUS_SIZE_EXTRA_SMALL = 8.0;
  static const double RADIUS_SIZE_SMALL = 12.0;
  static const double RADIUS_SIZE_REGULAR = 14.0;
  static const double RADIUS_SIZE_DEFAULT = 16.0;
  static const double RADIUS_SIZE_LARGE = 20.0;
  static const double RADIUS_SIZE_EXTRA_LARGE = 30.0;
  static const double RADIUS_SIZE_EXTRA_EXTRA_LARGE = 40.0;
  static const double RADIUS_SIZE_OVER_LARGE = 50.0;
  static const double RADIUS_PROFILE_AVATAR = 25.0;
  static const double SIZE_PROFILE_AVATAR = 50.0;

  static const double DIVIDER_SIZE_SMALL = 1.0;
  static const double DIVIDER_SIZE_EXTRA_SMALL = 0.5;
  static const double DIVIDER_SIZE_MEDIUM = 2.0;
  static const double DIVIDER_SIZE_LARGE = 4.0;
  static const double DIVIDER_SIZE_EXTRA_LARGE = 4.0;

  static const double APPBAR_HEIGHT_SIZE = 50.0;

  static const int SIZE_OF_PAGE_USERS = 15;
  static const int SIZE_OF_PAGE_POSTS = 10;
  static const int MIN_LENGTH_PASSWORD = 3;
  static const int MAX_LENGTH_PASSWORD = 20;
}
