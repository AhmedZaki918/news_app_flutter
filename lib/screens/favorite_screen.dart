import 'package:flutter/material.dart';
import 'package:news_app/components/alert_dialog.dart';
import 'package:news_app/components/clickable_icon.dart';
import 'package:news_app/util/hive_manager.dart';

import '../components/favorite_item.dart';
import '../main.dart';
import '../res/colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with RouteAware {
  var areDataStored = doesDataExist();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() async {
    var data = await getData();
    if (data.isEmpty) {
      setState(() {
        areDataStored = false;
      });
    }
  }

  Widget displayFavoriteScreen() {
    if (areDataStored) {
      return ListView(
        children: [
          FavoriteItem(
            isTheLastItem: (value) {
              if (value) {
                setState(() {
                  areDataStored = false;
                });
              }
            },
          ),
        ],
      );
    } else {
      // Empty
      return Center(
        child: Text(
          'No data has been found',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: displayFavoriteScreen(),
      floatingActionButton: Visibility(
        visible: areDataStored,
        child: FloatingActionButton(
          backgroundColor: gray,
          onPressed: () {
            showDeleteDialog(
              context: context,
              onDeleteClicked: () {
                clearData();
                setState(() {
                  areDataStored = false;
                });
              },
            );
          },
          child: CustomIcon(
            icon: Icons.delete_forever,
            padding: EdgeInsets.all(8.0),
            iconColor: Colors.grey,
            onIconPressed: () {
              showDeleteDialog(
                context: context,
                onDeleteClicked: () {
                  clearData();
                  setState(() {
                    areDataStored = false;
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
