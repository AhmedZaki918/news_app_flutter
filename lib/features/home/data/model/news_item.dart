class NewsItem {
  NewsItem({
    this.title = '',
    this.time = '',
    this.author = '',
    this.image = '',
    this.description = '',
    this.url = '',
    this.content = '',
    Source? source,
  }) : source = source ?? Source();

  String title;
  String time;
  String author;
  String? image;
  String description;
  String content;
  String url;
  Source source;
}

class Source {
  Source({this.name = ''});
  String name;
}
