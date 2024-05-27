import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/theme_controller.dart';
import 'package:traking_app/controllers/tracking_controller.dart';
import 'package:traking_app/helper/date_converter.dart';
import 'package:traking_app/helper/snackbar_helper.dart';
import 'package:traking_app/models/body/tracking_model.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/views/widgets/dialog_widget.dart';
import 'package:traking_app/views/screens/home/drawer/widgets/drawer_widget.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/loading_controller.dart';
import '../../../../helper/loading_helper.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/styles.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController contentController = TextEditingController();

  var showDelete = false.obs;

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GetBuilder<TrackingController>(
          builder: (controller) {
            if (controller.list == []) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: controller.list.length,
              itemBuilder: (context, index) {
                var tracking = controller.list[index];
                return Container(
                  height: size.height * 0.1,
                  margin: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                      color: ColorResources.getWhiteColor(),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(2.0, 2.0),
                          color:
                              ColorResources.getBlackColor().withOpacity(0.1),
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
                              tracking.content == "string"
                                  ? "Nội dung theo dõi"
                                  : tracking.content!,
                              style: robotoBold.copyWith(fontSize: 22),
                            ),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_SMALL),
                            Text(
                              tracking.date != null
                                  ? DateConverter.dateTimeStringToDateOnly(
                                      "${tracking.date!.substring(0, 10)} 00:00:00")
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
                                    color: Colors.white,
                                    width: size.width - 32.0,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  debugPrint('onClick Delete');
                                  deleteTracking(tracking);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  height: double.infinity,
                                  width: 40,
                                  child: const Center(
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  contentController.text = tracking.content!;
                                  debugPrint('onClick Update');
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return showDialogCustom(
                                        context: context,
                                        textButton: "Lưu",
                                        controller: contentController,
                                        hintText: "Chỉnh sửa theo dõi",
                                        hasCancel: true,
                                        onAdd: () {
                                          updateTracking(tracking);
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  height: double.infinity,
                                  width: 40,
                                  child: const Center(
                                    child: Icon(
                                      Icons.save_as_outlined,
                                      color: Colors.green,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: FloatingActionButton(
            backgroundColor: ColorResources.getPrimaryColor().withOpacity(0.8),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  contentController.clear();

                  return showDialogCustom(
                    textButton: "Thêm",
                    context: context,
                    controller: contentController,
                    onAdd: () {
                      addTracking(contentController.text);
                    },
                  );
                },
              );
            },
            tooltip: "Thêm tracking",
            child: Icon(
              Icons.add,
              color: ColorResources.getWhiteColor(),
            ),
          ),
        )
      ],
    );
  }

  void deleteTracking(TrackingBody tracking) async {
    await animatedLoading();

    Get.find<TrackingController>().deleteTracking(tracking).then(
      (value) {
        if (value == 200) {
          showCustomSnackBar("Xóa thành công  : ${tracking.content}",
              isError: false);
        } else if (value == 401) {
          showCustomSnackBar(
            "Không có quyền truy cập",
          );
        }
      },
    );
    Get.find<LoadingController>().noLoading();
    animateScroll(0.0);
  }

  void updateTracking(TrackingBody tracking) async {
    await animatedLoading();

    tracking.content = contentController.text;
    Get.find<TrackingController>().updateTracking(tracking).then(
      (value) {
        if (value == 200) {
          showCustomSnackBar("Sửa thành công  : ${tracking.content}",
              isError: false);
        } else if (value == 401) {
          showCustomSnackBar(
            "Không có quyền truy cập",
          );
        }
      },
    );
    Get.find<LoadingController>().noLoading();
    contentController.clear();
  }

  void addTracking(String content) async {
    await animatedLoading();

    var userCurrent = Get.find<AuthController>().user;
    TrackingBody tracking = TrackingBody(
      content: content,
      date: DateConverter.localDateToIsoString(DateTime.now()),
      user: userCurrent,
    );

    Get.find<TrackingController>().addTracking(tracking).then(
      (value) {
        if (value == 200) {
          showCustomSnackBar("Thêm tracking thành công : $content",
              isError: false);
        } else if (value == 401) {
          showCustomSnackBar("Không có quyền truy cấp");
        }
      },
    );
    Get.find<LoadingController>().noLoading();
    contentController.clear();
  }

  Future<void> animateScroll(double offset) async {
    await scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }
}
