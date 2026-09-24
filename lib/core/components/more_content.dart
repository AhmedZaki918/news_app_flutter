import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/components/snackbar_message.dart';

import '../../features/home/data/model/news_response.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../util/common.dart';
import 'bottom_sheet.dart';

void showMoreContent(
  BuildContext context,
  Articles article, {
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
     secondIcon: displaySaveIcon(),
     secondLabel: 'Save',
    onSecondItemPressed: () {
      // if (isArticleSaved(article.time)) {
      //   // Check if this is the last item will be deleted from favorite
      //   if (articlesLength == 1) {
      //     isTheLastItem!.call();
      //   }
      //

        context.read<HomeCubit>().saveArticle(article);
        showCustomSnackBar(context, 'Saved to Your News');


         //deleteArticle(article.time);
      //   showCustomSnackBar(context, 'Removed from Saved Stories');
      // } else {
      //   saveArticle(article);
      // }
    },
  );
}
