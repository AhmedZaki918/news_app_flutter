import 'package:hive/hive.dart';

part 'saved_news.g.dart';

@HiveType(typeId: 0)
class SavedNews {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String time;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String url;

  @HiveField(6)
  final String content;

  @HiveField(7)
  final String source;

  SavedNews({
    required this.time,
    required this.title,
    required this.author,
    required this.url,
    required this.content,
    required this.description,
    required this.image,
    required this.source,
  });
}
