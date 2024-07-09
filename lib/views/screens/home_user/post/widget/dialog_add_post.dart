import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traking_app/helper/snackbar_helper.dart';

import '../../../../../controllers/auth_controller.dart';
import '../../../../../controllers/post_controller.dart';
import '../../../../../controllers/upload_file_controller.dart';
import '../../../../../models/body/multipart.dart';
import '../../../../../models/body/posts/content.dart';
import '../../../../../models/body/posts/media.dart';
import '../../../../../utils/color_resources.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/language/key_language.dart';
import '../../../../widgets/text_field_widget.dart';

class AddPostDialogWidget extends StatelessWidget {
  const AddPostDialogWidget({
    super.key,
    required this.controller,
    required this.onTap,
    required this.selectedFile,
  });

  final TextEditingController controller;
  final void Function() onTap;
  final File? selectedFile;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: SizedBox(
          height: 300.0,
          width: 300.0,
        ),
      ),
    );
  }
}
