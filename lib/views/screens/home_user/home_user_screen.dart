import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/controllers/search_controller.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/utils/asset_util.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/utils/styles.dart';
import '../../../controllers/post_controller.dart';
import 'attendance/attendance_screen.dart';
import '../list_user/list_user_screen.dart';
import 'tracking/tracking_screen.dart';
import 'package:traking_app/views/widgets/loading_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../controllers/tracking_controller.dart';
import '../../../helper/notification_helper.dart';
import '../../../utils/color_resources.dart';
import '../../widgets/drawer_widget.dart';

class HomeUserScreent extends StatefulWidget {
  const HomeUserScreent({super.key});

  @override
  State<HomeUserScreent> createState() => _HomeUserScreentState();
}

class _HomeUserScreentState extends State<HomeUserScreent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _currentIndex = 0.obs;

  List<Widget> listWidget = [
    TrackingScreent(),
    AttendanceScreent(),
    ListUserScreent(),
  ];

  List<String> listTitle = [
    KeyLanguage.tracking,
    KeyLanguage.attendance,
    KeyLanguage.listUser,
  ];

  @override
  void initState() {
    listenToNotifications();
    super.initState();
    Get.find<TrackingController>().getAllByUser();
    Get.find<SearchByPageController>().getAllUser();
    // NotificationHelper.getDeviceToken();
  }

  listenToNotifications() {
    debugPrint('listening to notification');
    NotificationHelper.onClickNotification.stream.listen(
      (event) {
        debugPrint('$event');
        // Get.to(PostComment(id: event));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<TrackingController>().clearData();
    Get.find<AuthController>().clearData();
    Get.find<SearchByPageController>().clearData();
    Get.find<PostController>().clearData();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Obx(() {
        return Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetUtil.background),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Theme.of(context)
                  .cardColor
                  .withAlpha(Get.isDarkMode ? 150 : 0),
              key: _scaffoldKey,
              appBar: AppBar(
                toolbarHeight: Dimensions.APPBAR_HEIGHT_SIZE,
                elevation: 10,
                leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).cardColor,
                  ),
                ),
                // actions: [
                //   IconButton(
                //     onPressed: () {
                //       debugPrint('click notifications');
                //     },
                //     icon: Icon(
                //       Icons.notifications,
                //       color: Theme.of(context).cardColor,
                //     ),
                //   ),
                // ],
                title: Text(
                  listTitle[_currentIndex.value].tr,
                ),
                centerTitle: true,
              ),
              drawer: DrawerWidget(scaffoldKey: _scaffoldKey),
              body: Container(
                child: listWidget[_currentIndex.value],
              ),
              bottomNavigationBar: SalomonBottomBar(
                currentIndex: _currentIndex.value,
                onTap: (i) => _currentIndex.value = i,
                items: [
                  SalomonBottomBarItem(
                    icon: Image.asset(
                      AssetUtil.tracking,
                      color: Theme.of(context).disabledColor,
                    ),
                    title: Text(KeyLanguage.tracking.tr),
                    selectedColor: ColorResources.getPrimaryColor(),
                  ),
                  SalomonBottomBarItem(
                    icon: Image.asset(
                      AssetUtil.attendance,
                      color: Theme.of(context).disabledColor,
                    ),
                    title: Text(KeyLanguage.attendance.tr),
                    selectedColor: Colors.pink,
                  ),
                  SalomonBottomBarItem(
                    icon: Image.asset(
                      AssetUtil.list,
                      color: Theme.of(context).disabledColor,
                    ),
                    title: Text(KeyLanguage.listUser.tr),
                    selectedColor: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
