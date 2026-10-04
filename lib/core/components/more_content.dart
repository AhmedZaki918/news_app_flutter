import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/components/snackbar_message.dart';

import '../../features/favorite/logic/favorite_cubit.dart';
import '../../features/home/data/model/news_response.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../util/common.dart';
import 'bottom_sheet.dart';

void showMoreContent(
  BuildContext context,
  Articles article,
  bool? isFromFavorite,
  int? favoriteItemId,
) {
  showCustomBottomSheet(
    context: context,
    firstIcon: Icons.share,
    firstLabel: 'Share',
    onSharePressed: () {
      shareContent(article.url);
    },
    secondIcon: isFromFavorite == true ? Icons.bookmark : Icons.bookmark_border,
    secondLabel: isFromFavorite == true ? 'Remove' : 'Save',
    onSavePressed: () {
      if (isFromFavorite == true) {
        context.read<FavoriteCubit>().deleteItem(favoriteItemId!);
        showCustomSnackBar(context, 'Removed from Saved Stories');
      } else {
        context.read<HomeCubit>().saveArticle(article);
        showCustomSnackBar(context, 'Saved to Your News');
      }
    },
  );
}
