import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traking_app/utils/color_resources.dart';
import 'package:traking_app/utils/dimensions.dart';
import 'package:traking_app/utils/icons.dart';
import 'package:traking_app/utils/styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.label,
    required this.onTap,
    this.child,
    this.icon,
    this.isMenuItem = false,
  });

  final String? label;
  final void Function() onTap;
  final Widget? child;
  final Widget? icon;
  final bool isMenuItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMenuItem
          ? const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_LARGE,
              top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            )
          : const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
            color: ColorResources.getGreyColor().withOpacity(0.5),
          ),
          height: 50,
          child: child ??
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label ?? "Button",
                    style: robotoBlack,
                  ),
                  icon ??
                      Image.asset(
                        IconUtil.back,
                        fit: BoxFit.cover,
                        color: Theme.of(context).dividerColor,
                      ),
                ],
              ),
        ),
      ),
    );
  }
}
