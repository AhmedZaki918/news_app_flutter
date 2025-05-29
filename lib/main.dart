import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/model/saved_news.dart';
import 'package:news_app/res/colors.dart';
import 'package:news_app/services/news_provider.dart';
import 'package:provider/provider.dart';

import 'navigation/routes.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SavedNewsAdapter());
  await Hive.openBox('newsBox');

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => NewsProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      navigatorObservers: [routeObserver],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Change the system navigation bar color to black
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: background),
    );
  }

  Widget screenTitle() {
    if (_currentIndex == 0) {
      return Center(
        child: Text('News App', style: TextStyle(color: Colors.white)),
      );
    } else if (_currentIndex == 1) {
      return Text(
        'Your saved stories',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Center(
        child: Text('Search', style: TextStyle(color: Colors.white)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(backgroundColor: background, title: screenTitle()),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: lightGray,
        backgroundColor: gray,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            screenTitle();
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}
