import 'package:flutter/material.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/views/widgets/text_field_widget.dart';
import 'package:get/get.dart';

Widget showDialogAddWidget({
  required BuildContext context,
  required void Function() onAdd,
  required TextEditingController controller,
  required String textButton,
  bool hasCancel = false,
  String? hintText,
}) {
  Dialog dialog = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)), //this right here
    child: SizedBox(
      height: 300.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: TextFieldWidget(
              autoFocus: true,
              controller: controller,
              hintText: hintText ?? KeyLanguage.trackingContent.tr,
            ),
          ),
          const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(ColorResources.getWhiteColor()),
                    // textStyle: WidgetStateProperty.all(
                    //     TextStyle(color: ColorResources.getBlackColor())),
                  ),
                  onPressed: () {
                    onAdd();
                    Navigator.pop(context);
                  },
                  child: Text(textButton),
                ),
                if (hasCancel) ...[
                  const SizedBox(
                    width: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(KeyLanguage.cancel.tr),
                  ),
                ]
              ],
            ),
          )
        ],
      ),
    ),
  );
  return dialog;
}
