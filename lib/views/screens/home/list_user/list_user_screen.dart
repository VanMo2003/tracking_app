import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/controllers/search_controller.dart';
import 'package:traking_app/models/body/search_body.dart';
import 'package:traking_app/models/response/user_res.dart';
import 'package:traking_app/utils/dimensions.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({super.key});

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  ScrollController scrollController = new ScrollController();
  int pageIndex = 1;

  SearchBody search = SearchBody();

  @override
  void initState() {
    super.initState();
    Get.find<SearchByPageController>().getAllUser();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        debugPrint('haha');
        Future.delayed(
          const Duration(milliseconds: 1000),
          () {
            Get.find<SearchByPageController>()
                .getAllUser(pageIndex: ++pageIndex);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<SearchByPageController>(
      builder: (controller) {
        List<UserRes> list = controller.listResult;
        if (list == []) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          controller: scrollController,
          itemCount: controller.isPageLast ? list.length : list.length + 1,
          itemBuilder: (context, index) {
            if (index == list.length && !controller.isPageLast) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            return Container(
                color: Colors.amber,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: size.height * 0.1,
                width: double.infinity,
                child: ListTile(
                  leading: list[index].image != null
                      ? Image.asset(list[index].image!)
                      : const Icon(Icons.image),
                  title: Text(list[index].displayName ?? "displayname"),
                  subtitle: Text(list[index].email ?? "email"),
                ));
          },
        );
      },
    );
  }
}
