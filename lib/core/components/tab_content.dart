import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/home/data/model/news_response.dart';
import 'package:news_app/features/home/logic/home_state.dart';
import 'package:news_app/util/category_enum.dart';

import '../../res/colors.dart';
import '../../util/common.dart';
import '../navigation/routes.dart';
import 'list_news_item.dart';
import 'more_content.dart';

class TabContent extends StatefulWidget {
  const TabContent({super.key, required this.tabName, required this.state});

  final String tabName;
  final HomeState state;

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var mainItem = widget.state.articles[0];

    return ListView(
      children: [
        GestureDetector(
          onTap: () {
            context.push(Routes.detailsScreen, extra: mainItem);
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
                    mainItem.image ?? '',
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: double.infinity,
                        height: 200.0,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.black38,
                        width:  double.infinity,
                        height: 200.0,
                        child: Center(
                          child: Text(
                            'No photo',
                            style: TextStyle(
                              color: Colors.white24,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      );

                      return SizedBox(width: double.infinity, height: 0.0);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  textAlign: TextAlign.end,
                  mainItem.source!.name,
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
                  mainItem.title.toString(),
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
                      SizedBox(
                        width: screenWidth * 0.80,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            textAlign: TextAlign.start,
                            mainItem.author.toString(),
                            style: TextStyle(color: lightGray, fontSize: 16.0),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          textAlign: TextAlign.start,
                          formatTime(mainItem.time.toString()),
                          style: TextStyle(color: lightGray, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        showMoreContent(context, mainItem, false, 0);
                      },
                      child: Icon(Icons.more_vert, color: lightGray),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ItemList(articles: widget.state.articles),
      ],
    );
  }
}
