import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/favorite/logic/favorite_state.dart';

import '../../../core/database/app_database.dart';
import '../../home/data/model/news_response.dart';
import '../data/favorite_repo.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepo _favoriteRepo;

  FavoriteCubit(this._favoriteRepo) : super(FavoriteState());

  void loadFavorites() async {
    emit(state.copyWith(favoriteUi: Loading()));

    final List<Article> articles;
    articles = await _favoriteRepo.allArticles();

    emit(state.copyWith(articles: articles, favoriteUi: Success()));
  }

  void saveArticle(Articles article) async {
    await _favoriteRepo.addArticle(article);
  }

  void deleteAll() async {
    await _favoriteRepo.deleteAllArticles();
    emit(state.copyWith(articles: []));
  }

  void deleteItem(int id) async {
    await _favoriteRepo.deleteArticle(id);
  }
}
