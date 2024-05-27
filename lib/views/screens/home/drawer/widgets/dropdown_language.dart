import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traking_app/controllers/langue_controller.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/utils/styles.dart';
import 'package:get/get.dart';

import '../../../../../services/language_service.dart';

class DropdownLangue extends StatefulWidget {
  const DropdownLangue({super.key});

  @override
  State<DropdownLangue> createState() => _DropdownLangueState();
}

class _DropdownLangueState extends State<DropdownLangue> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = Get.find<LanguageController>().getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      height: 30,
      child: DropdownButton(
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
            Get.find<LanguageController>().changeLocale(selectedValue ?? "vi");
          });
        },
        alignment: Alignment.center,
        items: LanguageService.langCodes.map(
          (e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: robotoMedium.copyWith(
                  fontSize: 18,
                  color: ColorResources.getBlackColor(),
                ),
              ),
            );
          },
        ).toList(),
        icon: Icon(
          Icons.arrow_drop_down,
          color: ColorResources.getBlackColor(),
        ),
        underline: const SizedBox(),
      ),
    );
  }
}
