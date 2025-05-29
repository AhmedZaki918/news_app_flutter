import 'package:flutter/cupertino.dart';

import '../model/news_item.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsItem> newsList = [];

  void updateNews(List<NewsItem> news) {
    newsList = news;
    notifyListeners();
  }
}
