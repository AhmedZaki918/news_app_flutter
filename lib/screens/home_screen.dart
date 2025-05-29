import 'package:flutter/material.dart';
import 'package:news_app/res/colors.dart';
import 'package:news_app/screens/tab_screen.dart';
import 'package:news_app/util/category_enum.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: HomeWithTabs());
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
          Center(child: TabScreen(tabType: TabType.top)),
          Center(child: TabScreen(tabType: TabType.sports)),
          Center(child: TabScreen(tabType: TabType.technology)),
          Center(child: TabScreen(tabType: TabType.health)),
          Center(child: TabScreen(tabType: TabType.entertainment)),
        ],
      ),
    );
  }
}
