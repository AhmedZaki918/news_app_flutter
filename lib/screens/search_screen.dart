import 'package:flutter/material.dart';
import 'package:news_app/components/loading_screen.dart';
import 'package:news_app/res/colors.dart';
import 'package:news_app/screens/search_tabs.dart';
import 'package:news_app/util/request_enum.dart';

import '../components/clickable_icon.dart';
import '../components/search_item.dart';
import '../main.dart';
import '../model/news_item.dart';
import '../services/news_api.dart';
import '../util/category_enum.dart';
import '../util/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with RouteAware, SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isSearchActive = false;
  List<NewsItem> newsItems = [];
  RequestStatus requestStatus = RequestStatus.idle;
  String searchKeyword = '';
  String errorMessage = '';
  String? selectedSource = '';
  String sortType = SortType.publishedAt.name;

  @override
  void initState() {
    super.initState();
    loadSource();

    _tabController = TabController(length: 3, vsync: this);
    _focusNode.addListener(() {
      setState(() {
        _isSearchActive = _focusNode.hasFocus || searchKeyword.isNotEmpty;
      });
    });
  }

  late TabController _tabController;

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
    _tabController.dispose();
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
            Visibility(
              visible: newsItems.isNotEmpty,
              child: Container(
                color: Colors.grey.shade700,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.amber,
                  indicatorSize: TabBarIndicatorSize.label,
                  dividerColor: Colors.white10,
                  tabs: [
                    Tab(text: 'Newest'),
                    Tab(text: 'Popular'),
                    Tab(text: 'Relevance'),
                  ],
                  onTap: (int index) {
                    switch (index) {
                      case 0:
                        setState(() {
                          sortType = SortType.publishedAt.name;
                        });
                        searchOnNews(searchKeyword);
                        break;
                      case 1:
                        setState(() {
                          sortType = SortType.popularity.name;
                        });
                        searchOnNews(searchKeyword);
                        break;
                      case 2:
                        setState(() {
                          sortType = SortType.relevancy.name;
                        });
                        searchOnNews(searchKeyword);
                        break;
                    }
                  },
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
    List<NewsItem> news = [];

    setState(() {
      requestStatus = RequestStatus.loading;
    });

    if (selectedSource == '' || selectedSource == 'all sources') {
      news = await NewsApi().search(keyword, sortType);
    } else {
      news = await NewsApi().searchByDomain(
        keyword,
        sortType,
        selectedSource.toString(),
      );
    }

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

  void loadSource() async {
    var source = await getPreference('source_search');

    setState(() {
      selectedSource = source;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
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
        backgroundColor: background,
        title: Text(
          'Explore',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: 'LibreBaskerville',
          ),
        ),
      ),
      body: ListView(
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
      ),
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
