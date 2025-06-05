import 'package:flutter/material.dart';

import '../../components/clickable_icon.dart';
import '../../model/source.dart';
import '../../res/colors.dart';
import '../../util/common.dart';
import '../../util/shared_preferences.dart';

class SourceScreen extends StatefulWidget {
  const SourceScreen({super.key});

  @override
  State<SourceScreen> createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
  String? selectedSource = '';
  String? selectedCategory = '';

  @override
  void initState() {
    super.initState();
    updateNewsSource();
  }

  void updateNewsSource() async {
    var category = await loadCategoryInPreferences();
    var source = await loadSourceInPreferences();
    setState(() {
      selectedCategory = category;
      selectedSource = source;
    });
  }

  Widget displaySourceList() {
    List<String> sources = [];
    if (selectedCategory == 'General') {
      sources = generalDomains();
    } else if (selectedCategory == 'Sports') {
      sources = sportsDomains();
    } else if (selectedCategory == 'Business & Finance') {
      sources = businessDomains();
    } else {
      sources = techDomains();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sources.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(sources[index], style: TextStyle(color: Colors.white)),
          leading: Radio<String>(
            activeColor: Colors.white,
            value: sources[index],
            groupValue: selectedSource,
            onChanged: (value) {
              setState(() {
                selectedSource = value;
              });
              savePreference('source_search', selectedSource!);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(right: 16.0, bottom: 16.0),
            color: Colors.transparent,
            child: CustomIcon(
              icon: Icons.arrow_back_ios,
              padding: EdgeInsets.only(left: 24.0, top: 16.0),
              onIconPressed: () {
                Navigator.pop(context);
              },
              iconColor: Colors.white,
            ),
          ),
        ),
        backgroundColor: background,
        title: Text(
          'Source',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: 'LibreBaskerville',
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
            child: Text(
              'Your choice determines the source of the news you want in search screen.',
              style: TextStyle(color: Colors.white70, fontSize: 16.0),
            ),
          ),
          SizedBox(height: 16.0),
          displaySourceList(),
        ],
      ),
    );
  }
}
