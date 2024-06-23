import 'package:flutter/material.dart';
import 'package:traking_app/models/body/posts/content.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:get/get.dart';
import 'package:traking_app/utils/styles.dart';
import 'post_item.dart';
import 'package:traking_app/views/widgets/text_field_widget.dart';

import '../../../../../../../controllers/auth_controller.dart';
import '../../../../../../../controllers/post_controller.dart';
import '../../../../../../../models/body/posts/comment.dart';

class PostComment extends StatefulWidget {
  PostComment({super.key, this.content, this.id});

  Content? content;
  final String? id;

  @override
  State<PostComment> createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  final TextEditingController commentController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      var content = Get.find<PostController>().contents.singleWhere(
            (element) => element.id.toString() == widget.id,
          );
      widget.content = content;
    }
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(KeyLanguage.comment.tr),
          centerTitle: true,
        ),
        body: GetBuilder<PostController>(
          builder: (controller) {
            List<Comments> comments = widget.content!.comments ?? [];

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: comments.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return PostItem(
                          content: widget.content!,
                          isClick: false,
                        );
                      }
                      var comment = comments[index - 1];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                radius: 20,
                                child: widget.content!.user!.image != null
                                    ? Image.asset(widget.content!.user!.image!)
                                    : const Icon(Icons.image),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).hintColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12))),
                                child: RichText(
                                  text: TextSpan(
                                    style: robotoBold.copyWith(
                                      fontSize: 18,
                                      color: Theme.of(context).cardColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: comment.user!.displayName,
                                      ),
                                      const TextSpan(text: "\n"),
                                      TextSpan(
                                        text: comment.content,
                                        style:
                                            robotoBlack.copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          controller: commentController,
                          hintText: KeyLanguage.comment.tr,
                          validator: (value) {
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (commentController.text != "") {
                            Comments body = Comments(
                              id: 0,
                              content: commentController.text,
                              user: Get.find<AuthController>().user,
                            );
                            Get.find<PostController>()
                                .commentPost(widget.content!.id!, body);
                            FocusScope.of(context).unfocus();
                            commentController.clear();
                          }
                        },
                        icon: const Icon(Icons.send),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}
