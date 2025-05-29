import '../model/news_item.dart';
import '../util/category_enum.dart';
import 'networking.dart';

const searchApiUrl =
    'https://newsapi.org/v2/everything?language=en&pageSize=50&q=';
const newsApiUrl =
    'https://newsapi.org/v2/top-headlines?language=en&pageSize=50';
const apiKey = 'Your_api_key';

class NewsApi {
  Future<List<NewsItem>> search(String keyword) async {
    var networkHelper = NetworkHelper('$searchApiUrl$keyword&apiKey=$apiKey');
    var newsData = await networkHelper.getData();
    return formatResponseToList(newsData);
  }

  Future<dynamic> getTopNews() async {
    var networkHelper = NetworkHelper('$newsApiUrl&apiKey=$apiKey');
    var newsData = await networkHelper.getData();
    return newsData;
  }

  Future<dynamic> getByCategory(String category) async {
    var networkHelper = NetworkHelper(
      '$newsApiUrl&category=$category&apiKey=$apiKey',
    );
    var newsData = await networkHelper.getData();
    return newsData;
  }

  Future<List<NewsItem>> getNewsList(TabType tabType) async {
    dynamic newsApiResult;
    if (tabType == TabType.top) {
      newsApiResult = await getTopNews();
    } else {
      newsApiResult = await getByCategory(tabType.name);
    }
    return formatResponseToList(newsApiResult);
  }

  List<NewsItem> formatResponseToList(dynamic newsApiResult) {
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
