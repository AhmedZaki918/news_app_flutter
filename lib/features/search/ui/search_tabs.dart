import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/home/ui/tab_screen.dart';

import '../../../core/components/clickable_icon.dart';
import '../../../core/di/app_di.dart';
import '../../home/logic/home_cubit.dart';
import '../../../res/colors.dart';
import '../../../util/category_enum.dart';
import '../../../util/common.dart';

class SearchTabs extends StatefulWidget {
  const SearchTabs({super.key, required this.tabType});

  final TabType tabType;

  @override
  State<SearchTabs> createState() => _SearchTabsState();
}

class _SearchTabsState extends State<SearchTabs> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child:  Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: background,
          title: Text(
            textAlign: TextAlign.center,
            '${capitalizeFirstLetter(widget.tabType.name)} news',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: CustomIcon(
            icon: Icons.arrow_back_ios,
            padding: EdgeInsets.only(left: 24.0),
            onIconPressed: () {
              context.pop();
            },
            iconColor: Colors.white,
          ),
        ),
        body: TabScreen(widget.tabType),
      ),
    );
  }
}
