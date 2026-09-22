import 'package:get_it/get_it.dart';
import 'package:news_app/features/home/logic/home_cubit.dart';
import 'package:news_app/features/search/logic/search_cubit.dart';

import '../network/news_api.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // News API
  getIt.registerLazySingleton<NewsApi>(() => NewsApi());

  // Home
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

  // Search
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt()));
}
