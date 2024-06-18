import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/tracking_controller.dart';
import 'package:traking_app/helper/date_converter.dart';
import 'package:traking_app/helper/snackbar_helper.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/views/widgets/dialog_widget.dart';

import '../../../../../controllers/auth_controller.dart';
import '../../../../../controllers/loading_controller.dart';
import '../../../../../helper/loading_helper.dart';
import '../../../../../models/body/tracking.dart';
import '../../../../../utils/color_resources.dart';

import 'tracking_item.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  TextEditingController contentController = TextEditingController();

  var showDelete = false.obs;

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<TrackingController>(
          builder: (controller) {
            if (controller.list == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Tracking> list = controller.list!;

            if (list.isEmpty) {
              return Center(
                child: Text(KeyLanguage.listEmpty.tr),
              );
            }

            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                var tracking = list[index];
                return TrackingItem(
                  tracking: tracking,
                  contentController: contentController,
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

                  return showDialogAdd(
                    textButton: KeyLanguage.add.tr,
                    context: context,
                    controller: contentController,
                    onAdd: () {
                      addTracking(contentController.text);
                    },
                  );
                },
              );
            },
            tooltip: KeyLanguage.add.tr,
            child: Icon(
              Icons.add,
              color: ColorResources.getWhiteColor(),
            ),
          ),
        )
      ],
    );
  }

  void addTracking(String content) async {
    await animatedLoading();

    var userCurrent = Get.find<AuthController>().user;
    Tracking tracking = Tracking(
      content: content,
      date: DateConverter.localDateToIsoString(DateTime.now()),
      user: userCurrent,
    );

    Get.find<TrackingController>().addTracking(tracking).then(
      (value) {
        if (value == 200) {
          showCustomSnackBar("${KeyLanguage.addSuccess.tr} : $content",
              isError: false);
        } else if (value == 401) {
          showCustomSnackBar(KeyLanguage.errorUnauthentication.tr);
        }
      },
    );
    Get.find<LoadingController>().noLoading();
    contentController.clear();
  }
}
