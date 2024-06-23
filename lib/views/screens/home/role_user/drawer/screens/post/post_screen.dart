import 'package:flutter/material.dart';
import 'package:traking_app/controllers/post_controller.dart';
import 'package:traking_app/models/body/posts/content.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:get/get.dart';
import 'post_item.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  ScrollController scrollController = ScrollController();
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    Get.find<PostController>().getPosts();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!Get.find<PostController>().posts!.last!) {
          Future.delayed(
            const Duration(milliseconds: 1000),
            () {
              Get.find<PostController>().getPosts(pageIndex: ++pageIndex);
            },
          );
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<PostController>().clearData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyLanguage.posts.tr),
        centerTitle: true,
      ),
      backgroundColor: ColorResources.getGreyColor(),
      body: GetBuilder<PostController>(
        builder: (controller) {
          var posts = controller.posts;
          if (posts == null) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorResources.getPrimaryColor(),
              ),
            );
          }
          List<Content> contents = controller.contents;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ListView.builder(
              controller: scrollController,
              itemCount: posts.last! ? contents.length : contents.length + 1,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == contents.length && !controller.posts!.last!) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return PostItem(content: contents[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
