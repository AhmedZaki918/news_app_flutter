
import 'dart:developer';

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../home/data/model/news_response.dart';

class DetailsRepo {
  final AppDb db;

  DetailsRepo(this.db);

  Future<bool> isArticleSaved(String title) async {
    try {
      final article =
      await (db.select(
        db.articles,
      )..where((article) => article.title.equals(title))).getSingleOrNull();

      return article != null;
    } catch (e) {
      return false;
    }
  }


  deleteArticleByTime(String time) async {
    try {
      await (db.delete(db.articles)
        ..where((article) => article.time.equals(time))).go();
    } catch (e) {
      log(e.toString());
    }
  }


  addArticle(Articles article) async {
    ArticlesCompanion articlesCompanion = ArticlesCompanion(
      title: Value(article.title.toString()),
      url: Value(article.url.toString()),
      author: Value(article.author.toString()),
      content: Value(article.content.toString()),
      description: Value(article.description.toString()),
      image: Value(article.image.toString()),
      time: Value(article.time.toString()),
      source: Value(article.source!.name),
    );

    try {
      await db.into(db.articles).insertOnConflictUpdate(articlesCompanion);
    } catch (e) {
      log(e.toString());
    }
  }
}