import 'package:hive/hive.dart';

import '../model/news_item.dart';
import '../model/saved_news.dart';

var box = Hive.box('newsBox');

void saveArticle(NewsItem item) {
  box.put(item.time, convertNewsItem(item));
}

void deleteArticle(String key) {
  box.delete(key);
}

bool isArticleSaved(String key) {
  return box.containsKey(key);
}

void clearData() async {
  await box.clear();
}

bool doesDataExist() {
  return box.isNotEmpty;
}

Future<List<SavedNews>> getData() async {
  var box = await Hive.box('newsBox');
  return box.values.cast<SavedNews>().toList();
}

SavedNews convertNewsItem(NewsItem item) {
  // Convert NewsItem to SavedNews
  return SavedNews(
    title: item.title,
    time: item.time,
    author: item.author,
    url: item.url,
    content: item.content,
    description: item.description,
    image: item.image ?? '',
    source: item.source.name,
  );
}
