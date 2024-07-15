import 'package:flutter/material.dart';

class ButtonTrackingWidget extends StatelessWidget {
  const ButtonTrackingWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.color,
  });

  final void Function() onTap;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        height: double.infinity,
        width: 40,
        child: Center(
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
      ),
    );
  }
}
