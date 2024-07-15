import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:traking_app/utils/asset_util.dart';

import '../../theme/theme_controller.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (controller) => FlutterSwitch(
        width: 60.0,
        height: 35.0,
        toggleSize: 30.0,
        value: controller.darkTheme,
        padding: 4.0,
        activeToggleColor: Color.fromARGB(255, 70, 111, 133),
        activeColor: Color(0xFF008FFF),
        inactiveColor: Color(0xFF54C5F8),
        activeIcon: Icon(Icons.dark_mode),
        inactiveIcon: Icon(Icons.light_mode),
        onToggle: (val) {
          Get.find<ThemeController>().toggleTheme();
        },
      ),
    );
  }
}
