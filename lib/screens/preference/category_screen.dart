import 'package:flutter/material.dart';
import 'package:news_app/res/colors.dart';
import 'package:news_app/util/shared_preferences.dart';

import '../../components/clickable_icon.dart';
import '../../model/source.dart';
import '../../util/common.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? selectedCategory = '';

  @override
  void initState() {
    super.initState();
    loadCategory();
  }

  void loadCategory() async {
    var category = await loadCategoryInPreferences();
    setState(() {
      selectedCategory = category;
    });
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
          'Category',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: 'LibreBaskerville',
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
            child: Text(
              'Your choice determines the category type you want to filter in search screen.',
              style: TextStyle(color: Colors.white70, fontSize: 16.0),
            ),
          ),
          SizedBox(height: 16.0),
          ListTile(
            title: Text('General', style: TextStyle(color: Colors.white)),
            leading: Radio<String>(
              activeColor: Colors.white,
              value: 'General',
              groupValue: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
                savePreference('category_search', selectedCategory!);
                savePreference('source_search', generalDomains().first);
              },
            ),
          ),
          ListTile(
            title: Text(
              'Business & Finance',
              style: TextStyle(color: Colors.white),
            ),
            leading: Radio<String>(
              activeColor: Colors.white,
              value: 'Business & Finance',
              groupValue: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
                savePreference('category_search', selectedCategory!);
                savePreference('source_search', businessDomains().first);
              },
            ),
          ),
          ListTile(
            title: Text('Tech', style: TextStyle(color: Colors.white)),
            leading: Radio<String>(
              activeColor: Colors.white,
              value: 'Tech',
              groupValue: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
                savePreference('category_search', selectedCategory!);
                savePreference('source_search', techDomains().first);
              },
            ),
          ),
          ListTile(
            title: Text('Sports', style: TextStyle(color: Colors.white)),
            leading: Radio<String>(
              activeColor: Colors.white,
              value: 'Sports',
              groupValue: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
                savePreference('category_search', selectedCategory!);
                savePreference('source_search', sportsDomains().first);
              },
            ),
          ),
          // ListTile(
          //   title: Text(
          //     'Science & Health',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   leading: Radio<String>(
          //     activeColor: Colors.white,
          //     value: 'Science & Health',
          //     groupValue: selectedCategory,
          //     onChanged: (value) {
          //       setState(() {
          //         selectedCategory = value;
          //       });
          //       saveCategory('category_search', selectedCategory!);
          //     },
          //   ),
          // ),
          // ListTile(
          //   title: Text('Entertainment', style: TextStyle(color: Colors.white)),
          //   leading: Radio<String>(
          //     activeColor: Colors.white,
          //     value: 'Entertainment',
          //     groupValue: selectedCategory,
          //     onChanged: (value) {
          //       setState(() {
          //         selectedCategory = value;
          //       });
          //       saveCategory('category_search', selectedCategory!);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
