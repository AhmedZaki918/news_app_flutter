import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/search/logic/search_state.dart';

import '../../../core/network/api_result.dart';
import '../../../util/shared_preferences.dart';
import '../../home/data/model/news_response.dart';
import '../data/search_repo.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _searchRepo;

  SearchCubit(this._searchRepo) : super(SearchState());

  void searchOnNews(String sortType, String keyword) async {
    emit(state.copyWith(uiState: Loading(), sortType: sortType));
    final ApiResult<NewsResponse> response;

    if (state.selectedSource == '' || state.selectedSource == 'all sources') {
      response = await _searchRepo.search(keyword, sortType);
    } else {
      response = await _searchRepo.searchByDomain(
        keyword,
        sortType,
        state.selectedSource,
      );
    }

    response.when(
      success: (newsResponse) async {
        emit(
          state.copyWith(
            uiState: SuccessResponse(newsResponse),
            newsItems: newsResponse.articles,
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(uiState: Error(error.toString())));
      },
    );
  }

  void clearSearchData() {
    emit(state.copyWith(newsItems: [], uiState: Initial()));
  }

  void loadSource() async {
    var source = await getPreference('source_search');
    emit(state.copyWith(selectedSource: source));
  }
}
