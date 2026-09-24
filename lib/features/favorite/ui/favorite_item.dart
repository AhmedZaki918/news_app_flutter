import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/database/app_database.dart';
import 'package:news_app/features/favorite/logic/favorite_cubit.dart';
import 'package:news_app/features/home/data/model/news_response.dart';

import '../logic/favorite_state.dart';
import '../../../res/colors.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/components/loading_screen.dart';
import '../../../core/components/more_content.dart';

class FavoriteItem extends StatefulWidget {
  const FavoriteItem({super.key});

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  // THIS FUNCTION WILL BE MOVE TO CUBIT
  Articles convertToArticle(int index) {
    List<Article> data = context.read<FavoriteCubit>().state.articles;

    return Articles(
      title: data[index].title,
      time: data[index].time,
      author: data[index].author,
      url: data[index].url,
      content: data[index].content,
      description: data[index].description,
      image: data[index].image,
      source: Source(name: data[index].source),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state.favoriteUi is Loading) {
          return LoadingContent();
        } else if (state.favoriteUi is Success) {
          if (state.articles.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(state.articles[index].id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  onDismissed: (_) {
                    context.read<FavoriteCubit>().deleteItem(
                      state.articles[index].id,
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      var article = convertToArticle(index);
                      context.push(Routes.detailsScreen, extra: article);
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
                              margin: const EdgeInsets.only(
                                left: 16.0,
                                top: 24.0,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  state.articles[index].image,
                                  width: screenWidth * 0.30,
                                  height: 65.0,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
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
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
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
                                    state.articles[index].title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.start,
                                            state.articles[index].time,
                                            style: TextStyle(color: lightGray),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 16.0,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          //var article = convertToNewsItem(index);
                                          // showMoreContent(
                                          //   context,
                                          //   state.articles as Articles,
                                          //   articlesLength: state.articles.length,
                                          //   isTheLastItem: () {
                                          //     //widget.isTheLastItem(true);
                                          //   },
                                          // );
                                        },
                                        child: Icon(
                                          Icons.more_vert,
                                          color: lightGray,
                                        ),
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
                  ),
                );
              },
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: Text(
                  'No data has been found',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          }
        } else {
          return Center();
        }
      },
    );
  }
}
