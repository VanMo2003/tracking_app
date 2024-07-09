import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/notification_helper.dart';
import 'person/person_screen.dart';
import '../list_user/list_user_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../controllers/search_controller.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/asset_util.dart';
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
              appBar: _currentIndex.value == 1
                  ? null
                  : AppBar(
                      title: Text(listTitle[_currentIndex.value].tr),
                      centerTitle: true,
                    ),
              body: Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: listWidget[_currentIndex.value],
              ),
              bottomNavigationBar: SalomonBottomBar(
                currentIndex: _currentIndex.value,
                onTap: (i) => _currentIndex.value = i,
                items: [
                  SalomonBottomBarItem(
                    icon: Image.asset(
                      AssetUtil.list,
                      color: Theme.of(context).disabledColor,
                    ),
                    title: Text(KeyLanguage.listUser.tr),
                    selectedColor: Colors.orange,
                  ),
                  SalomonBottomBarItem(
                    icon: Image.asset(
                      AssetUtil.person,
                      color: Theme.of(context).disabledColor,
                    ),
                    title: Text(KeyLanguage.person.tr),
                    selectedColor: ColorResources.getPrimaryColor(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
