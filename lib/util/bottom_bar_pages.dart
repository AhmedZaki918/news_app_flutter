import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/app_di.dart';
import '../features/home/ui/home_screen.dart';
import '../features/favorite/ui/favorite_screen.dart';
import '../features/settings/logic/settings_cubit.dart';
import '../features/settings/ui/settings_screen.dart';

final List<Widget> pages = [
  HomeScreen(),
  FavoriteScreen(),
  BlocProvider(
    create: (context) => SettingsCubit(getIt())..displayPreferences(),
    child: const SettingsScreen(),
  ),
];
