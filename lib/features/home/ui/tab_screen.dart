import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/logic/home_cubit.dart';
import 'package:news_app/util/category_enum.dart';

import '../../../core/components/loading_screen.dart';
import '../../../core/components/tab_content.dart';
import '../logic/home_state.dart';
import '../../../util/common.dart';

class TabScreen extends StatefulWidget {
  const TabScreen(this.tabType, {super.key});

  final TabType tabType;

  @override
  State<TabScreen> createState() => _TabScreen();
}

class _TabScreen extends State<TabScreen> {
  @override
  void initState() {
    super.initState();
    getNewsByCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is Loading) {
          return LoadingContent();
        } else if (state is SuccessResponse) {
          return TabContent(
            tabName: capitalizeFirstLetter(widget.tabType.name),
            news: state.data,
          );
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }

  void getNewsByCategory(BuildContext context) {
    context.read<HomeCubit>().emitHomeState(widget.tabType);
  }
}
