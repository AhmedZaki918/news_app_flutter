import '../../../core/database/app_database.dart';

class FavoriteState {
  final FavoriteUi favoriteUi;
  final List<Article> articles;

  FavoriteState({this.articles = const [], this.favoriteUi = const Initial()});

  FavoriteState copyWith({List<Article>? articles, FavoriteUi? favoriteUi}) {
    return FavoriteState(
      articles: articles ?? this.articles,
      favoriteUi: favoriteUi ?? this.favoriteUi,
    );
  }
}

sealed class FavoriteUi<T> {
  const FavoriteUi();
}

class Initial<T> extends FavoriteUi<T> {
  const Initial();
}

class Loading<T> extends FavoriteUi<T> {
  const Loading();
}

class Success<T> extends FavoriteUi<T> {
  const Success();
}
