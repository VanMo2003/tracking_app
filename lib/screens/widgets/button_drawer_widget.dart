import 'package:flutter/material.dart';
import '/utils/dimensions.dart';
import '/utils/styles.dart';

class ButtonDrawerWidget extends StatelessWidget {
  const ButtonDrawerWidget({
    super.key,
    this.label,
    required this.onTap,
    this.icon,
  });

  final String? label;
  final void Function() onTap;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL))),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {
          onTap();
        },
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
        splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
            vertical: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: Dimensions.SIZE_BOX_HEIGHT_LARGE),
              ],
              Text(
                label ?? "Button",
                style: robotoBlack.copyWith(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
