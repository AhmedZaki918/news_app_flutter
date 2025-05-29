import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/colors.dart';
import '../screens/details_screen.dart';
import '../services/news_provider.dart';
import 'list_news_item.dart';
import 'more_content.dart';

class TabContent extends StatefulWidget {
  const TabContent({super.key, required this.tabName});

  final String tabName;

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  @override
  Widget build(BuildContext context) {
    var news = context.watch<NewsProvider>().newsList;
    var mainItem = news[5];

    return ListView(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailsScreen(mainItem)),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 24.0),
                child: Text(
                  widget.tabName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    mainItem.image,
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: double.infinity,
                        height: 70.0,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(width: double.infinity, height: 0.0);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  textAlign: TextAlign.end,
                  mainItem.source.name,
                  style: TextStyle(color: lightGray, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Text(
                  textAlign: TextAlign.start,
                  mainItem.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          textAlign: TextAlign.start,
                          mainItem.author,
                          style: TextStyle(color: lightGray, fontSize: 16.0),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          textAlign: TextAlign.start,
                          mainItem.time,
                          style: TextStyle(color: lightGray, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        showMoreContent(context, mainItem);
                      },
                      child: Icon(Icons.more_vert, color: lightGray),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ItemList(),
      ],
    );
  }
}
