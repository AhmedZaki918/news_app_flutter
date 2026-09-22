import 'package:flutter/material.dart';
import 'package:news_app/res/colors.dart';

void showCustomSnackBar(
  BuildContext context,
  String message, {
  String actionLabel = '',
  VoidCallback? onActionPressed,
  Color backgroundColor = darkGray,
  Duration duration = const Duration(seconds: 1),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      backgroundColor: backgroundColor,
      duration: duration,
      action:
          actionLabel.isNotEmpty
              ? SnackBarAction(
                label: actionLabel,
                onPressed: onActionPressed ?? () {},
              )
              : null,
    ),
  );
}
