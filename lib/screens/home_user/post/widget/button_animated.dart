import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/post_controller.dart';
import '../../../../data/models/body/posts/content.dart';
import '../../../../utils/language/key_language.dart';
import '../../../../utils/styles.dart';

class ButtonAnimated extends AnimatedWidget {
  ButtonAnimated({
    super.key,
    required super.listenable,
    required this.controller,
    required this.animation,
    required this.content,
  });

  final AnimationController controller;
  final Animation<double> animation;
  final Content content;
  final colorTween =
      ColorTween(begin: Theme.of(Get.context!).disabledColor, end: Colors.red);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Get.find<PostController>().likePost(content.id!);
        controller.forward();
      },
      icon: Icon(
        Icons.favorite,
        color: colorTween.evaluate(animation),
      ),
      label: Text(
        "${KeyLanguage.like.tr} (${content.likes == null ? 0 : content.likes!.length})",
        style: robotoBold.copyWith(
          color: Theme.of(context).disabledColor,
        ),
      ),
    );
  }
}
