import '../../home/data/model/news_response.dart';

class SearchState {
  final UiState uiState;
  final String selectedSource;
  final String sortType;
  final List<Articles> newsItems;

  SearchState({
    this.uiState = const Initial(),
    this.selectedSource = '',
    this.sortType = '',
    this.newsItems = const [],
  });

  SearchState copyWith({
    UiState? uiState,
    String? selectedSource,
    List<Articles>? newsItems,
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

class SuccessResponse<T> extends UiState<T> {
  final T data;

  const SuccessResponse(this.data);
}

class Error<T> extends UiState<T> {
  final String error;

  const Error(this.error);
}
