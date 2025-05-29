import 'package:flutter/material.dart';
import 'package:news_app/model/news_item.dart';
import 'package:news_app/model/saved_news.dart';
import 'package:news_app/screens/details_screen.dart';
import 'package:news_app/util/hive_manager.dart';

import '../res/colors.dart';
import 'more_content.dart';

class FavoriteItem extends StatefulWidget {
  const FavoriteItem({super.key, required this.isTheLastItem});

  final ValueChanged<bool> isTheLastItem;

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  List<SavedNews> news = [];

  void fetchData() async {
    var data = await getData();
    setState(() {
      news = data;
    });
  }

  NewsItem convertToNewsItem(int index) {
    return NewsItem(
      title: news[index].title,
      time: news[index].time,
      author: news[index].author,
      url: news[index].url,
      content: news[index].content,
      description: news[index].description,
      image: news[index].image,
      source: Source(name: news[index].source),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    fetchData();

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: news.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            var article = convertToNewsItem(index);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailsScreen(article)),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.15,
                    height: 0.7,
                    color: lightGray,
                    margin: const EdgeInsets.only(left: 16.0, top: 24.0),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        news[index].image,
                        width: screenWidth * 0.30,
                        height: 65.0,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            width: screenWidth * 0.30,
                            height: 65.0,
                            child: Center(
                              child: SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ); // While loading
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            width: screenWidth * 0.30,
                            height: 65.0,
                            child: Icon(Icons.error, color: Colors.red),
                          ); // If error
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          maxLines: 5,
                          news[index].title,
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  news[index].time,
                                  style: TextStyle(color: lightGray),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                var article = convertToNewsItem(index);
                                showMoreContent(
                                  context,
                                  article,
                                  articlesLength: news.length,
                                  isTheLastItem: () {
                                    widget.isTheLastItem(true);
                                  },
                                );
                              },
                              child: Icon(Icons.more_vert, color: lightGray),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
