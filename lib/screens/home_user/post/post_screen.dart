import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/styles.dart';
import '/controllers/post_controller.dart';
import '/helper/route_helper.dart';
import '../../../data/models/body/posts/content.dart';
import '/utils/color_resources.dart';
import '/utils/dimensions.dart';
import '/utils/language/key_language.dart';
import 'package:get/get.dart';
import 'widget/post_item.dart';

class PostScreent extends StatefulWidget {
  const PostScreent({super.key});

  @override
  State<PostScreent> createState() => _PostScreentState();
}

class _PostScreentState extends State<PostScreent> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Content>? contents;
  String? id = Get.parameters["id"];
  String? displayName = Get.parameters["displayName"];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!Get.find<PostController>().last && id == "") {
          Get.find<PostController>().getPosts();
        } else if (!Get.find<PostController>().lastByUser && id != "") {
          Get.find<PostController>().getPostsByUser();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          displayName == ""
              ? KeyLanguage.posts.tr
              : "Bài viết của $displayName",
          style: robotoBold.copyWith(
            fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
            color: Theme.of(context).cardColor,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            highlightColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
            child: Icon(
              Icons.house_outlined,
              size: 32,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
      backgroundColor: ColorResources.getGreyColor(),
      body: GetBuilder<PostController>(
        builder: (controller) {
          if (contents == null) {
            Future.delayed(
              const Duration(milliseconds: 1000),
              () {
                contents =
                    id == "" ? controller.contents : controller.contentsByUser;
                controller.update();
              },
            );
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }

          if (contents!.isEmpty) {
            return Center(
              child: Text(KeyLanguage.listEmpty.tr),
            );
          }
          int length = 0;
          if (id == "") {
            length = controller.last ? contents!.length : contents!.length + 1;
          } else {
            length =
                controller.lastByUser ? contents!.length : contents!.length + 1;
          }
          return ListView.builder(
            controller: scrollController,
            itemCount: length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (id == "") {
                if (index == contents!.length && !controller.last) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              } else {
                if (index == contents!.length && !controller.lastByUser) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }

              return PostItem(
                content: contents![index],
              );
            },
          );
        },
      ),
      floatingActionButton: id == ""
          ? null
          : FloatingActionButton(
              onPressed: () {
                Get.toNamed(RouteHelper.addPost);
              },
              child: const Icon(Icons.post_add),
            ),
    );
  }
}
