import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/alert_dialog.dart';
import '../../../core/components/clickable_icon.dart';
import '../../../core/di/app_di.dart';
import '../../../main.dart';
import '../../../res/colors.dart';
import '../logic/favorite_cubit.dart';
import '../logic/favorite_state.dart';
import 'favorite_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit(getIt())..loadFavorites(),
      child: _FavoriteScreen(),
    );
  }
}

class _FavoriteScreen extends StatefulWidget {
  const _FavoriteScreen();

  @override
  State<_FavoriteScreen> createState() => _FavoriteScreenState();
}


class _FavoriteScreenState extends State<_FavoriteScreen> with RouteAware {
  @override
  void didPopNext() {
    context.read<FavoriteCubit>().loadFavorites();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: background,
          body: FavoriteItem(),
          floatingActionButton: Visibility(
            visible: state.articles.isNotEmpty,
            child: FloatingActionButton(
              backgroundColor: gray,
              onPressed: () {
                showDeleteDialog(
                  context: context,
                  onDeleteClicked: () {
                    context.read<FavoriteCubit>().deleteAll();
                  },
                );
              },
              child: CustomIcon(
                icon: Icons.delete_forever,
                padding: const EdgeInsets.all(8.0),
                iconColor: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
