import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:traking_app/controllers/post_controller.dart';
import 'package:traking_app/controllers/upload_file_controller.dart';
import 'package:traking_app/helper/date_converter_hepler.dart';
import 'package:traking_app/models/body/posts/content.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/utils/styles.dart';
import 'package:get/get.dart';
import '../post_comment.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key, required this.content, this.isClick = true});

  final Content content;
  final bool isClick;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  Uint8List? image;
  @override
  void initState() {
    super.initState();
    if (widget.content.media != null) {
      if (widget.content.media!.name != null) {
        Get.find<ImageController>().getImageByName(widget.content.media!.name!);
        image = Get.find<ImageController>().image;
      }
    }
  }

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
                radius: Dimensions.RADIUS_EXTRA_LARGE_OVER,
                child: widget.content.user!.image != null
                    ? Image.asset(widget.content.user!.image!)
                    : const Icon(Icons.image),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.content.user!.displayName!,
                      style: robotoBold.copyWith(
                        fontSize: 20,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    Text(
                      widget.content.date != null
                          ? DateConverter.convertTimeStampToString(
                              widget.content.date!)
                          : DateConverter.formatDate(DateTime.now()),
                      style: robotoBlack.copyWith(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              color: Theme.of(context).hintColor,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                widget.content.content!,
                style: robotoBold.copyWith(
                  fontSize: 24,
                  color: Colors.black,
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
                    debugPrint('click favarite post ${widget.content.id}');
                  }
                  Get.find<PostController>().likePost(widget.content.id!);
                },
                icon: Icon(
                  Icons.favorite,
                  color: ColorResources.getBlackColor(),
                ),
                label: Text(
                  "${KeyLanguage.like.tr} (${widget.content.likes == null ? 0 : widget.content.likes!.length})",
                  style: robotoBold.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  if (widget.isClick) {
                    if (kDebugMode) {
                      debugPrint('click comments post ${widget.content.id}');
                    }
                    Get.to(() => PostCommentWidget(content: widget.content));
                  }
                },
                icon: Icon(
                  Icons.message_outlined,
                  color: ColorResources.getBlackColor(),
                ),
                label: Text(
                  "${KeyLanguage.comment.tr} (${widget.content.comments == null ? 0 : widget.content.comments!.length})",
                  style: robotoBold.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
