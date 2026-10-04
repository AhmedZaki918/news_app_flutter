
import '../data/model/news_response.dart';

class HomeState {
  final UiState uiState;
  final List<Articles> articles;
  final bool isLoadingMore;
  final bool hasMore;
  final String tabType;

  HomeState({
    this.uiState = const Initial(),
    this.articles = const [],
    this.hasMore = true,
    this.isLoadingMore = false,
    this.tabType = ''
  });

  HomeState copyWith({
    UiState? uiState,
    List<Articles>? articles,
    bool? hasMore,
    bool? isLoadingMore,
    String? tabType
  }) {
    return HomeState(
      uiState: uiState ?? this.uiState,
      articles: articles ?? this.articles,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      tabType: tabType ?? this.tabType
    );
  }
}

sealed class UiState<T> {
  const UiState();
}

class Initial<T> extends UiState<T> {
  const Initial();
}

class Loading<T> extends UiState<T> {
  const Loading();
}

class SuccessResponse<T> extends UiState<T> {
  const SuccessResponse();
}

class Error<T> extends UiState<T> {
  final String error;

  const Error(this.error);
}
