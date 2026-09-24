import 'package:json_annotation/json_annotation.dart';

part 'news_response.g.dart';

@JsonSerializable()
class NewsResponse {
  List<Articles>? articles;

  NewsResponse({this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);
}

@JsonSerializable()
class Articles{
  String? title ;
  @JsonKey(name: 'publishedAt')
  String? time;
  String? author ;
  @JsonKey(name: 'urlToImage')
  String? image;
  String? description;
  String? content ;
  String? url;
  Source? source;

  Articles({
    this.title = '',
    this.time = '',
    this.author = '',
    this.image = '',
    this.description  = '' ,
    this.url  = '',
    this.content  = '',
    this.source,
  });

  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);
}

@JsonSerializable()
class Source {
  String name;

  Source({this.name = ''});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  //Map<String, dynamic> toJson() => _$SourceToJson(this);
}
