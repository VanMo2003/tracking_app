import 'package:flutter/material.dart';
import 'package:traking_app/controllers/auth_controller.dart';
import 'package:traking_app/models/response/user_res.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/styles.dart';
import 'package:traking_app/views/widgets/dialog_widget.dart';
import 'package:traking_app/views/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class InfoUserScreen extends StatelessWidget {
  InfoUserScreen({super.key});
  final TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin người dùng"),
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
              showInfo(context, "email", user.email!, editingController, user),
              showInfo(context, "display name", user.displayName!,
                  editingController, user),
              showInfo(context, "university", user.university!,
                  editingController, user),
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
              style: robotoBold.copyWith(
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
              return showDialogCustom(
                hintText: label,
                textButton: "Lưu thay đổi",
                context: context,
                controller: controller,
                onAdd: () {
                  if (label == "email") {
                    user.email = controller.text;
                  } else if (label == "display name") {
                    user.displayName = controller.text;
                  } else if (label == "university") {
                    user.university = controller.text;
                  }

                  Get.find<AuthController>().changeInfoUser(user);
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
