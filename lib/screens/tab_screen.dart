import 'package:flutter/material.dart';
import 'package:news_app/model/news_item.dart';
import 'package:news_app/util/category_enum.dart';
import 'package:provider/provider.dart';

import '../components/loading_screen.dart';
import '../components/tab_content.dart';
import '../services/news_api.dart';
import '../services/news_provider.dart';
import '../util/common.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key, required this.tabType});

  final TabType tabType;

  @override
  State<TabScreen> createState() => _TabScreen();
}

class _TabScreen extends State<TabScreen> {
  List<NewsItem> newsItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getNewsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    context.read<NewsProvider>().updateNews(newsItems);

    if (isLoading) {
      return LoadingContent();
    } else {
      return TabContent(tabName: capitalizeFirstLetter(widget.tabType.name));
    }
  }

  void getNewsByCategory() async {
    var news = await NewsApi().getNewsList(widget.tabType);
    setState(() {
      isLoading = false;
      newsItems = news;
    });
  }
}
