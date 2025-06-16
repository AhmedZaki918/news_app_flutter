import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/components/loading_screen.dart';
import 'package:news_app/model/saved_news.dart';
import 'package:news_app/res/colors.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/services/news_provider.dart';
import 'package:news_app/util/common.dart';
import 'package:news_app/util/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'navigation/routes.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SavedNewsAdapter());
  await Hive.openBox('newsBox');

  bool isSoundEnabled = await getBoolPreference('sound');
  if (isSoundEnabled) {
    runAudio('news_intro.mp3');
  }

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
  bool isDeviceConnected = false;
  bool isCheckingConnection = true;

  @override
  void initState() {
    super.initState();
    checkNetworkConnection();
    // Change the system navigation bar color to black
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: background),
    );
  }

  Future<void> checkNetworkConnection() async {
    setState(() {
      isCheckingConnection = true;
    });
    bool connection = await checkConnection();
    setState(() {
      isDeviceConnected = connection;
      isCheckingConnection = false;
    });
  }

  Widget screenTitle() {
    if (_currentIndex == 0) {
      return Row(
        children: [
          Expanded(child: Row(children: [])),

          // Center CNN logo
          Text(
            'Your.NEWS',
            style: TextStyle(
              fontFamily: 'LibreBaskerville',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          // Right section with search icon
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                    // Search action here
                  },
                ),
              ],
            ),
          ),
        ],
      );
    } else if (_currentIndex == 1) {
      return Text(
        'Your saved stories',
        style: TextStyle(
          fontFamily: 'LibreBaskerville',
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Center(
        child: Text(
          'Settings',
          style: TextStyle(fontFamily: 'LibreBaskerville', color: Colors.white),
        ),
      );
    }
  }

  Widget mainUi() {
    if (isCheckingConnection) {
      return LoadingContent();
    }

    if (isDeviceConnected) {
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
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50.0),
              Image.asset(
                'images/no_connection.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
              SizedBox(height: 8.0),
              GestureDetector(
                onTap: () {
                  checkNetworkConnection();
                },
                child: Column(
                  children: [
                    Text(
                      'No Connection',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text('Try Again', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
            // child: Text(
            //   'No connection',
            //   style: TextStyle(color: Colors.white, fontSize: 25.0),
            // ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return mainUi();
  }
}
