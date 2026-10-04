import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/details/logic/details_cubit.dart';
import 'package:news_app/features/home/data/model/news_response.dart';
import 'package:news_app/res/colors.dart';

import '../../../core/components/clickable_icon.dart';
import '../../../core/components/snackbar_message.dart';
import '../../../util/common.dart';
import '../logic/details_state.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(this.item, {super.key});

  final Articles item;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
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
                          icon:
                              state.isArticleSaved
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                          padding: EdgeInsets.only(
                            left: 8.0,
                            top: 16.0,
                            right: 8.0,
                          ),
                          onIconPressed: () {
                            if (state.isArticleSaved) {
                              context.read<DetailsCubit>().deleteItem(
                                widget.item.time.toString(),
                              );
                              showCustomSnackBar(context, 'Removed from Saved Stories',);
                            } else {
                              context.read<DetailsCubit>().saveItem(widget.item);
                              showCustomSnackBar(context, 'Saved to Your News');
                            }
                          },
                          iconColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 24.0,
                    right: 16.0,
                  ),
                  child: Text(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    widget.item.title.toString(),
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
                          widget.item.author.toString(),
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                  child: Text(
                    'Published ${formatTime(widget.item.time.toString())}',
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
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
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
                    widget.item.source!.name,
                    style: TextStyle(color: lightGray),
                    textAlign: TextAlign.end,
                  ),
                ),

                Visibility(
                  visible: widget.item.description!.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Text(
                      widget.item.description.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),

                Visibility(
                  visible: widget.item.content!.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 24.0,
                      right: 24.0,
                    ),
                    child: Text(
                      widget.item.content.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                ReadMore(
                  widget: widget,
                  isContentExist: widget.item.content!.isNotEmpty,
                  isDescriptionExist: widget.item.description!.isNotEmpty,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ReadMore extends StatelessWidget {
  const ReadMore({
    super.key,
    required this.widget,
    required this.isContentExist,
    required this.isDescriptionExist,
  });

  final DetailsScreen widget;
  final bool isContentExist;
  final bool isDescriptionExist;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openUrlLink(widget.item.url);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Visibility(
            visible: !isDescriptionExist && !isContentExist,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                bottom: 16.0,
                top: 4.0,
                right: 8.0,
              ),
              child: Text(
                textAlign: TextAlign.end,
                'Read more..',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Visibility(
            visible: isDescriptionExist && isContentExist,
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
    );
  }
}
