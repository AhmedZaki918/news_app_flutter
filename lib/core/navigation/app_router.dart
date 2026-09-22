import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/di/app_di.dart';
import 'package:news_app/core/navigation/routes.dart';
import 'package:news_app/features/search/logic/search_cubit.dart';
import 'package:news_app/screens/favorite_screen.dart';
import 'package:news_app/screens/preference/category_screen.dart';
import 'package:news_app/screens/preference/source_screen.dart';
import 'package:news_app/screens/settings_screen.dart';

import '../../features/home/data/model/news_item.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/search/ui/search_screen.dart';
import '../../main.dart';
import '../../screens/details_screen.dart';
import '../../features/search/ui/search_tabs.dart';
import '../../util/category_enum.dart';
import '../network/news_api.dart';

final GoRouter router = GoRouter(
  observers: [routeObserver],
  routes: [
    GoRoute(
      path: Routes.landingPage,
      builder: (context, state) => const HomePage(),
    ),

    GoRoute(
      path: Routes.homeScreen,
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: Routes.settingsScreen,
      builder: (context, state) => const SettingsScreen(),
    ),

    GoRoute(
      path: Routes.favoriteScreen,
      builder: (context, state) => const FavoriteScreen(),
    ),

    GoRoute(
      path: Routes.categoryScreen,
      builder: (context, state) => const CategoryScreen(),
    ),

    GoRoute(
      path: Routes.sourceScreen,
      builder: (context, state) => const SourceScreen(),
    ),

    GoRoute(
      path: Routes.detailsScreen,
      builder: (context, state) {
        final article = state.extra as NewsItem;
        return DetailsScreen(article);
      },
    ),


    GoRoute(
      path: Routes.searchScreen,
      builder: (context, state) {
        final newsApi = state.extra as NewsApi;
        return BlocProvider(
          create: (context) => SearchCubit(getIt())..loadSource(),
          child: SearchScreen(newsApi),
        );
      },
    ),

    GoRoute(
      path: Routes.searchTabs,
      builder: (context, state) {
        final tab = state.extra as TabType;
        return SearchTabs(tabType: tab);
      },
    ),
  ],
);
