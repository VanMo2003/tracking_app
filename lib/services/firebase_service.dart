import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/controllers/auth_controller.dart';

import '../models/response/user_res.dart';

class FirebaseService {
  static Future saveUserToken(String token) async {
    UserRes user = Get.find<AuthController>().user!;
    Map<String, dynamic> data = {
      "username": user.username,
      "token_device": token,
    };
    try {
      await FirebaseFirestore.instance
          .collection("user_data")
          .doc(user.id.toString())
          .set(data);
      debugPrint('document added to ${user.id}');
    } catch (e) {
      debugPrint('error in saving to firestore : ${e.toString()}');
    }
  }

  static Future removeCurrentUserToken() async {
    UserRes user = Get.find<AuthController>().user!;
    try {
      debugPrint('begin remove device token');
      await FirebaseFirestore.instance
          .collection("user_data")
          .doc(user.id.toString())
          .delete();
      debugPrint('document remove to ${user.id}');
    } catch (e) {
      debugPrint('error in saving to firestore : ${e.toString()}');
    }
  }
}
