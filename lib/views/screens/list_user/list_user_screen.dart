import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/controllers/search_controller.dart';
import 'package:traking_app/models/body/search.dart';
import 'package:traking_app/models/response/user_res.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'widget/list_user_item.dart';

import '../../../utils/language/key_language.dart';

class ListUserScreent extends StatefulWidget {
  ListUserScreent({super.key, this.enabled = true});

  bool enabled;

  @override
  State<ListUserScreent> createState() => _ListUserScreentState();
}

class _ListUserScreentState extends State<ListUserScreent> {
  ScrollController scrollController = ScrollController();
  int pageIndex = 1;

  Search search = Search();

  bool isAdmin = false;

  @override
  void initState() {
    super.initState();

    isAdmin = Get.find<AuthController>().isAdmin;

    Future.delayed(
      const Duration(milliseconds: 1000),
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
            const Duration(milliseconds: 500),
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
  void dispose() {
    super.dispose();
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
          child: Padding(
            padding: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
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
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                }
                return ListUserItem(user: list[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
