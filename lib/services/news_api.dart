import '../model/news_item.dart';
import '../util/category_enum.dart';
import 'networking.dart';

const searchApiUrl =
    'https://newsapi.org/v2/everything?language=en&pageSize=100&q=';
const newsApiUrl =
    'https://newsapi.org/v2/top-headlines?language=en&pageSize=100';
const apiKey = 'ca9c1cab47bb435ca4288f360849c3d2';

class NewsApi {
  Future<List<NewsItem>> search(String keyword, String sortType) async {
    var networkHelper = NetworkHelper(
      '$searchApiUrl$keyword&sortBy=$sortType&apiKey=$apiKey',
    );
    var newsData = await networkHelper.getData();
    return _formatResponseToList(newsData);
  }

  Future<List<NewsItem>> searchByDomain(
    String keyword,
    String sortType,
    String domain,
  ) async {
    var networkHelper = NetworkHelper(
      '$searchApiUrl$keyword&sortBy=$sortType&domains=$domain&apiKey=$apiKey',
    );
    var newsData = await networkHelper.getData();
    return _formatResponseToList(newsData);
  }

  Future<dynamic> _getTopNews() async {
    var networkHelper = NetworkHelper('$newsApiUrl&apiKey=$apiKey');
    var newsData = await networkHelper.getData();
    return newsData;
  }

  Future<dynamic> _getByCategory(String category) async {
    var networkHelper = NetworkHelper(
      '$newsApiUrl&category=$category&apiKey=$apiKey',
    );
    var newsData = await networkHelper.getData();
    return newsData;
  }

  Future<List<NewsItem>> getNewsList(TabType tabType) async {
    dynamic newsApiResult;
    if (tabType == TabType.top) {
      newsApiResult = await _getTopNews();
    } else {
      newsApiResult = await _getByCategory(tabType.name);
    }
    return _formatResponseToList(newsApiResult);
  }

  List<NewsItem> _formatResponseToList(dynamic newsApiResult) {
    var newsList =
        (newsApiResult['articles'] as List)
            .map(
              (item) => NewsItem(
                title: item['title'] ?? '',
                time: item['publishedAt'] ?? '',
                author: item['author'] ?? '',
                image: item['urlToImage'] ?? '',
                description: item['description'] ?? '',
                content: item['content'] ?? '',
                url: item['url'] ?? '',
                source: Source(name: item['source']['name']),
              ),
            )
            .toList();
    return newsList;
  }
}
