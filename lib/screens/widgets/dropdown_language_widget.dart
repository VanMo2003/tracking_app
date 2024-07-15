import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '/controllers/langue_controller.dart';
import '/utils/color_resources.dart';
import '/utils/dimensions.dart';
import '/utils/styles.dart';
import 'package:get/get.dart';

import '../../services/language_service.dart';

class DropdownLangueWidget extends StatefulWidget {
  const DropdownLangueWidget({super.key});

  @override
  State<DropdownLangueWidget> createState() => _DropdownLangueWidgetState();
}

class _DropdownLangueWidgetState extends State<DropdownLangueWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = Get.find<LanguageController>().getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 70,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
      ),
      child: Center(
        child: DropdownButton(
          value: selectedValue,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
              Get.find<LanguageController>()
                  .changeLocale(selectedValue ?? "vi");
            });
          },
          alignment: Alignment.center,
          items: LanguageService.langCodes.map(
            (e) {
              return DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: robotoBold.copyWith(
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
      ),
    );
  }
}
