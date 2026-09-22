import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/search/logic/search_state.dart';

import '../../../core/network/news_api.dart';
import '../../../util/shared_preferences.dart';
import '../../home/data/model/news_item.dart';

class SearchCubit extends Cubit<SearchState> {
  final NewsApi _newsApi;

  SearchCubit(this._newsApi) : super(SearchState());

  void searchOnNews(String sortType, String keyword) async {
    emit(state.copyWith(uiState: Loading(), sortType: sortType));
    List<NewsItem> news = [];

    try{
      if (state.selectedSource == '' || state.selectedSource == 'all sources') {
        news = await _newsApi.search(keyword, sortType);
      } else {
        news = await _newsApi.searchByDomain(
          keyword,
          sortType,
          state.selectedSource,
        );
      }
      emit(state.copyWith(uiState: Success(news), newsItems: news));

    } catch (error){
      emit(state.copyWith(uiState: Error(error.toString())));
    }
  }

  void clearSearchData() {
    emit(state.copyWith(newsItems: [], uiState: Initial()));
  }

  void loadSource() async {
    var source = await getPreference('source_search');
    emit(state.copyWith(selectedSource: source));
  }
}
