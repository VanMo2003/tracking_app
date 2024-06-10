import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/views/screens/home/tracking/button_widget.dart';

import '../../../../controllers/loading_controller.dart';
import '../../../../controllers/tracking_controller.dart';
import '../../../../helper/date_converter.dart';
import '../../../../helper/loading_helper.dart';
import '../../../../helper/snackbar_helper.dart';
import '../../../../models/body/tracking.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/language/key_language.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/dialog_add_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.1,
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
          color: ColorResources.getWhiteColor(),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(2.0, 2.0),
              color: ColorResources.getBlackColor().withOpacity(0.1),
              blurRadius: 2,
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
                  style: robotoBold.copyWith(fontSize: 22),
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
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        animateScroll(0.0);
                      });
                    },
                    child: Opacity(
                      opacity: 0.0,
                      child: Container(
                        color: ColorResources.getWhiteColor(),
                        width: size.width - 32.0,
                      ),
                    ),
                  ),
                  ButtonWidget(
                    onTap: () {
                      if (Foundation.kDebugMode) {
                        debugPrint('onClick Delete');
                      }
                      deleteTracking(widget.tracking);
                    },
                    icon: Icons.delete,
                    color: Colors.red,
                  ),
                  ButtonWidget(
                    onTap: () {
                      if (Foundation.kDebugMode) {
                        debugPrint('onClick Update');
                        clickUpdate();
                      }
                    },
                    icon: Icons.save_as_outlined,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateTracking(
      Tracking tracking, TextEditingController contentController) async {
    await animatedLoading();

    tracking.content = contentController.text;
    Get.find<TrackingController>().updateTracking(tracking).then(
      (value) {
        if (value == 200) {
          showCustomSnackBar(
              "${KeyLanguage.updateSuccess.tr}  : ${tracking.content}",
              isError: false);
        } else if (value == 401) {
          showCustomSnackBar(
            KeyLanguage.errorUnauthentication.tr,
          );
        }
      },
    );
    Get.find<LoadingController>().noLoading();
    contentController.clear();
  }

  void clickUpdate() {
    widget.contentController.text = widget.tracking.content!;
    showDialog(
      context: context,
      builder: (context) {
        return showDialogAddWidget(
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

    Get.find<TrackingController>().deleteTracking(tracking).then(
      (value) {
        if (value == 200) {
          showCustomSnackBar(
              "${KeyLanguage.deleteSuccess.tr}  : ${tracking.content}",
              isError: false);
        } else if (value == 401) {
          showCustomSnackBar(
            KeyLanguage.errorUnauthentication.tr,
          );
        }
      },
    );
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
