import '../../home/data/model/news_item.dart';

class SearchState {
  final UiState uiState;
  final String selectedSource;
  final String sortType;
  final List<NewsItem> newsItems;

  SearchState({
    this.uiState = const Initial(),
    this.selectedSource = '',
    this.sortType = '',
    this.newsItems = const [],
  });

  SearchState copyWith({
    UiState? uiState,
    String? selectedSource,
    List<NewsItem>? newsItems,
    String? sortType,
    String? searchKeyword
  }) {
    return SearchState(
      uiState: uiState ?? this.uiState,
      selectedSource: selectedSource ?? this.selectedSource,
      newsItems: newsItems ?? this.newsItems,
      sortType: sortType ?? this.sortType
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

class Success<T> extends UiState<T> {
  final T data;

  const Success(this.data);
}

class Error<T> extends UiState<T> {
  final String error;

  const Error(this.error);
}
