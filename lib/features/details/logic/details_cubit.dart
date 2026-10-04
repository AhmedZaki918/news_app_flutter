import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/details/data/details_repo.dart';
import 'package:news_app/features/details/logic/details_state.dart';

import '../../home/data/model/news_response.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final DetailsRepo _detailsRepo;

  DetailsCubit(this._detailsRepo) : super(DetailsState());

  Future<void> isItemSaved(String title) async {
    var isSaved = await _detailsRepo.isArticleSaved(title);
    emit(state.copyWith(isArticleSaved: isSaved));
  }

   void saveItem(Articles article) async {
    await _detailsRepo.addArticle(article);
    emit(state.copyWith(isArticleSaved: true));
  }

  void deleteItem(String time) async {
    await _detailsRepo.deleteArticleByTime(time);
    emit(state.copyWith(isArticleSaved: false));
  }
}
