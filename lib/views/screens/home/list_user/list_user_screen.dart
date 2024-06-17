import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/controllers/search_controller.dart';
import 'package:traking_app/models/body/search.dart';
import 'package:traking_app/models/response/user_res.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/views/screens/home/user/list_user/list_user_item.dart';

import '../../../../../utils/language/key_language.dart';

class ListUserScreen extends StatefulWidget {
  ListUserScreen({super.key, this.enabled = true});

  bool enabled;

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  ScrollController scrollController = ScrollController();
  int pageIndex = 1;

  Search search = Search();

  bool isAdmin = false;

  @override
  void initState() {
    super.initState();

    isAdmin = Get.find<AuthController>().isAdmin;

    Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        setState(() {
          widget.enabled = false;
        });
      },
    );

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!Get.find<SearchByPageController>().isPageLast) {
          Future.delayed(
            const Duration(milliseconds: 1000),
            () {
              Get.find<SearchByPageController>()
                  .getAllUser(pageIndex: ++pageIndex);
            },
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchByPageController>(
      builder: (controller) {
        if (controller.listResult == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<UserRes> list = controller.listResult?.cast<UserRes>() ?? [];

        if (list.isEmpty) {
          return Center(
            child: Text(KeyLanguage.listEmpty.tr),
          );
        }

        return Skeletonizer(
          enabled: widget.enabled,
          enableSwitchAnimation: true,
          child: ListView.builder(
            controller: scrollController,
            itemCount: controller.isPageLast ? list.length : list.length + 1,
            itemBuilder: (context, index) {
              if (index == list.length && !controller.isPageLast) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: CircularProgressIndicator(
                      color: ColorResources.getPrimaryColor(),
                    ),
                  ),
                );
              }
              return ListUserItem(user: list[index]);
            },
          ),
        );
      },
    );
  }
}
