import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:news_app/res/colors.dart';
import 'package:news_app/screens/preference/category_screen.dart';
import 'package:news_app/screens/preference/source_screen.dart';

import '../main.dart';
import '../util/common.dart';
import '../util/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with RouteAware {
  String? selectedCategory = '';
  bool isSoundEnabled = false;

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
  void didPopNext() {
    displayPreferences();
  }

  @override
  void initState() {
    super.initState();
    displayPreferences();
  }

  String? selectedSource = '';

  void displayPreferences() async {
    bool sound = await getBoolPreference('sound');
    var category = await loadCategoryInPreferences();
    var source = await loadSourceInPreferences();
    setState(() {
      isSoundEnabled = sound;
      selectedCategory = category;
      selectedSource = source;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          SettingsName(title: 'SEARCH PREFERENCE'),
          PreferenceTile(
            title: 'Category',
            value: selectedCategory.toString(),
            onItemPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryScreen()),
              );
            },
            isLastItem: false,
          ),
          PreferenceTile(
            title: 'Source',
            value: selectedSource.toString(),
            onItemPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SourceScreen()),
              );
            },
            isLastItem: true,
          ),
          SizedBox(height: 16.0),
          SettingsName(title: 'AUDIO'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 16.0, left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      'Enable this sound',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    Text(
                      'A sound effect when you open the app',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                child: FlutterSwitch(
                  activeToggleColor: Colors.red.shade200,
                  width: 55.0,
                  height: 26.0,
                  toggleSize: 30.0,
                  borderRadius: 30.0,
                  padding: 4.0,
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey,
                  value: isSoundEnabled,
                  onToggle: (value) {
                    setState(() {
                      isSoundEnabled = value;
                    });
                    saveBoolPreference('sound', value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsName extends StatelessWidget {
  const SettingsName({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: gray,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Text(title, style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class PreferenceTile extends StatelessWidget {
  const PreferenceTile({
    required this.value,
    required this.title,
    required this.onItemPressed,
    required this.isLastItem,
    super.key,
  });

  final String title;
  final String value;
  final Function onItemPressed;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemPressed.call();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(value, style: TextStyle(color: Colors.white70)),
          ),
          Visibility(
            visible: !isLastItem,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Container(height: 0.7, color: Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }
}
