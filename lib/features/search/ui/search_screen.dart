import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/res/colors.dart';

import '../../../core/components/clickable_icon.dart';
import '../../../core/components/loading_screen.dart';
import '../logic/search_cubit.dart';
import '../logic/search_state.dart';
import 'search_item.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/network/news_api.dart';
import '../../../main.dart';
import '../../../util/category_enum.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(this.newsApi, {super.key});

  final NewsApi newsApi;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with RouteAware, SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isSearchActive = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _focusNode.addListener(() {
      setState(() {
        _isSearchActive = _focusNode.hasFocus || _controller.text.isNotEmpty;
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
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String sortType = context.read<SearchCubit>().state.sortType;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Container(
            padding: EdgeInsets.only(right: 16.0, bottom: 16.0),
            color: Colors.transparent,
            child: CustomIcon(
              icon: Icons.arrow_back_ios,
              padding: EdgeInsets.only(left: 24.0, top: 16.0),
              onIconPressed: () {
                context.pop();
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
                  suffixIcon: cancelSearch(),
                  hintText: "Find it on NEWS..",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: GestureDetector(
                    onTap: () {
                      if (_controller.text.isNotEmpty) {
                        _focusNode.unfocus();

                        if (isSortTypeExist(sortType)) {
                          initSearch(sortType,_controller.text);
                        } else {
                          initSearch(SortType.publishedAt.name,_controller.text);
                        }
                      }
                    },
                    child: Icon(Icons.search, color: Colors.white70),
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  _controller.value;
                },
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {

                    if (isSortTypeExist(sortType)) {
                      initSearch(sortType,value);
                    } else {
                      initSearch(SortType.publishedAt.name,value);
                    }
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
                          context.push(
                            Routes.searchTabs,
                            extra: TabType.business,
                          );
                        },
                        title: 'Business',
                      ),
                      MainSearchItem(
                        onItemPressed: () {
                          context.push(Routes.searchTabs, extra: TabType.top);
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
                            context.push(
                              Routes.searchTabs,
                              extra: TabType.sports,
                            );
                          },
                          title: 'Sports',
                        ),
                        MainSearchItem(
                          onItemPressed: () {
                            context.push(
                              Routes.searchTabs,
                              extra: TabType.technology,
                            );
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
                            context.push(
                              Routes.searchTabs,
                              extra: TabType.health,
                            );
                          },
                          title: 'Health',
                        ),
                        MainSearchItem(
                          onItemPressed: () {
                            context.push(
                              Routes.searchTabs,
                              extra: TabType.entertainment,
                            );
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
                            context.push(
                              Routes.searchTabs,
                              extra: TabType.general,
                            );
                          },
                          title: 'General',
                        ),
                        MainSearchItem(
                          onItemPressed: () {
                            context.push(
                              Routes.searchTabs,
                              extra: TabType.science,
                            );
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
          Visibility(
            visible: _isSearchActive,
            child: SearchBlocListener(
              onSearchClicked: (sortType) {
                initSearch(sortType,_controller.text);
              },
              searchKeyword: _controller.text,
              tabController: _tabController,
            ),
          ),
        ],
      ),
    );
  }

  void initSearch(String sortType, String keyword) {
    context.read<SearchCubit>().searchOnNews(sortType,keyword);
  }

  bool isSortTypeExist(String sortType) => sortType != '';

  Widget? cancelSearch() {
    if (_isSearchActive) {
      return GestureDetector(
        onTap: () {
          context.read<SearchCubit>().clearSearchData();

          setState(() {
            _controller.clear();
            _focusNode.unfocus();
            _isSearchActive = false;
          });
        },
        child: Icon(Icons.cancel),
      );
    } else {
      return null;
    }
  }
}

class SearchBlocListener extends StatelessWidget {
  const SearchBlocListener({
    super.key,
    required this.onSearchClicked,
    required this.searchKeyword,
    required this.tabController,
  });

  final Function(String sortType) onSearchClicked;
  final String searchKeyword;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        switch (state.uiState) {
          case Loading():
            return LoadingContent();

          case Success():
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
                    child: Visibility(
                      visible: state.newsItems.isNotEmpty,
                      child: Text(
                        '${state.newsItems.length.toString()} Results for "$searchKeyword"',
                        style: TextStyle(color: Colors.white60, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state.newsItems.isNotEmpty,
                    child: Container(
                      color: Colors.grey.shade700,
                      child: TabBar(
                        controller: tabController,
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
                              onSearchClicked(SortType.publishedAt.name);
                              break;
                            case 1:
                              onSearchClicked(SortType.popularity.name);
                              break;
                            case 2:
                              onSearchClicked(SortType.relevancy.name);
                              break;
                          }
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state.newsItems.isNotEmpty,
                    child: SearchItem(news: state.newsItems),
                  ),
                  Visibility(
                    visible: state.newsItems.isEmpty,
                    child: Center(
                      child: Text(
                        'No data has been found!',
                        style: TextStyle(color: Colors.white60, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            );

          case Error():
            return Center(
              child: Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.white60, fontSize: 16.0),
              ),
            );
          default:
            return Center();
        }
      },
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
