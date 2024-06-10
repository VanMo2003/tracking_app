import 'package:flutter/material.dart';
import 'package:traking_app/models/response/user_res.dart';
import 'package:traking_app/utils/language/key_language.dart';
import 'package:get/get.dart';

class DetailUserScreen extends StatelessWidget {
  const DetailUserScreen({super.key, required this.user});

  final UserRes user;

  @override
  Widget build(BuildContext context) {
    var safePaddingTop = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text(user.displayName ?? KeyLanguage.displayName.tr),
          ),
          Positioned(
            top: safePaddingTop,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }
}
