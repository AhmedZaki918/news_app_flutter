import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:news_app/core/database/app_database.dart';

import '../../home/data/model/news_response.dart';

class FavoriteRepo {
  final AppDb db;

  FavoriteRepo(this.db);

  Future<List<Article>> allArticles() async {
    try {
      return await db.select(db.articles).get();
    } catch (e) {
      return [];
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

  deleteArticle(int id) async {
    try {
      await (db.delete(db.articles)
        ..where((article) => article.id.equals(id))).go();
    } catch (e) {
      log(e.toString());
    }
  }

  deleteAllArticles() async {
    try {
      await db.delete(db.articles).go();
    } catch (e) {
      log(e.toString());
    }
  }
}
