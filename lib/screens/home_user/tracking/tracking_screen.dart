import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../views/custom_snackbar.dart';
import '/controllers/tracking_controller.dart';
import '/helper/date_converter_hepler.dart';
import '/utils/dimensions.dart';
import '/utils/language/key_language.dart';
import '../../widgets/dialog_widget.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/loading_controller.dart';
import '../../../helper/loading_helper.dart';
import '../../../data/models/body/tracking.dart';

import 'widgets/tracking_item.dart';

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

            return Padding(
              padding: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var tracking = list[index];
                  return TrackingItem(
                    tracking: tracking,
                  );
                },
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  contentController.clear();
                  return dialogAddWidget(
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
              color: Theme.of(context).canvasColor,
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
          showCustomSnackBar(
              "${KeyLanguage.addSuccess.tr} : ${tracking.content}",
              isError: false);
        }

        animatedNoLoading();
      },
    );
    contentController.clear();
  }
}
