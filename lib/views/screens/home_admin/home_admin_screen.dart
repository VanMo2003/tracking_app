import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/notification_helper.dart';
import 'person/person_screen.dart';
import '../list_user/list_user_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../controllers/search_controller.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/icons.dart';
import '../../../utils/language/key_language.dart';

class HomeAdminScreent extends StatefulWidget {
  const HomeAdminScreent({super.key});

  @override
  State<HomeAdminScreent> createState() => _HomeAdminScreentState();
}

class _HomeAdminScreentState extends State<HomeAdminScreent> {
  List<Widget> listWidget = [
    ListUserScreent(),
    const PersonScreent(),
  ];

  List<String> listTitle = [
    KeyLanguage.listUser,
    KeyLanguage.person,
  ];

  var _currentIndex = 0.obs;
  @override
  void initState() {
    super.initState();
    Get.find<SearchByPageController>().getAllUser();
    NotificationHelper.getDeviceToken();
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<SearchByPageController>().clearData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text(listTitle[_currentIndex.value].tr),
          //   centerTitle: true,
          // ),
          body: SafeArea(child: listWidget[_currentIndex.value]),
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: _currentIndex.value,
            onTap: (i) => _currentIndex.value = i,
            items: [
              SalomonBottomBarItem(
                icon: Image.asset(
                  IconUtil.list,
                  color: Theme.of(context).disabledColor,
                ),
                title: Text(KeyLanguage.listUser.tr),
                selectedColor: Colors.orange,
              ),
              SalomonBottomBarItem(
                icon: Image.asset(
                  IconUtil.person,
                  color: Theme.of(context).disabledColor,
                ),
                title: Text(KeyLanguage.person.tr),
                selectedColor: ColorResources.getPrimaryColor(),
              ),
            ],
          ),
        );
      },
    );
  }
}
