import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news_item.dart';

import '../screens/details_screen.dart';

class SearchItem extends StatefulWidget {
  const SearchItem({super.key, required this.news});
  final List<NewsItem> news;

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  String formatDate(String isoDate) {
    DateTime parsedDate = DateTime.parse(isoDate);
    return DateFormat('MMMM d, y').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.news.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(widget.news[index]),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  // Title
                  SizedBox(
                    width: screenWidth * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        maxLines: 3,
                        widget.news[index].title,
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                    child: SizedBox(
                      width: screenWidth * 0.20,
                      height: 50.0,
                      child: Image.network(
                        widget.news[index].image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            width: screenWidth * 0.2,
                            height: 50.0,
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
                            width: screenWidth * 0.2,
                            height: 50.0,
                            child: Icon(Icons.error, color: Colors.red),
                          ); // If error
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              Text(
                formatDate(widget.news[index].time),
                style: TextStyle(color: Colors.white60),
              ),
              Container(
                height: 0.7,
                color: Colors.white38,
                margin: const EdgeInsets.only(top: 8.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
