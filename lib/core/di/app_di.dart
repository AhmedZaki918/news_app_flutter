import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/home/logic/home_cubit.dart';
import 'package:news_app/features/search/logic/search_cubit.dart';

import '../../features/favorite/data/favorite_repo.dart';
import '../../features/favorite/logic/favorite_cubit.dart';
import '../../features/home/data/home_repo.dart';
import '../../features/search/data/search_repo.dart';
import '../database/app_database.dart';
import '../network/api_service.dart';
import '../network/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Drift
  getIt.registerLazySingleton(()=> AppDb());

  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // Home
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt(),getIt()));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));

  // Search
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt()));
  getIt.registerLazySingleton<SearchRepo>(() => SearchRepo(getIt()));

  // Favorite
  getIt.registerFactory<FavoriteCubit>(() => FavoriteCubit(getIt()));
  getIt.registerLazySingleton<FavoriteRepo>(() => FavoriteRepo(getIt()));
}
