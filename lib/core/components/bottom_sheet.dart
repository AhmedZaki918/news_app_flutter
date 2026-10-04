import 'package:flutter/material.dart';

import '../../res/colors.dart';
import 'list_news_item.dart';

void showCustomBottomSheet({
  required BuildContext context,
  required IconData firstIcon,
  required String firstLabel,
  required Function onSharePressed,
  required IconData secondIcon,
  required String secondLabel,
  required Function onSavePressed,
}) {
  showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    backgroundColor: gray,
    builder: (BuildContext context) {
      return SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.only(bottom: 16.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BottomSheetItem(
                icon: firstIcon,
                label: firstLabel,
                onItemPressed: () {
                  onSharePressed.call();
                },
              ),
              BottomSheetItem(
                icon: secondIcon,
                label: secondLabel,
                onItemPressed: () {
                  onSavePressed.call();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
