import 'package:flutter/material.dart';
import 'package:news_app/components/snackbar_message.dart';

import '../model/news_item.dart';
import '../util/common.dart';
import '../util/hive_manager.dart';
import 'bottom_sheet.dart';

void showMoreContent(
  BuildContext context,
  NewsItem article, {
  int articlesLength = 0,
  Function? isTheLastItem,
}) {
  showCustomBottomSheet(
    context: context,
    firstIcon: Icons.share,
    firstLabel: 'Share',
    onFirstItemPressed: () {
      shareContent(article.url);
    },
    secondIcon: displaySaveIcon(article.time),
    secondLabel: isArticleSaved(article.time) ? 'Remove' : 'Save',
    onSecondItemPressed: () {
      if (isArticleSaved(article.time)) {
        // Check if this is the last item will be deleted from favorite
        if (articlesLength == 1) {
          isTheLastItem!.call();
        }

        deleteArticle(article.time);
        showCustomSnackBar(context, 'Removed from Saved Stories');
      } else {
        saveArticle(article);
        showCustomSnackBar(context, 'Saved to Your News');
      }
    },
  );
}
