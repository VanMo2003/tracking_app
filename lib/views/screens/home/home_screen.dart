import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/controllers/theme_controller.dart';
import 'package:traking_app/utils/icons.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/views/screens/home/attendance/attendance_screen.dart';
import 'package:traking_app/views/screens/home/list_user/list_user_screen.dart';
import 'package:traking_app/views/screens/home/tracking/tracking_screen.dart';
import 'package:traking_app/views/widgets/loading_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../controllers/tracking_controller.dart';
import '../../../utils/color_resources.dart';
import 'drawer/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _currentIndex = 0.obs;

  List<Widget> listWidget = [
    TrackingScreen(),
    AttendanceScreen(),
    ListUserScreen(),
  ];

  List<String> listTitle = [
    KeyLanguage.tracking,
    KeyLanguage.attendance,
    KeyLanguage.listUser,
  ];

  @override
  void initState() {
    super.initState();
    Get.find<TrackingController>().getAllByUser();
    Get.find<AuthController>().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return loading(
      Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 50,
          elevation: 10,
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              onPressed: () {
                debugPrint('click notifications');
              },
              icon: const Icon(Icons.notifications),
            ),
          ],
          title: Obx(
            () => Text(listTitle[_currentIndex.value].tr),
          ),
          centerTitle: true,
        ),
        drawer: CustomDrawer(scaffoldKey: _scaffoldKey),
        body: Obx(
          () => listWidget[_currentIndex.value],
        ),
        bottomNavigationBar: Obx(
          () => SalomonBottomBar(
            currentIndex: _currentIndex.value,
            onTap: (i) => _currentIndex.value = i,
            items: [
              SalomonBottomBarItem(
                icon: Image.asset(
                  IconUtil.tracking,
                  color: ColorResources.getBlackColor(),
                ),
                title: Text(KeyLanguage.tracking.tr),
                selectedColor: ColorResources.getPrimaryColor(),
              ),
              SalomonBottomBarItem(
                icon: Image.asset(
                  IconUtil.attendance,
                  color: ColorResources.getBlackColor(),
                ),
                title: Text(KeyLanguage.attendance.tr),
                selectedColor: Colors.pink,
              ),
              SalomonBottomBarItem(
                icon: Image.asset(
                  IconUtil.list,
                ),
                title: Text(KeyLanguage.listUser.tr),
                selectedColor: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
