import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.icon,
    required this.padding,
    this.onIconPressed,
    required this.iconColor,
  });

  final IconData icon;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onIconPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onIconPressed?.call();
      },
      child: Padding(padding: padding, child: Icon(icon, color: iconColor)),
    );
  }
}
