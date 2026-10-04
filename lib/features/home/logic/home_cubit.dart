import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/data/home_repo.dart';
import 'package:news_app/features/home/logic/home_state.dart';

import '../../../core/network/api_result.dart';
import '../../../util/category_enum.dart';
import '../../favorite/data/favorite_repo.dart';
import '../data/model/news_response.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  final FavoriteRepo _favoriteRepo;

  HomeCubit(this._homeRepo, this._favoriteRepo) : super(HomeState());

  void emitHomeState(TabType tabType) async {
    emit(state.copyWith(uiState: Loading()));
    final ApiResult<NewsResponse> response;

    response = await _homeRepo.category(tabType.name);

    response.when(
      success: (newsResponse) async {
        emit(
          state.copyWith(
            uiState: SuccessResponse(),
            articles: newsResponse.articles,
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(uiState: Error(error.toString())));
      },
    );
  }

  void saveArticle(Articles article) async {
    await _favoriteRepo.addArticle(article);
  }
}
