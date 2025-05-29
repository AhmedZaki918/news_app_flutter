import 'package:flutter/material.dart';

import '../res/colors.dart';
import 'list_news_item.dart';

void showCustomBottomSheet({
  required BuildContext context,
  required IconData firstIcon,
  required String firstLabel,
  required Function onFirstItemPressed,
  required IconData secondIcon,
  required String secondLabel,
  required Function onSecondItemPressed,
}) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: gray,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(bottom: 32.0),
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
                onFirstItemPressed.call();
              },
            ),
            BottomSheetItem(
              icon: secondIcon,
              label: secondLabel,
              onItemPressed: () {
                onSecondItemPressed.call();
              },
            ),
          ],
        ),
      );
    },
  );
}
