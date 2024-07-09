import 'package:flutter/material.dart';

import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../../utils/styles.dart';

class ButtonPrimaryWidget extends StatelessWidget {
  const ButtonPrimaryWidget(
      {super.key, required this.label, required this.onTap});

  final void Function() onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: size.height * 0.06,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
          gradient: ColorResources.gradientButton,
        ),
        child: Center(
          child: Text(
            label,
            style: robotoMedium.copyWith(
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
    );
  }
}
