import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/res/colors.dart';

import '../../features/favorite/logic/favorite_cubit.dart';

void showDeleteDialog({
  required BuildContext context,
  required VoidCallback  onDeleteClicked,
}) {
  showDialog(
    context: context,
    builder: ( dialogContext) {
      return AlertDialog(
        title: Text("Delete All", style: TextStyle(color: Colors.white)),
        content: Text(
          "Are you sure you want to delete all articles from favorites? This action cannot be undo.",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () {
              dialogContext.pop();
            },
            child: Text("Cancel", style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              onDeleteClicked.call();
              dialogContext.pop();
            },
            child: Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
        backgroundColor: gray,
      );
    },
  );
}
