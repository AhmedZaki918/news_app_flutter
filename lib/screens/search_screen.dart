import 'package:flutter/material.dart';
import 'package:news_app/components/loading_screen.dart';
import 'package:news_app/res/colors.dart';
import 'package:news_app/screens/search_tabs.dart';
import 'package:news_app/util/request_enum.dart';

import '../components/search_item.dart';
import '../main.dart';
import '../model/news_item.dart';
import '../services/news_api.dart';
import '../util/category_enum.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with RouteAware {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isSearchActive = false;
  List<NewsItem> newsItems = [];
  RequestStatus requestStatus = RequestStatus.idle;
  String searchKeyword = '';
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isSearchActive = _focusNode.hasFocus || searchKeyword.isNotEmpty;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget? displayCancelSearch() {
    if (_isSearchActive) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _controller.clear();
            _focusNode.unfocus();
            newsItems = [];
            _isSearchActive = false;
            searchKeyword = '';
            errorMessage = '';
          });
        },
        child: Icon(Icons.cancel),
      );
    } else {
      return null;
    }
  }

  Widget searchContent() {
    if (requestStatus == RequestStatus.loading) {
      return LoadingContent();
    } else if (requestStatus == RequestStatus.success) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
              child: Visibility(
                visible: newsItems.isNotEmpty,
                child: Text(
                  '${newsItems.length.toString()} Results for "$searchKeyword"',
                  style: TextStyle(color: Colors.white60, fontSize: 16.0),
                ),
              ),
            ),
            SearchItem(news: newsItems),
          ],
        ),
      );
    } else if (requestStatus == RequestStatus.error) {
      return Center(
        child: Text(errorMessage, style: TextStyle(color: Colors.white)),
      );
    } else {
      return Center();
    }
  }

  void searchOnNews(String keyword) async {
    setState(() {
      requestStatus = RequestStatus.loading;
    });
    var news = await NewsApi().search(keyword);
    setState(() {
      if (news.isNotEmpty) {
        newsItems = news;
        requestStatus = RequestStatus.success;
      } else {
        errorMessage = 'No data has been found..';
        requestStatus = RequestStatus.error;
      }
    });
  }

  navigateTo(TabType tabType) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchTabs(tabType: tabType)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: gray,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              style: TextStyle(color: Colors.grey),
              controller: _controller,
              focusNode: _focusNode,
              showCursor: _isSearchActive,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                suffixIcon: displayCancelSearch(),
                hintText: "Find it on NEWS..",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: GestureDetector(
                  onTap: () {
                    if (searchKeyword.isNotEmpty) {
                      _focusNode.unfocus();
                      searchOnNews(searchKeyword);
                    }
                  },
                  child: Icon(Icons.search, color: Colors.white70),
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  searchKeyword = value;
                });
              },
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  searchOnNews(searchKeyword);
                }
              },
            ),
          ),
        ),
        Visibility(
          visible: !_isSearchActive,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MainSearchItem(
                      onItemPressed: () {
                        navigateTo(TabType.business);
                      },
                      title: 'Business',
                    ),
                    MainSearchItem(
                      onItemPressed: () {
                        navigateTo(TabType.top);
                      },
                      title: 'Top',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MainSearchItem(
                        onItemPressed: () {
                          navigateTo(TabType.sports);
                        },
                        title: 'Sports',
                      ),
                      MainSearchItem(
                        onItemPressed: () {
                          navigateTo(TabType.technology);
                        },
                        title: 'Tech',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MainSearchItem(
                        onItemPressed: () {
                          navigateTo(TabType.health);
                        },
                        title: 'Health',
                      ),
                      MainSearchItem(
                        onItemPressed: () {
                          navigateTo(TabType.entertainment);
                        },
                        title: 'Entertainment',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MainSearchItem(
                        onItemPressed: () {
                          navigateTo(TabType.general);
                        },
                        title: 'General',
                      ),
                      MainSearchItem(
                        onItemPressed: () {
                          navigateTo(TabType.science);
                        },
                        title: 'Science',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(visible: _isSearchActive, child: searchContent()),
      ],
    );
  }
}

class MainSearchItem extends StatelessWidget {
  const MainSearchItem({
    super.key,
    required this.title,
    required this.onItemPressed,
  });

  final String title;
  final Function onItemPressed;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        onItemPressed.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: gray,
          borderRadius: BorderRadius.circular(8),
        ),
        width: screenWidth * 0.44,
        height: 55.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              Icon(Icons.arrow_forward_ios, color: lightGray, size: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
