import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:traking_app/controllers/post_controller.dart';
import 'package:traking_app/helper/date_converter.dart';
import 'package:traking_app/models/body/posts/content.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/utils/styles.dart';
import 'package:get/get.dart';
import 'package:traking_app/views/screens/home/user/drawer/screens/post/post_comment.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.content, this.isClick = true});

  final Content content;
  final bool isClick;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: size.height * 0.5,
      decoration: BoxDecoration(
        color: ColorResources.getWhiteColor(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 30,
                child: content.user!.image != null
                    ? Image.asset(content.user!.image!)
                    : const Icon(Icons.image),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.user!.displayName!,
                      style: robotoBold.copyWith(fontSize: 20),
                    ),
                    Text(
                      content.date != null
                          ? DateConverter.convertTimeStampToString(
                              content.date!)
                          : DateConverter.formatDate(DateTime.now()),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              color: ColorResources.getGreyColor(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                content.content!,
                style: robotoBold.copyWith(
                  fontSize: 24,
                ),
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  if (kDebugMode) {
                    debugPrint('click favarite post ${content.id}');
                  }
                  Get.find<PostController>().likePost(content.id!);
                },
                icon: Icon(
                  Icons.favorite,
                  color: ColorResources.getBlackColor(),
                ),
                label: Text(
                  "${KeyLanguage.like.tr} (${content.likes == null ? 0 : content.likes!.length})",
                  style: robotoBold,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  if (isClick) {
                    if (kDebugMode) {
                      debugPrint('click comments post ${content.id}');
                    }
                    Get.to(() => PostComment(content: content));
                  }
                },
                icon: Icon(
                  Icons.message_outlined,
                  color: ColorResources.getBlackColor(),
                ),
                label: Text(
                  "${KeyLanguage.comment.tr} (${content.comments == null ? 0 : content.comments!.length})",
                  style: robotoBold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
