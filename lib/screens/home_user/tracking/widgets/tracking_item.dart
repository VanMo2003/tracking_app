import 'dart:developer';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'button__tracking_widget.dart';

import '../../../../controllers/loading_controller.dart';
import '../../../../controllers/tracking_controller.dart';
import '../../../../helper/date_converter_hepler.dart';
import '../../../../helper/loading_helper.dart';
import '../../../../data/models/body/tracking.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/language/key_language.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/dialog_widget.dart';

class TrackingItem extends StatefulWidget {
  const TrackingItem(
      {super.key, required this.tracking, required this.contentController});

  final Tracking tracking;
  final TextEditingController contentController;

  @override
  State<TrackingItem> createState() => _TrackingItemState();
}

class _TrackingItemState extends State<TrackingItem> {
  ScrollController scrollController = ScrollController();

  RxBool isOpenMenu = false.obs;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(
      () {
        if (scrollController.position.pixels > 70) {
          isOpenMenu.value = true;
        } else {
          isOpenMenu.value = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.1,
      margin: const EdgeInsets.symmetric(
          vertical: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.MARGIN_SIZE_SMALL,
          horizontal: Dimensions.MARGIN_SIZE_SMALL),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
          border: Border.all(
            color: Theme.of(context).disabledColor.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(2.0, 2.0),
              color: Theme.of(context).disabledColor.withOpacity(0.3),
              blurRadius: 3,
            ),
          ]),
      child: Stack(
        children: [
          SizedBox(
            width: size.width - 32.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.tracking.content == "string"
                      ? KeyLanguage.trackingContent.tr
                      : widget.tracking.content!,
                  style: robotoBlack.copyWith(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE),
                ),
                const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Text(
                  widget.tracking.date != null
                      ? DateConverter.dateTimeStringToDateOnly(
                          "${widget.tracking.date!.substring(0, 10)} 00:00:00")
                      : DateTime.now().toString(),
                  style: robotoRegular.copyWith(),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(),
            child: SizedBox(
                width: size.width - 32 + 40 + 40,
                child: Obx(
                  () {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            animateScroll(0.0);
                            isOpenMenu.value = false;
                          },
                          child: Opacity(
                            opacity: 0.0,
                            child: Container(
                              color: ColorResources.getWhiteColor(),
                              width: isOpenMenu.value
                                  ? size.width - 32.0
                                  : size.width - 32.0 - 40,
                            ),
                          ),
                        ),
                        if (!isOpenMenu.value)
                          ButtonTrackingWidget(
                            onTap: () {
                              animateScroll(80.0);
                              isOpenMenu.value = true;
                            },
                            icon: Icons.swipe_left,
                            color: Colors.grey.shade400,
                          ),
                        ButtonTrackingWidget(
                          onTap: () {
                            if (Foundation.kDebugMode) {
                              log('onClick Delete');
                            }
                            showDialog(
                              context: context,
                              builder: (context) => dialogQuestionWidget(
                                context,
                                KeyLanguage.delete.tr,
                                "${KeyLanguage.deleteQuestion.tr} công việc (${widget.tracking.content})?",
                                () {
                                  deleteTracking(widget.tracking);
                                },
                              ),
                            );
                          },
                          icon: Icons.delete,
                          color: Colors.red,
                        ),
                        ButtonTrackingWidget(
                          onTap: () {
                            if (Foundation.kDebugMode) {
                              log('onClick Update');
                              clickUpdate();
                            }
                          },
                          icon: Icons.save_as_outlined,
                          color: Colors.green,
                        ),
                      ],
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  void updateTracking(
      Tracking tracking, TextEditingController contentController) async {
    await animatedLoading();

    tracking.content = contentController.text;
    Get.find<TrackingController>().updateTracking(tracking);
    Get.find<LoadingController>().noLoading();
    contentController.clear();
  }

  void clickUpdate() {
    widget.contentController.text = widget.tracking.content!;
    showDialog(
      context: context,
      builder: (context) {
        return dialogAddWidget(
          context: context,
          textButton: KeyLanguage.save.tr,
          controller: widget.contentController,
          hintText: KeyLanguage.trackingUpdate.tr,
          hasCancel: true,
          onAdd: () {
            updateTracking(
              widget.tracking,
              widget.contentController,
            );
          },
        );
      },
    );
  }

  void deleteTracking(Tracking tracking) async {
    await animatedLoading();

    Get.find<TrackingController>().deleteTracking(tracking);
    Get.find<LoadingController>().noLoading();
    animateScroll(0.0);
  }

  Future<void> animateScroll(double offset) async {
    await scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }
}
