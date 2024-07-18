import 'package:flutter/material.dart';
import '/utils/dimensions.dart';
import '/utils/language/key_language.dart';
import 'text_field_widget.dart';
import 'package:get/get.dart';
import '/utils/styles.dart';

Widget dialogUpdateWidget(
  BuildContext context, {
  required Widget child,
  required void Function() opTap,
}) {
  final key = GlobalKey<FormState>();

  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)), //this right here
    child: SizedBox(
      height: 300.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_OVER_LARGE,
            ),
            child: Form(
              key: key,
              child: child,
            ),
          ),
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).primaryColor),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        opTap();
                        Navigator.pop(context);
                      }
                    },
                    child: Text(KeyLanguage.save.tr),
                  ),
                  const SizedBox(
                    width: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).primaryColor.withOpacity(0.2)),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(KeyLanguage.cancel.tr),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget dialogAddWidget({
  required BuildContext context,
  required void Function() onAdd,
  required TextEditingController controller,
  required String textButton,
  bool hasCancel = false,
  String? hintText,
}) {
  final key = GlobalKey<FormState>();

  Dialog dialog = Dialog(
    elevation: 1,
    shadowColor: Theme.of(context).disabledColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)), //this right here
    child: SizedBox(
      height: 200.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Form(
              key: key,
              child: TextFieldWidget(
                autoFocus: true,
                controller: controller,
                hintText: hintText ?? KeyLanguage.trackingContent.tr,
              ),
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
                        WidgetStateProperty.all(Theme.of(context).primaryColor),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      onAdd();
                      Navigator.pop(context);
                    }
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
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).primaryColor),
                      foregroundColor:
                          WidgetStateProperty.all(Theme.of(context).cardColor),
                    ),
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

Widget dialogQuestionWidget(
  BuildContext context,
  String label,
  String question,
  void Function() agree,
) {
  return AlertDialog(
    elevation: 3,
    shadowColor: Theme.of(context).disabledColor,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: Text(label),
    content: Text(
      question,
      style: robotoBlack.copyWith(
        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      ),
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
              Theme.of(context).primaryColor.withOpacity(0.2)),
          foregroundColor: WidgetStateProperty.all(Colors.white),
        ),
        child: Text(KeyLanguage.cancel.tr),
      ),
      ElevatedButton(
        onPressed: () {
          // SystemChannels.platform.invokeMethod(
          //     'SystemNavigator.pop'); // thoát app
          agree();
          Navigator.of(context).pop(false);
        },
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(Theme.of(context).primaryColor),
          foregroundColor: WidgetStateProperty.all(Colors.white),
        ),
        child: Text(KeyLanguage.yes.tr),
      ),
    ],
  );
}
