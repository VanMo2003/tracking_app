import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traking_app/models/response/user_res.dart';
import 'package:get/get.dart';
import 'package:traking_app/views/screens/home/list_user/detail_user.dart';

import '../../../../utils/color_resources.dart';
import '../../../../utils/language/key_language.dart';
import '../../../../utils/styles.dart';

class ListUserItem extends StatelessWidget {
  const ListUserItem({super.key, required this.user});

  final UserRes user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: ColorResources.getWhiteColor(),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2.0, 2.0),
            color: ColorResources.getBlackColor().withOpacity(0.1),
            blurRadius: 2,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      height: size.height * 0.1,
      width: double.infinity,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 20,
          child: user.image != null
              ? Image.asset(user.image!)
              : const Icon(Icons.image),
        ),
        title: Text(
          user.displayName ?? KeyLanguage.displayName.tr,
          style: robotoBold.copyWith(fontSize: 20),
        ),
        subtitle: Text(
          user.email ?? KeyLanguage.email.tr,
          style: robotoRegular.copyWith(fontSize: 15),
        ),
        trailing: IconButton(
          onPressed: () {
            Get.to(
              DetailUserScreen(user: user),
            );
          },
          icon: const Icon(Icons.visibility),
        ),
      ),
    );
  }
}
