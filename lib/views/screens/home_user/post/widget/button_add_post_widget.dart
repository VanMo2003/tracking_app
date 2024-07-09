import 'package:flutter/material.dart';

import '../../../../../utils/color_resources.dart';

class ButtonAddPostWidget extends StatelessWidget {
  const ButtonAddPostWidget(
      {super.key, required this.label, required this.onPressed});

  final void Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(ColorResources.getBlackColor()),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(label),
    );
  }
}
