import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/alert_dialog.dart';
import '../../../core/components/clickable_icon.dart';
import 'favorite_item.dart';
import '../../../core/di/app_di.dart';
import '../../../res/colors.dart';
import '../logic/favorite_cubit.dart';
import '../logic/favorite_state.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FavoriteCubit(getIt())..loadFavorites(),
        child: _FavoriteScreen()
    );
  }
}

class _FavoriteScreen extends StatelessWidget {
  const _FavoriteScreen();

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
