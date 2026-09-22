import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/logic/home_state.dart';
import 'package:news_app/core/network/news_api.dart';

import '../../../util/category_enum.dart';

class HomeCubit extends Cubit<HomeState> {

  final NewsApi _newsApi;
  HomeCubit(this._newsApi) : super(Initial());

  void emitHomeState(TabType tabType) async {
    emit(Loading());

    final newsList = await _newsApi.getNewsList(tabType);
    emit(Success(newsList));
  }
}
