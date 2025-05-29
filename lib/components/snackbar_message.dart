import 'package:flutter/material.dart';

void showCustomSnackBar(
  BuildContext context,
  String message, {
  String actionLabel = '',
  VoidCallback? onActionPressed,
  Color backgroundColor = Colors.amber,
  Duration duration = const Duration(seconds: 1),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Colors.black)),
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
