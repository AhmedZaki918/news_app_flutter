import 'package:flutter/material.dart';
import 'package:news_app/model/news_item.dart';
import 'package:news_app/res/colors.dart';

import '../components/clickable_icon.dart';
import '../components/snackbar_message.dart';
import '../util/common.dart';
import '../util/hive_manager.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(this.item, {super.key});

  final NewsItem item;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 16.0, bottom: 16.0),
                      color: Colors.transparent,
                      child: CustomIcon(
                        icon: Icons.arrow_back_ios,
                        padding: EdgeInsets.only(left: 24.0, top: 16.0),
                        onIconPressed: () {
                          Navigator.pop(context);
                        },
                        iconColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    CustomIcon(
                      icon: Icons.share,
                      padding: EdgeInsets.only(right: 8.0, top: 16.0),
                      onIconPressed: () {
                        shareContent(widget.item.url);
                      },
                      iconColor: Colors.white,
                    ),
                    CustomIcon(
                      icon: displaySaveIcon(widget.item.time),
                      padding: EdgeInsets.only(
                        left: 8.0,
                        top: 16.0,
                        right: 8.0,
                      ),
                      onIconPressed: () {
                        if (isArticleSaved(widget.item.time)) {
                          setState(() {
                            deleteArticle(widget.item.time);
                          });
                          showCustomSnackBar(context, 'Item Removed');
                        } else {
                          setState(() {
                            saveArticle(widget.item);
                          });
                          showCustomSnackBar(context, 'Item Saved');
                        }
                      },
                      iconColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 24.0),
              child: Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                widget.item.title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Row(
                children: [
                  Text('By ', style: TextStyle(color: lightGray)),
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      widget.item.author,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 4.0),
              child: Text(
                'Published ${widget.item.time}',
                style: TextStyle(color: lightGray),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                child: Image.network(
                  widget.item.image ?? '',
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
                widget.item.source.name,
                style: TextStyle(color: lightGray),
                textAlign: TextAlign.end,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Text(
                widget.item.description,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Text(
                widget.item.content,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            GestureDetector(
              onTap: () {
                openUrlLink(widget.item.url);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  bottom: 16.0,
                  top: 8.0,
                ),
                child: Text(
                  'Read more..',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
