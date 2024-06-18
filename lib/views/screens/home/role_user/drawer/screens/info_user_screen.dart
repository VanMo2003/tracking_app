import 'package:flutter/material.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/models/response/user_res.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:traking_app/utils/styles.dart';
import 'package:traking_app/views/widgets/dialog_widget.dart';
import 'package:get/get.dart';

class InfoUserScreen extends StatefulWidget {
  const InfoUserScreen({super.key});

  @override
  State<InfoUserScreen> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen> {
  final TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyLanguage.infoPerson.tr),
        centerTitle: true,
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          var user = controller.user;
          if (user == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              showInfo(context, KeyLanguage.email.tr,
                  user.email ?? "example@gmail.com", editingController, user),
              showInfo(
                  context,
                  KeyLanguage.displayName.tr,
                  user.displayName ?? KeyLanguage.displayName.tr,
                  editingController,
                  user),
              showInfo(
                  context,
                  KeyLanguage.university.tr,
                  user.university ?? KeyLanguage.university.tr,
                  editingController,
                  user),
            ],
          );
        },
      ),
    );
  }

  Widget showInfo(BuildContext context, String label, String content,
      TextEditingController controller, UserRes user) {
    return ListTile(
      title: RichText(
        text: TextSpan(
          style: robotoMedium.copyWith(
              fontSize: 16, color: ColorResources.getBlackColor()),
          children: <TextSpan>[
            TextSpan(
              text: "$label : ",
              style: robotoBlack.copyWith(
                  fontSize: 18, color: ColorResources.getBlackColor()),
            ),
            TextSpan(text: content),
          ],
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          controller.text = content;

          showDialog(
            context: context,
            builder: (context) {
              return showDialogAdd(
                hintText: label,
                textButton: KeyLanguage.save.tr,
                context: context,
                controller: controller,
                onAdd: () {
                  if (label == KeyLanguage.email.tr) {
                    user.email = controller.text;
                  } else if (label == KeyLanguage.displayName.tr) {
                    user.displayName = controller.text;
                  } else if (label == KeyLanguage.university.tr) {
                    user.university = controller.text;
                  }

                  Get.find<AuthController>().updateMyself(user);
                },
              );
            },
          );
        },
        icon: const Icon(Icons.save_as_outlined),
      ),
    );
  }
}
