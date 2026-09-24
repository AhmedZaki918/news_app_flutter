// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) => NewsResponse(
  articles:
      (json['articles'] as List<dynamic>?)
          ?.map((e) => Articles.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$NewsResponseToJson(NewsResponse instance) =>
    <String, dynamic>{'articles': instance.articles};

Articles _$ArticlesFromJson(Map<String, dynamic> json) => Articles(
  title: json['title'] as String? ?? '',
  time: json['publishedAt'] as String? ?? '',
  author: json['author'] as String? ?? '',
  image: json['urlToImage'] as String? ?? '',
  description: json['description'] as String? ?? '',
  url: json['url'] as String? ?? '',
  content: json['content'] as String? ?? '',
  source:
      json['source'] == null
          ? null
          : Source.fromJson(json['source'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ArticlesToJson(Articles instance) => <String, dynamic>{
  'title': instance.title,
  'publishedAt': instance.time,
  'author': instance.author,
  'urlToImage': instance.image,
  'description': instance.description,
  'content': instance.content,
  'url': instance.url,
  'source': instance.source,
};

Source _$SourceFromJson(Map<String, dynamic> json) =>
    Source(name: json['name'] as String? ?? '');

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
  'name': instance.name,
};
