import 'package:flutter/material.dart';
import 'package:news_app/screens/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../res/colors.dart';
import '../services/news_provider.dart';
import '../util/common.dart';
import 'clickable_icon.dart';
import 'more_content.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  String formatTime(String time) {
    final dateTime = DateTime.parse(time).toLocal();
    return timeago.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var news = context.watch<NewsProvider>().newsList;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: news.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(news[index]),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Line
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
                        news[index].image ?? '',
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
                          if (isImageNullOrEmpty(news[index].image)) {
                            return Container(
                              color: Colors.black38,
                              width: screenWidth * 0.30,
                              height: 65.0,
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
                          } else {
                            return SizedBox(
                              width: screenWidth * 0.30,
                              height: 65.0,
                              child: Icon(Icons.error, color: Colors.red),
                            );
                          }
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
                        padding: const EdgeInsets.only(right: 30.0),
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
                                SizedBox(
                                  width: 150.0,
                                  child: Text(
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    news[index].author,
                                    style: TextStyle(color: lightGray),
                                  ),
                                ),

                                Text(
                                  textAlign: TextAlign.start,
                                  formatTime(news[index].time),
                                  style: TextStyle(color: lightGray),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                var article = news[index];
                                showMoreContent(context, article);
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

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({
    required this.onItemPressed,
    required this.icon,
    required this.label,
    super.key,
  });

  final IconData icon;
  final String label;
  final Function onItemPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemPressed.call();
        Navigator.pop(context);
      },
      child: Row(
        children: [
          CustomIcon(
            icon: icon,
            padding: EdgeInsets.only(left: 16.0, top: 32.0),
            onIconPressed: () {
              Navigator.pop(context);
              onItemPressed.call();
            },
            iconColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16.0),
            child: Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
