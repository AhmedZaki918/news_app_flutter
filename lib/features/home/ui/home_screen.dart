import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/logic/home_cubit.dart';
import 'package:news_app/res/colors.dart';
import 'package:news_app/features/home/ui/tab_screen.dart';
import 'package:news_app/util/category_enum.dart';

import '../../../core/di/app_di.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: const  HomeWithTabs(),
    );
  }
}

class HomeWithTabs extends StatefulWidget {
  const HomeWithTabs({super.key});

  @override
  State<HomeWithTabs> createState() => _HomeWithTabsState();
}

class _HomeWithTabsState extends State<HomeWithTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        toolbarHeight: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.amber,
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: Colors.white10,
          tabs: [
            Tab(text: 'Top'),
            Tab(text: 'Sports'),
            Tab(text: 'Tech'),
            Tab(text: 'Health'),
            Tab(text: 'Ent'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: TabScreen(TabType.top)),
          Center(child: TabScreen(TabType.sports)),
          Center(child: TabScreen(TabType.technology)),
          Center(child: TabScreen(TabType.health)),
          Center(child: TabScreen(TabType.entertainment)),
        ],
      ),
    );
  }
}
